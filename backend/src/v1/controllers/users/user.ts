import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import { IUserModel } from "../../models/user_model";
import User from "../../models/user_model";
import { IUser } from "../../interfaces/User";
import bodyParser from "body-parser";
import PlacesSchema from "../../models/places_model";
import IPlaceModel from "../../interfaces/Places";
import mongoose from "mongoose";
function getToken(req: any) {
    if (req.headers.authorization && req.headers.authorization.split(" ")[0] === "Bearer") {
        return req.headers.authorization.split(" ")[1];
    }
    return null;
}
function parseJwt(token: any) {
    return JSON.parse(Buffer.from(token.split(".")[1], "base64").toString());
}

class Users {
    public static async getUsers(req: Request, res: Response): Promise<Response | void> {
        try {
            const users: any = await User.find();

            if (!users) {
                return res.status(404).send("Users not found");
            }
            return res.status(200).json(users);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async getUser(req: Request, res: Response): Promise<Response | void> {
        try {
            const id = req.params.user;
            const user: any = await User.findById(id);
            if (!user) {
                return res.status(404).send("User not found");
            }
            if (!user.isActive) {
                return res.status(400).send("User Deleted");
            }
            return res.status(200).json(user);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async deleteUser(req: Request, res: Response): Promise<Response | void> {
        try {
            const id = req.params.user;

            const user: any = await User.findByIdAndDelete(id);
            if (!user) {
                return res.status(404).send("User not deleted");
            }
            return res.status(200).json({
                message: "succesffuly deleted",
                user,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async uploadProfile(req: Request, res: Response): Promise<Response | void> {
        try {
            const id = req.params.user;
            const bio = req.body.bio;
            const fileLocation: any = req.files;
            const path = fileLocation[0].fileLocation;
            // @ts-ignore
            const user: IUserModel = await User.updateOne(
                { _id: id },
                { $set: { profilePhoto: path } && { bio: bio } },
                { upsert: true }
            );
            if (!user.isActive) {
                return res.status(400).send("User Deleted");
            }
            return res.status(200).json(user);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async deleteTempUser(req: Request, res: Response): Promise<Response | void> {
        try {
            const id = req.params.user;
            // @ts-ignore
            const user: IUserModel = await User.updateOne({ _id: id }, { $set: { isActive: false } }, { upsert: true });
            if (!user.isActive) {
                return res.status(400).send("User already Deleted");
            }
            return res.status(200).json({
                message: "User Deleted",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async GetUserBookMarks(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const id = token.id;

            const user: any = await User.findById(id, { bookMarks: true });
            if (!user) {
                return res.status(404).send("User not found");
            }

            const userBookMarks: IPlaceModel = await PlacesSchema.findOne(
                { _id: user.bookMarks.ObjectId },
                {
                    placeName: true,
                    placeLocation: true,
                    coverPhoto: true,
                    distance: true,
                    description: true,
                }
            );
            if (!userBookMarks) {
                return res.status(404).send("Bookmark places not found");
            }

            return res.status(200).json(userBookMarks);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async GetUserFollowers(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const id = token.id;

            const user: any = await User.findById(id, {
                fullName: true,
                followers: true,
                followersCount: true,
            });
            if (!user) {
                return res.status(404).send("User not found");
            }

            const followers: any = await User.find(
                { _id: user.followers.ObjectId },
                { fullName: true, profilePhoto: true }
            );
            if (!followers) {
                return res.status(404).send("followers not found");
            }

            return res.status(200).json(followers);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async GetUserFollowing(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const id = token.id;

            const user: any = await User.findById(id, {
                fullName: true,
                following: true,
                followingCount: true,
            });
            if (!user) {
                return res.status(404).send("User not found");
            }

            const following: any = await User.find(
                { _id: user.following.ObjectId },
                { fullName: true, profilePhoto: true }
            );
            if (!following) {
                return res.status(404).send("following users not found");
            }

            return res.status(200).json(following);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async UpdateFollow(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const id = token.id;

            const user: any = await User.findById(id);
            if (!user) {
                return res.status(404).send("User not found");
            }

            const followid = req.params.followUserId;
            const followUser: any = await User.findById(followid);

            if (!followUser) {
                return res.status(404).send("Follow User not found");
            }

            const Post: IUser = await User.findOne({ _id: id });
            if (!Post) {
                return res.status(500).send("Internal server error");
            }

            if (user.following.filter((followerr: any) => followerr.toString() === followid).length > 0) {
                console.log(followid);
                return res.status(400).json({ status: "You already followed the user, cant follow again" });
            }

            const filter = { _id: id };
            const options = { upsert: true };
            const updateFollowing = {
                $set: {
                    followingCount: user.followingCount + 1,
                },
                $push: {
                    following: followid,
                },
            };

            const followFilter = { _id: followid };
            const followOptions = { upsert: true };
            const updateFollower = {
                $set: {
                    followersCount: followUser.followersCount + 1,
                },
                $push: {
                    followers: id,
                },
            };
            const Follower: any = await User.updateOne(followFilter, updateFollower, followOptions);
            const Follow: any = await User.updateOne(filter, updateFollowing, options);
            if (!Follower || !Follow) {
                return res.status(500).send("failed to update followers");
            }

            return res.status(200).json({
                message: "followed successfully",
                Follow,
                Follower,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async UpdateUnfollow(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const id = token.id;

            const user: any = await User.findById(id);
            if (!user) {
                return res.status(404).send("User not found");
            }

            const followid = req.params.unfollowUserId;
            const followUser: any = await User.findById(followid);

            if (!followUser) {
                return res.status(404).send("UnFollow User not found");
            }

            const Post: IUser = await User.findOne({ _id: id });
            if (!Post) {
                return res.status(500).send("Internal server error");
            }
            if (user.following.filter((followerr: any) => followerr.toString() === followid).length === 0) {
                console.log(followid);
                return res.status(400).json({
                    status: "You already unfollowed the user, cant unfollow again",
                });
            }

            const filter = { _id: id };
            const options = { upsert: true };
            const updateunfollowing = {
                $set: {
                    followingCount: Post.followingCount - 1,
                },
                $pull: {
                    following: followid,
                },
            };

            const unfollowFilter = { _id: followid };
            const unfollowOptions = { upsert: true };
            const updateUnfollower = {
                $set: {
                    followersCount: followUser.followersCount - 1,
                },
                $pull: {
                    followers: id,
                },
            };
            const Follower: any = await User.updateOne(unfollowFilter, updateUnfollower, unfollowOptions);
            const Follow: any = await User.updateOne(filter, updateunfollowing, options);
            if (!Follower || !Follow) {
                return res.status(500).send("Internal server error");
            }

            return res.status(200).json({
                message: "Unfollowed successfully",
                Follow,
                Follower,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default Users;
