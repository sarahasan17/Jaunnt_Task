package controllers

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"log"
	"net/http"
	"time"

	"fmt"
	"github.com/dgrijalva/jwt-go"
	database "jaunnt-backend/database"
	"jaunnt-backend/models"
)

var travelPlanCollection *mongo.Collection = database.OpenCollection(database.Client, "travelPlan")
var validateTravelPlan = validator.New()

func PostTravelPlan() gin.HandlerFunc {
	return func(c *gin.Context) {
		var ctx, cancel = context.WithTimeout(context.Background(), 100*time.Second)

		tok := c.Request.Header.Get("token")
		token, err := jwt.Parse(tok, nil)
		if token == nil {
			c.JSON(http.StatusInternalServerError, err.Error())
		}
		defer cancel()
		claims, _ := token.Claims.(jwt.MapClaims)
		// fmt.Print(claims)
		userID := claims["Uid"]
		userFullName := claims["FullName"]
		userName := fmt.Sprint(userFullName)
		userId := fmt.Sprint(userID)
		fmt.Printf(userId)
		fmt.Printf(userName)
		var travelplan models.TravelPlan
		if err := c.BindJSON(&travelplan); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		validateTravelPlan := validate.Struct(travelplan)

		if validateTravelPlan != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": validateTravelPlan.Error()})
			return
		}
		defer cancel()
		travelplan.CreatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		travelplan.UpdatedAt, _ = time.Parse(time.RFC3339, time.Now().Format(time.RFC3339))
		travelplan.Id = primitive.NewObjectID()
		travelplan.PosterUserid = &userId
		travelplan.PostedBy = &userName
		travelplan.TravelPlanId = travelplan.Id.Hex()

		response, insertErr := travelPlanCollection.InsertOne(ctx, travelplan)

		if insertErr != nil {
			msg := fmt.Sprintf("Travel plan not created")
			c.JSON(http.StatusInternalServerError, gin.H{"error": msg})
			return
		}

		defer cancel()
		c.JSON(http.StatusOK, response)

	}
}

func GetUserTravelPlans() gin.HandlerFunc {
	return func(c *gin.Context) {
		var ctx, cancle = context.WithTimeout(context.Background(), 100*time.Second)
		userId := c.Param("posteruserid")
		result, err := travelPlanCollection.Find(ctx, bson.M{"posteruserid": userId})
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "error occured while getting user posts items"})
		}
		defer cancle()
		var allTravelPlans []bson.M
		if err = result.All(ctx, &allTravelPlans); err != nil {
			log.Fatal(err)
		}
		c.JSON(http.StatusOK, allTravelPlans)
	}
}
func GetTravelPlans() gin.HandlerFunc {
	return func(c *gin.Context) {
		var ctx, cancle = context.WithTimeout(context.Background(), 100*time.Second)
		result, err := travelPlanCollection.Find(ctx, bson.M{})
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "error occured while getting user posts items"})
		}
		defer cancle()
		var allTravelPlans []bson.M
		if err = result.All(ctx, &allTravelPlans); err != nil {
			log.Fatal(err)
		}
		c.JSON(http.StatusOK, allTravelPlans)
	}
}

func GetTravelPlan() gin.HandlerFunc {
	return func(c *gin.Context) {
		var ctx, cancle = context.WithTimeout(context.Background(), 100*time.Second)
		travelPlanId := c.Param("Tid")
		defer cancle()
		var travelplan models.TravelPlan

		err := travelPlanCollection.FindOne(ctx, bson.M{"travelplanid": travelPlanId}).Decode(&travelplan)

		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "error occured while getting user posts items"})
		}
		defer cancle()

		c.JSON(http.StatusOK, travelplan)
	}
}
func UpdateTravelPlan() gin.HandlerFunc {
	return func(c *gin.Context) {

	}
}
func DeleteTravelPlan() gin.HandlerFunc {
	return func(c *gin.Context) {

	}
}
