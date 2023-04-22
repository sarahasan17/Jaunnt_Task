import { Request, Response } from "express";
import { v4 } from "uuid";
import User, { IUserModel } from "../../models/user_model";
import { sendOtp } from "../../services/send_otp";
import Log from "../../middlewares/Log";

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

class Login {
    public static async login(req: Request, res: Response): Promise<Response | void> {
        try {
            const { phoneNumber, password } = req.body;
            const user: IUserModel = await User.findOne({ phoneNumber });
            if (!user) {
                return res.status(404).send("User not found");
            }
            if (!user.isVerified) {
                return res.status(400).send("User not verified");
            }
            if (!user.isActive) {
                return res.status(400).send("User Deleted");
            }
            const isMatch = await user.comparePassword(password);
            if (!isMatch) {
                return res.status(401).send("Invalid credentials");
            }
            const token = await user.createToken();
            return res.status(200).json({
                message: "Logged in",
                token,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async sendForgotPassword(req: Request, res: Response): Promise<Response | void> {
        try {
            const { phoneNumber } = req.body;
            const user: IUserModel = await User.findOne({ phoneNumber: phoneNumber });
            if (!user) {
                return res.status(404).send("User not found");
            }
            if (!user.isVerified) {
                return res.status(400).send("User not verified");
            }
            if (!user.isActive) {
                return res.status(400).send("User Deleted");
            }
            const number = generateRandomNumber();
            user.PasswordResetToken = number.toString();
            user.PasswordResetExpires = new Date(Date.now() + 900000); // 15 ,oms
            await user.save();
            await sendOtp(user.phoneNumber, number);
            return res.status(200).json({
                message: "otp sent",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async resetPassword(req: Request, res: Response): Promise<Response | void> {
        try {
            const { phoneNumber, Otp, password } = req.body;
            const user: IUserModel = await User.findOne({ phoneNumber });
            if (!user) {
                return res.status(404).send("User not found");
            }
            if (!user.isActive) {
                return res.status(400).send("User Deleted");
            }
            if (user.PasswordResetToken !== Otp) {
                return res.status(401).send("Invalid Otp");
            }
            if (user.PasswordResetExpires < new Date()) {
                return res.status(401).send("Token expired");
            }
            user.password = password;
            user.PasswordResetToken = undefined;
            user.PasswordResetExpires = undefined;
            await user.save();
            return res.status(200).json({
                message: "password reseted",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async newPassword(req: Request, res: Response): Promise<Response | void> {
        try {
            const { oldPassword, newPassword } = req.body;

            const tok = getToken(req);
            const token = parseJwt(tok);
            const id = token.id;
            const user: IUserModel = await User.findById(id);
            if (!user) {
                return res.status(404).send("User not found");
            }
            if (!user.isActive) {
                return res.status(400).send("User Deleted");
            }
            const isMatch = await user.comparePassword(oldPassword);
            if (!isMatch) {
                return res.status(401).send("wrong password");
            }
            if (oldPassword === newPassword) {
                return res.status(500).send("new password cannot be same as old password");
            }
            user.password = newPassword;
            await user.save();
            return res.status(200).json({
                message: "new passoword successfully updated",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async renewToken(req: Request, res: Response): Promise<Response | void> {
        try {
            const { id } = req.params;
            const user: IUserModel = await User.findById(id);
            if (!user) {
                return res.status(404).send("User not found");
            }
            if (!user.isActive) {
                return res.status(400).send("User Deleted");
            }
            const token = await user.createToken();
            return res.status(200).json({
                message: "Token renewed",
                token,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default Login;
