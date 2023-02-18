package controllers

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"reflect"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"golang.org/x/crypto/bcrypt"

	database "jaunnt-backend/database"
	helpers "jaunnt-backend/helpers"
	"jaunnt-backend/models"
	utils "jaunnt-backend/utils"
	"math/rand"
	"strconv"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var userCollection *mongo.Collection = database.OpenCollection(database.Client, "user")
var validate = validator.New()

func HashPassword(password string) string {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	if err != nil {
		log.Panic(err)
	}
	return string(bytes)
}

func VerifyPassword(userPassword string, providedPassword string) (bool, string) {
	err := bcrypt.CompareHashAndPassword([]byte(providedPassword), []byte(userPassword))
	check := true
	msg := ""

	if err != nil {
		msg = fmt.Sprintf("password is incorrect")
		check = false
	}
	return check, msg
}
func VerifyUserOtp(userOtp string, providedOtp string) (bool, string) {

	valid := reflect.DeepEqual(userOtp, providedOtp)
	check := true
	msg := "Otp is correct"
	if !valid {
		msg = fmt.Sprintf("Otp is incorrect")
		check = false
	}

	return check, msg
}

func Signup() gin.HandlerFunc {

	return func(c *gin.Context) {
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)
		var user models.User

		if err := c.BindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		validationErr := validate.Struct(user)
		if validationErr != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": validationErr.Error()})
			return
		}

		count, err := userCollection.CountDocuments(ctx, bson.M{"email": user.Email})
		defer cancel()
		if err != nil {
			log.Panic(err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "error occured while checking for email"})
			return
		}
		if count > 0 {

			c.JSON(http.StatusInternalServerError, gin.H{"error": "this email already exsits"})
			return
		}

		password := HashPassword(*user.Password)
		user.Password = &password

		countt, errr := userCollection.CountDocuments(ctx, bson.M{"phonenumber": user.PhoneNumber})
		defer cancel()
		if errr != nil {
			log.Panic(errr)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "error occured while checking for phone"})
			return
		}

		if countt > 0 {

			c.JSON(http.StatusInternalServerError, gin.H{"error": "phone number already exsits"})
			return
		}
		num := (rand.Intn(999999))
		randomOtp := strconv.Itoa(num)

		user.CreatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		user.UpdatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		user.Id = primitive.NewObjectID()
		user.UserId = user.Id.Hex()
		token, refreshToken, _ := helpers.GenerateAllTokens(*user.Email, *user.FullName, *user.PhoneNumber, *user.UserRole, *user.ProfilePhoto, user.UserId)
		user.Token = &token
		user.VerifyUser = false
		user.VerifyOtp = &randomOtp
		user.RefreshToken = &refreshToken

		resultInsertionNumber, insertErr := userCollection.InsertOne(ctx, user)

		if insertErr != nil {
			msg := fmt.Sprintf("User item was not created")
			c.JSON(http.StatusInternalServerError, gin.H{"error": msg})
			return
		}

		if err := utils.SendOtp(randomOtp, *user.PhoneNumber); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		defer cancel()
		c.JSON(http.StatusOK, resultInsertionNumber)
	}
}

func VerifyUser() gin.HandlerFunc {
	return func(c *gin.Context) {
		// userId := c.Param("userId")
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)
		var user models.User
		var foundUser models.User
		userId := c.Param("userId")
		filter := bson.M{"userid": userId}
		defer cancel()

		if err := c.BindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		errr := userCollection.FindOne(ctx, bson.M{"phonenumber": user.PhoneNumber}).Decode(&foundUser)
		if errr != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "user or otp doesnt exist"})
			return
		}

		otpIsValid, msg := VerifyUserOtp(*user.VerifyOtp, *foundUser.VerifyOtp)
		defer cancel()
		if !otpIsValid {
			c.JSON(http.StatusInternalServerError, gin.H{"error": msg})
			return
		}
		user.VerifyUser = true
		var updateObj primitive.D
		if user.VerifyUser {
			updateObj = append(updateObj, bson.E{"verifyuser", user.VerifyUser})
		}
		if user.VerifyOtp != nil {
			updateObj = append(updateObj, bson.E{"verifyotp", user.VerifyOtp})
		}

		user.UpdatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		updateObj = append(updateObj, bson.E{"updatedat", user.UpdatedAt})
		upsert := true
		opt := options.UpdateOptions{
			Upsert: &upsert,
		}
		result, err := userCollection.UpdateOne(
			ctx,
			filter,
			bson.D{{"$set", updateObj}},
			&opt,
		)
		if err != nil {
			msg := fmt.Sprintf("verification update failed")
			c.JSON(http.StatusInternalServerError, gin.H{"error": msg})
			return
		}
		defer cancel()
		c.JSON(http.StatusOK, result)
	}

}

