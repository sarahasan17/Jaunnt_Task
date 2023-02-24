package routes

import (
	controller "jaunnt-backend/controllers"

	"jaunnt-backend/middleware"

	"github.com/gin-gonic/gin"
)

func UserRoutes(incomingRoutes *gin.Engine) {
	incomingRoutes.Use(middleware.Authenticate())
	incomingRoutes.GET("/users/all", controller.GetUsers())
	incomingRoutes.GET("/users", controller.GetUser())
	incomingRoutes.PATCH("/users", controller.UpdateUser())
	incomingRoutes.PATCH("/users/delete", controller.DeleteUser())
}
