package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type TravelPlan struct {
	Id           primitive.ObjectID `bson:"_id"`
	Title        *string            `json:"title" validate:"required,min=3,max=20"`
	SubTitle     *string            `json:"subTitle" validate:"required,min=6,max=200"`
	ImageLink    *string            `json:"imageLink" validate:"required"`
	Location     *string            `json:"location" validate:"required"`
	PostedBy     *string            `json:"postedBy" validate:"required"`
	Reviews      []string           `json:"reviews"`
	Category     *string            `json:"category" validate:"required"`
	CreatedAt    time.Time          `json:"createdTime"`
	UpdatedAt    time.Time          `json:"updatedTime"`
	TravelPlanId string             `json:"userId"`
}
