package main

import (
	constants "jaunnt-backend/constants"
	routes "jaunnt-backend/routes"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	port := os.Getenv("PORT")

	if port == "" {
		port = constants.PORT
	}

	router := gin.New()

	router.Use(gin.Logger())

	routes.AuthRoutes(router)
	routes.UserRoutes(router)

	router.GET("/v1", func(c *gin.Context) {
		c.JSON(200, gin.H{"success": "v111111111 working"})
	})

	router.Run(":" + port)

}
