package main

import (
	"log"

	"github.com/sumodirjo/sre-challenge/internal/routes"
	"github.com/sumodirjo/sre-challenge/internal/utils"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/logger"
)

func main() {
	config := utils.LoadConfig()

	utils.InitLogger(config.Logging.Level)
	utils.InitDB()

	app := fiber.New()
	app.Use(logger.New())

	routes.SetupRoutes(app)

	log.Println("Starting server on port", config.Server.Port)
	log.Fatal(app.Listen(config.Server.Port))
}
