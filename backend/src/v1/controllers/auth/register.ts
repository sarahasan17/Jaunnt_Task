import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import User, { IUserModel } from "../../models/user_model";
import { sendOtp } from "../../services/send_otp";

function generateRandomNumber() {
    var minm = 100000;
    var maxm = 999999;
    return Math.floor(Math.random() * (maxm - minm + 1)) + minm;
}
function getToken(req: any) {
    if (req.headers.authorization && req.headers.authorization.split(" ")[0] === "Bearer") {
        return req.headers.authorization.split(" ")[1];
    }
    return null;
}
function parseJwt(token: any) {
    return JSON.parse(Buffer.from(token.split(".")[1], "base64").toString());
}

class Register {
    public static async signup(req: Request, res: Response): Promise<Response | void> {
        try {
            const { fullName, phoneNumber, email, password } = req.body;
            const user: IUserModel = await User.findOne({ phoneNumber });
            if (user) {
                return res.status(400).send("User already exists");
            }
            const otp = generateRandomNumber();
            const role = "ADMIN";
            const imageLink = "https://www.svgrepo.com/show/220843/user-profile.svg";
            const newUser = new User({
                fullName,
                email,
                phoneNumber,
                password,
                verifyOtp: otp,
                userRole: role,
                profilePhoto: imageLink,
                followersCount: 0,
                followingCount: 0,
            });
            // ExpireAt: {
            //   type: Date,
            //   default: Date.now,
            //   index: { expires: '10m' },
            // },
            await newUser.save();
            // await sendOtp(newUser.phoneNumber, newUser.verifyOtp);
            const token = await newUser.signupToken();
            return res.status(201).json({
                message: "User created. Check your sms to verify your account",
                token,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async verify(req: Request, res: Response): Promise<Response | void> {
        try {
            const { otpNumber } = req.body;
            const tok = getToken(req);
            const token = parseJwt(tok);
            const id = token.id;
            const user: IUserModel = await User.findById(id);
            if (!user) {
                return res.status(404).send("User not found");
            }
            if (user.isVerified) {
                return res.status(400).send("User already verified");
            }
            if (user.verifyOtp !== otpNumber) {
                return res.status(400).send("Invalid otp number");
            }
            user.isVerified = true;
            await user.save();
            await User.updateOne({ _id: id }, { $unset: { verifyOtp: otpNumber, ExpireAt: "" } });
            return res.status(200).json({
                message: "User verified",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async resend(req: Request, res: Response): Promise<Response | void> {
        try {
            const { phoneNumber } = req.body;
            const user: IUserModel = await User.findOne({ phoneNumber: phoneNumber });
            if (!user) {
                return res.status(404).send("User not found");
            }

            if (user.isVerified) {
                return res.status(400).send("User already verified");
            }
            await user.save();
            await sendOtp(user.phoneNumber, user.verifyOtp);
            return res.status(200).json({
                message: "otp sent",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default Register;
