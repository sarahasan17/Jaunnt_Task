package middleware

import (
	"fmt"
	helper "jaunnt-backend/helpers"
	"net/http"

	"github.com/gin-gonic/gin"
)

func Authenticate() gin.HandlerFunc {
	return func(c *gin.Context) {
		clientToken := c.Request.Header.Get("token")
		if clientToken == "" {
			c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("No Authorization header provided")})
			c.Abort()
			return
		}	

		claims, err := helper.ValidateToken(clientToken)
		if err != "" {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			c.Abort()
			return
		}
		c.Set("email", claims.Email)
		c.Set("fullName", claims.FullName)
		c.Set("phoneNumber", claims.PhoneNumber)
		c.Set("profilePhoto", claims.ProfilePhoto)
		c.Set("uid", claims.Uid)
		c.Set("userRole", claims.UserRole)
		c.Next()
	}
}
