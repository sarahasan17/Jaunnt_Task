import IUser from "../interfaces/user";
import mongoose from "../providers/database";
import bcryptjs from "bcryptjs";
import jwt from "jsonwebtoken";
import { v4 } from "uuid";
import Token from "./token_model";

const options = { discriminatorKey: "kind" };

const JWT_SECRET = process.env.JWT_SECRET;

export interface IUserModel extends Omit<IUser, "_id">, mongoose.Document {
    PasswordResetToken?: string;
    PasswordResetExpires?: Date;
    isVerified?: boolean;
    verifyHash?: string;
    comparePassword?: (password?: string) => Promise<boolean>;
    createToken?: () => object;
    signupToken?: () => object;
    renewToken?: (refreshToken?: string) => object;
}

export const UserSchema = new mongoose.Schema<IUserModel>(
    {
        fullName: { type: String },
        phoneNumber: { type: String, unique: true },
        email: { type: String },
        password: { type: String },
        userRole: { type: String },
        userId: { type: String },
        isVerified: { type: Boolean, default: false },
        verifyOtp: { type: String },
        isActive: { type: Boolean, default: true },
        bookMarks: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Places",
            },
        ],
        following: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Users",
            },
        ],
        followers: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Users",
            },
        ],
        followingCount: { type: Number },
        followersCount: { type: Number },
        bio: { type: String },
        profilePhoto: { type: String },
        posts: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Experience",
            },
        ],
    },
    {
        timestamps: true,
    }
);

UserSchema.pre<IUserModel>("save", async function (next) {
    const user = this as IUserModel;
    if (!user.isModified("password")) {
        return next();
    }
    try {
        const salt = await bcryptjs.genSalt(10);
        const hash = await bcryptjs.hash(user.password, salt);
        user.password = hash;
        return next();
    } catch (err: any) {
        return next(err);
    }
});

UserSchema.methods.comparePassword = async function (candidatePassword: string) {
    const user = this as IUserModel;
    const isMatch = await bcryptjs.compare(candidatePassword, user.password);
    return isMatch;
};

UserSchema.methods.createToken = function () {
    const user = this as IUserModel;
    const token = jwt.sign(
        {
            id: user._id,
            role: user.userRole,
        },
        JWT_SECRET,
        {
            expiresIn: 86400, // 1 dayw
        }
    );

    const expiredDate = new Date();
    expiredDate.setDate(expiredDate.getDate() + 1);

    const _refreshToken = v4();
    const refreshToken = new Token({
        token: _refreshToken,
        user: user._id,
        role: user.userRole,
        expiryDate: expiredDate,
    });
    return { accessToken: token, refreshToken: refreshToken };
};

UserSchema.methods.signupToken = function () {
    const user = this as IUserModel;
    const token = jwt.sign(
        {
            id: user._id,
            role: user.userRole,
        },
        JWT_SECRET,
        {
            expiresIn: 600, // 10mins
        }
    );

    const expiredDate = new Date();
    expiredDate.setDate(expiredDate.getDate() + 1);

    const _refreshToken = v4();
    const refreshToken = new Token({
        token: _refreshToken,
        user: user._id,
        expiryDate: expiredDate,
        role: user.userRole,
    });
    return { accessToken: token, refreshToken: refreshToken };
};

UserSchema.methods.renewToken = async function (refreshToken: string) {
    const user = this as IUserModel;
    const token = await Token.findOne({ token: refreshToken });
    if (!token) {
        throw new Error("Invalid refresh token");
    }
    if (token.user.toString() !== user._id.toString()) {
        throw new Error("Invalid refresh token");
    }
    if (token.expiryDate < new Date()) {
        throw new Error("Refresh token expired");
    }
    const newToken = jwt.sign(
        {
            id: user._id,
            role: user.userRole,
        },
        JWT_SECRET,
        {
            expiresIn: 86400, // 1 day
        }
    );
    return { accessToken: newToken, refreshToken: token };
};

const Group = mongoose.model<IUserModel>("User", UserSchema);
export default Group;
