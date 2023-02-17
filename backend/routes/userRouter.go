package routes

import (
	controller "sanchari-backend/controllers"

	"github.com/gin-gonic/gin"
	"sanchari-backend/middleware"
)

func UserRoutes(incomingRoutes *gin.Engine) {
	incomingRoutes.Use(middleware.Authenticate())
	incomingRoutes.GET("/users", controller.GetUsers())
	incomingRoutes.GET("/users/:user_id", controller.GetUser())
}
 