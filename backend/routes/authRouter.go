package routes

import (
	"github.com/gin-gonic/gin"
	controller "sanchari-backend/controllers"
)

func AuthRoutes(incomingRoutes *gin.Engine) {
	incomingRoutes.POST("users/signup", controller.Singup())
	incomingRoutes.POST("users/login", controller.Login())
}
