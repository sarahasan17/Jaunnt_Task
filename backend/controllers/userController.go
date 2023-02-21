package controllers

import (
	"context"
	"fmt"
	"log"

	"net/http"
	"reflect"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"golang.org/x/crypto/bcrypt"

	database "jaunnt-backend/database"
	helpers "jaunnt-backend/helpers"
	"jaunnt-backend/models"

	"crypto/rand"
	// utils "jaunnt-backend/utils"
	"math/big"

	"github.com/ucarion/redact"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"strconv"
	"time"
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

func GenerateOTPCode(length int) (string, error) {
	seed := "012345679"
	byteSlice := make([]byte, length)

	for i := 0; i < length; i++ {
		max := big.NewInt(int64(len(seed)))
		num, err := rand.Int(rand.Reader, max)
		if err != nil {
			return "", err
		}

		byteSlice[i] = seed[num.Int64()]
	}

	return string(byteSlice), nil
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
		role := "USER"

		user.UserRole = &role
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
		randomOtp, err := GenerateOTPCode(6)
		if err != nil {
			c.JSON(500, gin.H{"error": "otp number didnt generate"})
			return
		}
		// randomOtp := strconv.Itoa(num)
		user.CreatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		user.UpdatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		user.Id = primitive.NewObjectID()
		user.UserId = user.Id.Hex()
		token, refreshToken, _ := helpers.GenerateAllTokens(*user.Email, *user.FullName, *user.PhoneNumber, *user.UserRole, *user.ProfilePhoto, user.UserId)
		user.Token = &token
		user.VerifyUser = false
		user.VerifyOtp = &randomOtp
		user.Active = true
		user.RefreshToken = &refreshToken

		resultInsertionNumber, insertErr := userCollection.InsertOne(ctx, user)

		if insertErr != nil {
			msg := fmt.Sprintf("User item was not created")
			c.JSON(http.StatusInternalServerError, gin.H{"error": msg})
			return
		}

		// if err := utils.SendOtp(randomOtp, *user.PhoneNumber); err != nil {
		// 	c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		// 	return
		// }
		defer cancel()
		c.JSON(200, gin.H{"token": user.Token})
		c.JSON(http.StatusOK, resultInsertionNumber)
	}
}

func VerifyUser() gin.HandlerFunc {
	return func(c *gin.Context) {
		// userId := c.Param("userId")
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)
		var user models.User
		var foundUser models.User
		// userId := c.Param("userId")
		token := c.Request.Header.Get("token")

		filter := bson.M{"token": token}
		defer cancel()

		if err := c.BindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		// errr := userCollection.FindOne(ctx, bson.M{"phonenumber": user.PhoneNumber}).Decode(&foundUser)
		// if errr != nil {
		// 	c.JSON(http.StatusInternalServerError, gin.H{"error": "user or otp doesnt exist"})
		// 	return
		// }
		errr := userCollection.FindOne(ctx, bson.M{"token": token}).Decode(&foundUser)
		if errr != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "user doesnt exists"})
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
			updateObj = append(updateObj, bson.E{Key: "verifyuser", Value: user.VerifyUser})
		}
		if user.VerifyOtp != nil {
			updateObj = append(updateObj, bson.E{Key: "verifyotp", Value: user.VerifyOtp})
		}

		user.UpdatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		updateObj = append(updateObj, bson.E{Key: "updatedat", Value: user.UpdatedAt})
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
		if !user.Active {
			c.JSON(200, gin.H{"error": "user is already deleted"})
			return
		}

		err := userCollection.FindOne(ctx, bson.M{"email": user.Email}).Decode(&foundUser)

		errr := userCollection.FindOne(ctx, bson.M{"phonenumber": user.PhoneNumber}).Decode(&foundUser)
		if errr != nil && err != nil {
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

		redact.Redact([]string{"Password"}, &foundUser)

		c.JSON(http.StatusOK, foundUser)

	}
}

func GetUsers() gin.HandlerFunc {
	return func(c *gin.Context) {
		var user models.User
		if !user.Active {
			c.JSON(200, gin.H{"error": "user is deleted"})
			return
		}

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
		groupStage := bson.D{{Key: "$group", Value: bson.D{
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

		redact.Redact([]string{"password"}, &allusers)

		c.JSON(200, gin.H{"success": "working"})
		c.JSON(http.StatusOK, allusers[0])
	}
}

func GetUser() gin.HandlerFunc {
	return func(c *gin.Context) {
		tok := c.Request.Header.Get("token")
		token, err := jwt.Parse(tok, nil)
		if token == nil {
			c.JSON(http.StatusInternalServerError, err.Error())
		}
		claims, _ := token.Claims.(jwt.MapClaims)
		userID := claims["Uid"]
		userId := fmt.Sprint(userID)

		fmt.Printf(userId)

		var userr models.User
		if !userr.Active {
			c.JSON(200, gin.H{"error": "user is deleted"})
			return
		}
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)

		var user models.User
		errr := userCollection.FindOne(ctx, bson.M{"userid": userId}).Decode(&user)
		defer cancel()
		if errr != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, user)
	}
}

func DeleteUser() gin.HandlerFunc {
	return func(c *gin.Context) {
		tok := c.Request.Header.Get("token")
		token, err := jwt.Parse(tok, nil)
		if token == nil {
			c.JSON(http.StatusInternalServerError, err.Error())
		}
		claims, _ := token.Claims.(jwt.MapClaims)
		userID := claims["Uid"]
		userId := fmt.Sprint(userID)
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)
		
		fmt.Printf(userId)
		
		// active := false
		var user models.User
		if !user.Active {
			c.JSON(200, gin.H{"error": "user is already deleted"})
			return
		}
		defer cancel()

		var updateObj primitive.D

		updateObj = append(updateObj, bson.E{Key: "active", Value: false})
		filter := bson.M{"userid": userId}
		user.UpdatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		updateObj = append(updateObj, bson.E{Key: "updatedat", Value: user.UpdatedAt})
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
		// errr := userCollection.FindOneAndUpdate(ctx, query, update, options.FindOneAndUpdate().SetReturnDocument(1))
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		defer cancel()
		c.JSON(http.StatusOK, result)
		c.JSON(200, gin.H{"success": "user deleted"})

	}

}
