package middleware

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
	helper "sanchari-backend/helpers"
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
		c.Set("first_name", claims.First_name)
		c.Set("last_name", claims.Last_name)
		c.Set("profile_photo", claims.Profile_photo)
		c.Set("uid", claims.Uid)
		c.Set("user_role", claims.User_role)
		c.Next()
	}
}
