import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import ExperienceSchema from "../../models/experience_model";
import { IExperienceModel } from "../../interfaces/Experience";
import PlaceSchema from "../../models/places_model";
import { IPlaceModel } from "../../interfaces/Places";
import APIFeatures from "../../utils/api_features";

function getToken(req: any) {
    if (req.headers.authorization && req.headers.authorization.split(" ")[0] === "Bearer") {
        return req.headers.authorization.split(" ")[1];
    }
    return null;
}

function parseJwt(token: any) {
    return JSON.parse(Buffer.from(token.split(".")[1], "base64").toString());
}

function verifyRole(token: any) {
    const tok = parseJwt(token);
    const role = tok.role;
    if (role != "ADMIN") {
        return false;
    }
    return true;
}

class Places {
    public static async createPlace(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const role = verifyRole(tok);
            if (!role) {
                return res.status(404).send("Unauthorized 404");
            }

            const {
                placeName,
                placeLocation,
                description,
                transportMode,
                tripTime,
                bestTime,
                distance,
                groupSize,
                images,
                category,
                tags,
                thingsToDo,
                itenirary,
            } = req.body;
            const coverPhotoLink = "https://www.svgrepo.com/show/457966/img.svg";
            const len = 10;
            const newPlace = new PlaceSchema({
                placeName,
                placeLocation,
                distance,
                length: len,
                description,
                transportMode,
                tripTime,
                bestTime,
                coverPhoto: coverPhotoLink,
                groupSize,
                images,
                category,
                tags,
                thingsToDo,
                itenirary,
            });
            await newPlace.save();

            return res.status(200).json({
                message: "Place created successfully",
                newPlace,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async getAllPlaces(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const person = token.id;
            if (!person) {
                return res.status(404).send("Unauthorized 404");
            }

            // const Places: any = await PlaceSchema.find({}, { updatedAt: false, __v: false })

            // if (!Places) {
            //     return res.status(404).send("Places not found");
            // }

            let filter = {};
            if (req.params.placeId) filter = { placeId: req.params.placeId };

            const features = new APIFeatures(PlaceSchema.find(), req.query).filter().sort().limitFields().paginate();
            const Places = await features.query;

            if (Places.length === 0) {
                return res.status(200).send("No places posted by admin");
            }

            return res.status(200).json(Places);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async getPlace(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const person = token.id;
            if (!person) {
                return res.status(404).send("Unauthorized 404");
            }
            const id = req.params.placeId;
            const places: IPlaceModel = await PlaceSchema.findById(id);
            if (!places) {
                return res.status(404).send("Place not found");
            }
            return res.status(200).json(places);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async updatePlace(req: Request, res: Response): Promise<Response | void> {
        try {
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async deletePlace(req: Request, res: Response): Promise<Response | void> {
        try {
            const placeId = req.params.placeId;
            const tok = getToken(req);
            const role = verifyRole(tok);
            if (!role) {
                return res.status(404).send("Unauthorized 404");
            }

            const place: IPlaceModel = await PlaceSchema.findById(placeId);
            if (!place) {
                return res.status(404).send("Place not found");
            }

            const deleteplace: IPlaceModel = await PlaceSchema.findByIdAndDelete(placeId);
            if (!deleteplace) {
                return res.status(404).send("Place not deleted");
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

export default Places;
