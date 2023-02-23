package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type PlanReview struct {
	Id           primitive.ObjectID `bson:"_id"`
	Title        *string            `json:"title" validate:"required,min=3,max=50"`
	Description  *string            `json:"description" validate:"required,min=6,max=200"`
	Stars        *string            `json:"imageLink" validate:"required"`
	Location     *string            `json:"location" validate:"required"`
	PostedBy     *string            `json:"postedBy" validate:"required"`
	Reviews      []string           `json:"reviews"`
	Category     *string            `json:"category" validate:"required"`
	CreatedAt    time.Time          `json:"createdTime"`
	UpdatedAt    time.Time          `json:"updatedTime"`
	TravelPlanId string             `json:"userId"`
}
