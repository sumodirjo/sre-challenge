package handlers

import (
	"context"

	"github.com/sumodirjo/sre-challenge/internal/models"
	"github.com/sumodirjo/sre-challenge/internal/utils"

	"github.com/gofiber/fiber/v2"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func CreatePet(c *fiber.Ctx) error {
	pet := new(models.Pet)
	if err := c.BodyParser(pet); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request body"})
	}

	pet.ID = primitive.NewObjectID()
	_, err := utils.DB.Collection("pets").InsertOne(context.TODO(), pet)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Failed to create pet"})
	}

	return c.Status(fiber.StatusCreated).JSON(pet)
}
