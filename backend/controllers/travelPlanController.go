package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"go.mongodb.org/mongo-driver/mongo"

	database "jaunnt-backend/database"
)

var travelPlanCollection *mongo.Collection = database.OpenCollection(database.Client, "travelPlan")
var validatee = validator.New()

func PostTravelPlan() gin.HandlerFunc {
	return func(c *gin.Context) {

	}
}

func GetTravelPlan() gin.HandlerFunc {
	return func(c *gin.Context) {

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

func GetTravelPlans() gin.HandlerFunc {
	return func(c *gin.Context) {

	}
}
