package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"time"
)

type User struct {
	Id            primitive.ObjectID `bson:"_id"`
	First_name    *string            `json:"first_name" validate:"required"`
	Last_name     *string            `json:"last_name" validate:"required"`
	Email         *string            `json:"email" validate:"required"`
	Password      *string            `json:"password" validate:"required"`
	Token         *string            `json:"token"`
	Profile_photo *string            `json:"profile_photo"`
	User_role     *string            `json:"user_role" validate:"required"`
	Refresh_token *string            `json:"refresh_token"`
	Created_at    time.Time          `json:"created_time"`
	Updated_at    time.Time          `json:"updated_time"`
	User_id       string             `json:"user_id"`
}
