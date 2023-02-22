package routes

import (
	controller "jaunnt-backend/controllers"

	"github.com/gin-gonic/gin"
)

func AuthRoutes(incomingRoutes *gin.Engine) {
	incomingRoutes.POST("users/signup", controller.Signup())
	incomingRoutes.POST("users/login", controller.Login())
	incomingRoutes.POST("users/verify", controller.RequestOtp())
	incomingRoutes.PATCH("users/verify", controller.VerifyUser())
}
