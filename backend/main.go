package main

import (
	"github.com/gin-gonic/gin"
	"os"
	routes "sanchari-backend/routes"
)

func main() {
	port := os.Getenv("PORT")

	if port == "" {
		port = "8080"
	}

	router := gin.New()

	router.Use(gin.Logger())
	routes.AuthRoutes(router)
	routes.UserRoutes(router)

	router.GET("/v1", func(c *gin.Context) {
		c.JSON(200, gin.H{"success": "v1 working"})
	})

	router.Run(":" + port)

}
