import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import { grid } from "../../services/grid";
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

class Direction {
    public static async findDirection(req: Request, res: Response): Promise<Response | void> {
        try {
            const lat1 = req.body.lng;
            const lng1 = req.body.lat;

            const Places: any = await PlaceSchema.find({});
            let d: any = [];

            for (let i = 0; i < Places.length; i++) {
                const dist: any = await grid(Places[i].distance[0].lat, Places[i].distance[0].lng, lat1, lng1);

                d = Math.round(dist.routes[0].distance / 1000);
                Places[i].length = d;
            }
            console.log(Places);
            if (!Places) {
                return res.status(404).send("places not found");
            }
            return res.status(200).json(Places);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async findDirectionBng(req: Request, res: Response): Promise<Response | void> {
        try {
            const lat1 = req.body.lng;
            const lng1 = req.body.lat;

            const Places: any = await PlaceSchema.find({});
            let d: any = [];

            for (let i = 0; i < Places.length; i++) {
                d = await grid(Places[i].distance[0].lat, Places[i].distance[0].lng, lat1, lng1);
                d = Math.round(d.routes[0].distance / 1000);
                Places[i].length = d;
            }
            console.log(Places);
            if (!Places) {
                return res.status(404).send("places not found");
            }
            return res.status(200).json(Places);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default Direction;

const tl = [13.1193, 77.479266];
const tr = [13.1193, 77.754318];

const bl = [12.82529, 77.479266];
const br = [12.82529, 77.754318];
