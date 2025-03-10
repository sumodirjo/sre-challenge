package routes

import (
	"github.com/sumodirjo/sre-challenge/internal/handlers"

	"github.com/gofiber/fiber/v2"
)

func SetupRoutes(app *fiber.App) {
	api := app.Group("/api")

	api.Post("/pets", handlers.CreatePet)
}
