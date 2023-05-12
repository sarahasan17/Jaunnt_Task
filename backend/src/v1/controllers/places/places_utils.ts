import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import User from "../../models/user_model";
import { IUser } from "../../interfaces/User";
import PlaceSchema from "../../models/places_model";
import { IPlaceModel } from "../../interfaces/Places";

function getToken(req: any) {
    if (req.headers.authorization && req.headers.authorization.split(" ")[0] === "Bearer") {
        return req.headers.authorization.split(" ")[1];
    }
    return null;
}
function parseJwt(token: any) {
    return JSON.parse(Buffer.from(token.split(".")[1], "base64").toString());
}

class PlacesUtils {
    public static async updateUserBookMarks(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const LikedPerson = token.id;
            if (!tok) {
                return res.status(401).send("Unauthorized 401");
            }
            const id = req.params.placeId;

            const Post: IPlaceModel = await PlaceSchema.findOne({ _id: id }, { _id: true });
            if (!Post._id) {
                return res.status(404).send("place not found");
            }
            const filter = { _id: LikedPerson };
            const options = { upsert: true };
            const updateUserPost = {
                $push: {
                    bookMarks: id,
                },
            };
            const BookMark: any = await User.findOneAndUpdate(filter, updateUserPost, options);
            return res.status(200).json({
                message: "bookmarked successfully",
                BookMark,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default PlacesUtils;
