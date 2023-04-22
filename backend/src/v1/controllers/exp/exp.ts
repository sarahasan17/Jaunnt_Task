import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import ExperienceSchema from "../../models/experience_model";
import PlacesSchema from "../../models/places_model";
import { IExperienceModel } from "../../interfaces/Experience";
import { IUser } from "../../interfaces/User";
import { IPlaceModel } from "../../interfaces/Places";
import User, { UserSchema } from "../../models/user_model";

function getToken(req: any) {
    if (req.headers.authorization && req.headers.authorization.split(" ")[0] === "Bearer") {
        return req.headers.authorization.split(" ")[1];
    }
    return null;
}
function parseJwt(token: any) {
    return JSON.parse(Buffer.from(token.split(".")[1], "base64").toString());
}

class Experiences {
    public static async getAllExp(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const person = token.id;
            if (!person) {
                return res.status(404).send("Unauthorized 404");
            }
            const Exps: any = await ExperienceSchema.find({}, { likedBy: false, updatedAt: false, __v: false });

            if (!Exps) {
                return res.status(404).send("Experiences not found");
            }
            if (Exps.length === 0) {
                return res.status(200).send("No Experiences posted by users");
            }
            return res.status(200).json(Exps);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async getUserExp(req: Request, res: Response): Promise<Response | void> {
        try {
            const userId = req.params.userId;
            const user: any = await User.findById(userId);
            if (!user) {
                return res.status(404).send("User not found");
            }
            const userExp: any = await ExperienceSchema.find(
                { postedBy: userId },
                { likedBy: false, updatedAt: false, __v: false }
            );
            if (!userExp) {
                return res.status(404).send("Experiences not found");
            }
            return res.status(200).json(userExp);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async getExp(req: Request, res: Response): Promise<Response | void> {
        try {
            const id = req.params.expId;
            const exp: IExperienceModel = await ExperienceSchema.findById(id, {
                likedBy: false,
            });
            if (!exp) {
                return res.status(404).send("Experience not found");
            }
            // const userid = console.log(exp.postedBy)
            const user: any = await User.findOne(
                { _id: exp.postedBy },
                { _id: true, fullName: true, bio: true, profilePhoto: true }
            );
            if (!user) {
                return res.status(404).send("User not found");
            }
            const place: IPlaceModel = await PlacesSchema.findOne(
                { _id: exp.placeId },
                {
                    _id: true,
                    placeName: true,
                    tripTime: true,
                    coverPhoto: true,
                    category: true,
                    distance: true,
                    groupSize: true,
                }
            );
            if (!place) {
                return res.status(404).send("Place not found");
            }
            console.log(user);
            return res.status(200).json({
                exp,
                user,
                place,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async getPlacesExp(req: Request, res: Response): Promise<Response | void> {
        try {
            const placeId = req.params.placeId;
            const place: any = await PlacesSchema.findById(placeId);
            if (!place) {
                return res.status(404).send("place not found");
            }
            var placeExp: any = await ExperienceSchema.find(
                { placeId: placeId },
                { postedBy: true, discription: true, tags: true }
            );
            if (!placeExp) {
                return res.status(404).send("Experiences not found");
            }

            return res.status(200).json(placeExp);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async createExp(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const postedBy = token.id;

            const {
                placeId,
                location,
                discription,
                images,
                category,
                tags,
                travelMode,
                groupSize,
                budget,
                tripTime,
                dateOfTrip,
            } = req.body;

            const place: IPlaceModel = await PlacesSchema.findById(placeId);
            if (!place) {
                return res.status(404).send("Place not found");
            }
            const likes = 0;
            const newEvent = new ExperienceSchema({
                postedBy,
                placeId,
                location,
                discription,
                images,
                category,
                tags,
                travelMode,
                groupSize,
                budget,
                tripTime,
                dateOfTrip,
                likes,
            });
            await newEvent.save();
            const filter = { _id: postedBy };
            const options = { upsert: true };
            const updateUserPost = {
                $push: {
                    posts: newEvent.id,
                },
            };
            const user = await User.updateOne(filter, updateUserPost, options);
            return res.status(200).json({
                message: "Event created successfully",
                newEvent,
                user,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async updateExp(req: Request, res: Response): Promise<Response | void> {
        try {
            const id = req.params.expId;
            const subTitle = req.body.SubTitle;
            const fileLocation: any = req.files;
            const path = fileLocation[0].fileLocation;

            const tok = getToken(req);
            const token = parseJwt(tok);
            const userId = token.id;

            const user: any = await User.findById(userId);
            if (!user) {
                return res.status(404).send("User not found");
            }

            const exp: IExperienceModel = await ExperienceSchema.findById(id, {
                postedBy: true,
            });
            if (!exp) {
                return res.status(404).send("Experience not found");
            }

            if (exp.postedBy != userId) {
                return res.status(404).send("user not authorised");
            }

            const updateExp: any = await ExperienceSchema.updateOne(
                { _id: id },
                { $set: { SubTitle: subTitle }, $push: { images: path } },
                { upsert: true }
            );
            if (!updateExp) {
                return res.status(400).send("Experience not Updated");
            }

            return res.status(200).json(updateExp);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async deleteExp(req: Request, res: Response): Promise<Response | void> {
        try {
            const expId = req.params.exp;
            const tok = getToken(req);
            const token = parseJwt(tok);
            const userId = token.id;

            const user: any = await User.findById(userId);
            if (!user) {
                return res.status(404).send("User not found");
            }

            const exp: IExperienceModel = await ExperienceSchema.findById(expId, {
                postedBy: true,
            });
            if (!exp) {
                return res.status(404).send("Experience not found");
            }

            if (exp.postedBy != userId) {
                return res.status(404).send("user not authorised");
            }

            const deleteexp: any = await ExperienceSchema.findByIdAndDelete(expId);
            if (!deleteexp) {
                return res.status(404).send("Experience not deleted");
            }
            return res.status(200).json({
                message: "succesffuly deleted",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default Experiences;
