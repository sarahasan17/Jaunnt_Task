package routes

import (
	controller "jaunnt-backend/controllers"

	"github.com/gin-gonic/gin"
)

func TravelPlanRoutes(incomingRoutes *gin.Engine) {

	incomingRoutes.POST("/travel/:Tid", controller.PostTravelPlan())
	incomingRoutes.GET("/travel/:Tid", controller.GetTravelPlan())
	incomingRoutes.PATCH("/travel/:Tid", controller.UpdateTravelPlan())
	incomingRoutes.DELETE("/travel/:Tid", controller.DeleteTravelPlan())
	incomingRoutes.GET("/travel/all", controller.GetTravelPlans())

}
