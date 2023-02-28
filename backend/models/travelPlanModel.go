package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"time"
)

type TravelPlan struct {
	Id           primitive.ObjectID `bson:"_id"`
	Title        *string            `json:"title" validate:"required,min=1,max=32"`
	Discription  *string            `json:"subTitle" validate:"required,min=4,max=256"`
	ImageLink    *string            `json:"imageLink" validate:"required"`
	Location     *string            `json:"location" validate:"required"`
	PosterUserid *string            `json:"postedUserId"`
	PostedBy     *string            `json:"postedBy"`
	Category     *string            `json:"category" validate:"required"`
	CreatedAt    time.Time          `json:"createdTime"`
	UpdatedAt    time.Time          `json:"updatedTime"`
	TravelPlanId string             `json:"travelId"`
}
