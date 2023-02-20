package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	Id           primitive.ObjectID `bson:"_id"`
	FullName     *string            `json:"fullName" validate:"required,min=3,max=20"`
	Password     *string            `json:"password" validate:"required,min=6,max=30"`
	Email        *string            `json:"email" validate:"required,email"`
	PhoneNumber  *string            `json:"phoneNumber" validate:"required,e164,min=10,max=13"`
	Token        *string            `json:"token"`
	ProfilePhoto *string            `json:"profilePhoto"`
	UserRole     *string            `json:"userRole" validate:"eq=ADMIN|eq=USER|eq=SUPERUSER"`
	RefreshToken *string            `json:"refreshToken"`
	CreatedAt    time.Time          `json:"createdTime"`
	UpdatedAt    time.Time          `json:"updatedTime"`
	UserId       string             `json:"userId"`
	VerifyUser   bool               `json:"verifyUser"`
	VerifyOtp    *string            `json:"verifyOtp"`
}

type UpdateUserOtp struct {
	PhoneNumber string `json:"phonenumber" validate:"required,e164,min=10,max=13"`
	VerifyOtp   string `json:"verifyotp"`
}
