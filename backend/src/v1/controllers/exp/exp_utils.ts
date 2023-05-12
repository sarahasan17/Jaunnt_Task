import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import ExperienceSchema from "../../models/experience_model";
import User from "../../models/user_model";
import { IExperienceModel } from "../../interfaces/Experience";
import { IUser } from "../../interfaces/User";

function getToken(req: any) {
    if (req.headers.authorization && req.headers.authorization.split(" ")[0] === "Bearer") {
        return req.headers.authorization.split(" ")[1];
    }
    return null;
}
function parseJwt(token: any) {
    return JSON.parse(Buffer.from(token.split(".")[1], "base64").toString());
}

class ExperiencesUtils {
    public static async updateLikes(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const LikedPerson = token.id;
            if (!tok) {
                return res.status(404).send("Unauthorized 404");
            }
            const id = req.params.expId;

            const Post: IExperienceModel = await ExperienceSchema.findOne(
                { _id: id },
                { _id: true, likes: true, likedBy: true }
            );
            const filter = { _id: id };
            const options = { upsert: true };
            const updateUserPost = {
                $set: {
                    likes: Post.likes + 1,
                },
                $push: {
                    likedBy: LikedPerson,
                },
            };
            const Like: any = await ExperienceSchema.updateOne(filter, updateUserPost, options);
            return res.status(200).json({
                message: "liked successfully",
                Like,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default ExperiencesUtils;
