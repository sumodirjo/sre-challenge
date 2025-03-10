package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Pet struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"id,omitempty"`
	Name      string             `bson:"name" json:"name"`
	Happiness int                `bson:"happiness" json:"happiness"`
	Hunger    int                `bson:"hunger" json:"hunger"`
	Energy    int                `bson:"energy" json:"energy"`
}
