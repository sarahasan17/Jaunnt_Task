package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	Id           primitive.ObjectID `bson:"_id"`
	FullName     *string            `json:"fullName" validate:"required"`
	Password     *string            `json:"password" validate:"required"`
	Email        *string            `json:"email" validate:"required"`
	PhoneNumber  *string            `json:"phoneNumber" validate:"required"`
	Token        *string            `json:"token"`
	ProfilePhoto *string            `json:"profilePhoto"`
	UserRole     *string            `json:"userRole" validate:"required"`
	RefreshToken *string            `json:"refreshToken"`
	CreatedAt    time.Time          `json:"createdTime"`
	UpdatedAt    time.Time          `json:"updatedTime"`
	UserId       string             `json:"userId"`
	VerifyUser   bool               `json:"verifyUser"`
	VerifyOtp    *string            `json:"verifyOtp"`
}

type UpdateUserOtp struct {
	PhoneNumber string `json:"phonenumber"`
	VerifyOtp   string `json:"verifyotp"`
}
