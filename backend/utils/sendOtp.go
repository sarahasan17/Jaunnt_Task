package utils

import (
	"encoding/json"
	"fmt"
	"github.com/twilio/twilio-go"
	twilioApi "github.com/twilio/twilio-go/rest/api/v2010"
	constants "jaunnt-backend/constants"
	
)

func SendOtp(randomOtp string) (err error) {

	from := constants.FROMPHONE
	to := constants.TOPHONE
	accountSid := constants.ACCOUNTSID
	authToken := constants.AUTHTOKEN
	client := twilio.NewRestClientWithParams(twilio.ClientParams{
		Username: accountSid,
		Password: authToken,
	})

	params := &twilioApi.CreateMessageParams{}
	params.SetTo(to)
	params.SetFrom(from)

	fmt.Print(randomOtp)
	
	params.SetBody("Your OTP is " + randomOtp)

	resp, err := client.Api.CreateMessage(params)
	if err != nil {
		fmt.Println(err.Error())
	} else {
		response, _ := json.Marshal(*resp)
		fmt.Println("Response: " + string(response))
	}
	return err
}