func Login() gin.HandlerFunc {
	return func(c *gin.Context) {
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)
		var user models.User
		var foundUser models.User

		defer cancel()

		if err := c.BindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		err := userCollection.FindOne(ctx, bson.M{"email": user.Email}).Decode(&foundUser)

		errr := userCollection.FindOne(ctx, bson.M{"phonenumber": user.PhoneNumber}).Decode(&foundUser)
		if errr != nil || err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "phone number or email or password is incorrect"})
			return
		}

		passwordIsValid, msg := VerifyPassword(*user.Password, *foundUser.Password)
		defer cancel()
		if !passwordIsValid {
			c.JSON(http.StatusInternalServerError, gin.H{"error": msg})
			return
		}

		if foundUser.PhoneNumber == nil || foundUser.Email == nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "user not found"})
		}

		token, refreshToken, _ := helpers.GenerateAllTokens(*foundUser.PhoneNumber, *foundUser.FullName, *foundUser.PhoneNumber, *foundUser.ProfilePhoto, *foundUser.UserRole, foundUser.UserId)
		helpers.UpdateAllTokens(token, refreshToken, foundUser.UserId)
		err = userCollection.FindOne(ctx, bson.M{"userid": foundUser.UserId}).Decode(&foundUser)

		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		// vusers := userCollection.FindOne(ctx, bson.M{"userId": foundUser.UserId}).Decode(&foundUser.VerifyUser)

		err = userCollection.FindOne(ctx, bson.M{"userid": foundUser.UserId}).Decode(&foundUser)
		defer cancel()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		fmt.Print(foundUser.VerifyUser)
		if !foundUser.VerifyUser {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "user not verified"})
			return
		}

		c.JSON(200, gin.H{"success": "verified"})
		c.JSON(http.StatusOK, foundUser)
	}
}

func GetUsers() gin.HandlerFunc {
	return func(c *gin.Context) {
		if err := helpers.CheckUserRole(c, "ADMIN"); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)

		recordPerPage, err := strconv.Atoi(c.Query("recordPerPage"))
		if err != nil || recordPerPage < 1 {
			recordPerPage = 10
		}
		page, err1 := strconv.Atoi(c.Query("page"))
		if err1 != nil || page < 1 {
			page = 1
		}

		startIndex := (page - 1) * recordPerPage
		startIndex, err = strconv.Atoi(c.Query("startIndex"))

		matchStage := bson.D{{"$match", bson.D{{}}}}
		groupStage := bson.D{{"$group", bson.D{
			{"_id", bson.D{{"_id", "null"}}},
			{"totalCount", bson.D{{"$sum", 1}}},
			{"data", bson.D{{"$push", "$$ROOT"}}}}}}
		projectStage := bson.D{
			{"$project", bson.D{{"_id", 0}, {"totalCount", 1}, {"userItems", bson.D{{"$slice", []interface{}{"$data", startIndex, recordPerPage}}}}}}}
		result, err := userCollection.Aggregate(ctx, mongo.Pipeline{matchStage, groupStage, projectStage})
		defer cancel()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "error occured while listing user items"})
		}
		var allusers []bson.M
		if err = result.All(ctx, &allusers); err != nil {
			log.Fatal(err)
		}

		c.JSON(200, gin.H{"success": "working"})

		c.JSON(http.StatusOK, allusers[0])
	}
}

func GetUser() gin.HandlerFunc {
	return func(c *gin.Context) {
		userId := c.Param("userId")

		if err := helpers.MatchUserTypetoUid(c, userId); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)

		var user models.User
		err := userCollection.FindOne(ctx, bson.M{"userId": userId}).Decode(&user)
		defer cancel()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(200, gin.H{"success": "working"})
		c.JSON(http.StatusOK, user)
	}
}
