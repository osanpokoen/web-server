package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	server := gin.Default()
	server.GET("/", handler)
	server.Run(":3000")
}

type Response struct {
	Message string `json:"message"`
}

var handler = func(c *gin.Context) {
	response := Response{
		Message: "test",
	}
	c.JSON(http.StatusOK, response)
}
