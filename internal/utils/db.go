package utils

import (
	"context"
	"log"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var DB *mongo.Database

func InitDB() {
	config := LoadConfig()
	clientOptions := options.Client().ApplyURI(config.Database.URI)
	client, err := mongo.Connect(context.TODO(), clientOptions)
	if err != nil {
		log.Fatal("Failed to connect to MongoDB:", err)
	}

	err = client.Ping(context.TODO(), nil)
	if err != nil {
		log.Fatal("MongoDB connection error:", err)
	}

	DB = client.Database(config.Database.Name)
	log.Println("Connected to MongoDB")
}
