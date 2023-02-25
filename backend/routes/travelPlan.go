package routes

import (
	controller "jaunnt-backend/controllers"

	"github.com/gin-gonic/gin"
)

func TravelPlanRoutes(incomingRoutes *gin.Engine) {

	incomingRoutes.POST("/travel", controller.PostTravelPlan())
	incomingRoutes.GET("/travel/:posteruserid", controller.GetUserTravelPlans())
	incomingRoutes.GET("/travel/all", controller.GetTravelPlans())
	incomingRoutes.GET("/travel/plans/:Tid", controller.GetTravelPlan())
	incomingRoutes.PATCH("/travel/:Tid", controller.UpdateTravelPlan())
	incomingRoutes.DELETE("/travel/:Tid", controller.DeleteTravelPlan())

}
