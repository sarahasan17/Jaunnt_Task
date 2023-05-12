import { ObjectId } from "mongodb";

export interface IUser {
    _id?: ObjectId;
    fullName?: string;
    phoneNumber?: string;
    password?: string;
    email?: string;
    userRole?: string;
    userId?: string;
    verifyOtp?: string;
    isActive?: boolean;
    bio?: string;
    posts?: [string];
    profilePhoto?: string;
    bookMarks?: [ObjectId];
    following?: [ObjectId];
    followers?: [ObjectId];
    followingCount?: number;
    followersCount?: number;
    ExpireAt?: {
        type?: Date;
        default?: Date;
        index?: any;
    };
}

export default IUser;
