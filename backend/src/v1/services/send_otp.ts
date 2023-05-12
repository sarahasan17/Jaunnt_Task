import Log from "../middlewares/Log";

const accountSid = process.env.ACCOUNTS_ID;
const authToken = process.env.AUTH_TOKEN;
const fromNumber = process.env.FROM_PHONE;
const client = require("twilio")(accountSid, authToken);

export const sendOtp = async (phoneNumber: string, verifyOtp: any) => {
    try {
        client.messages
            .create({
                body: `your OTP is ${verifyOtp}`,
                to: phoneNumber,
                from: fromNumber,
            })
            .then((message: any) => console.log(message.sid));
        return true;
    } catch (error: any) {
        Log.error(error);
        return false;
    }
};
