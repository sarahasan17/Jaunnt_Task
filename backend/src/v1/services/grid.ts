import Log from "../middlewares/Log";
import { getDistance } from "./distance";
import PlacesGridSchema from "../models/places_grid_model";

// import fetch from 'node-fetch';
// import dotenv from "dotenv";

// dotenv.config();

export const grid = async (lat1: number, log1: number, lat2: number, log2: number) => {
    // const g1: any = await PlacesGridSchema.find({ gridLt1: { $gt: lat2 } })
    const grid: any = await PlacesGridSchema.findOne({
        gridLt1: { $lte: lat2 },
        gridLt2: { $gte: lat2 },
        gridLg1: { $lte: log2 },
        gridLg2: { $gte: log2 },
        placeLt: lat1,
        placeLg: log1,
    });

    if (grid.distance) {
        return grid.distance;
    } else {
        const d = await getDistance(lat1, log1, lat2, log2);
        const ab = lat2 - 0.01;
        const ba = lat2 + 0.01;
        const xy = log2 - 0.01;
        const yz = log2 + 0.01;
        const plans = new PlacesGridSchema({
            distance: d,
            placeLt: lat1,
            placeLg: log1,
            gridLt1: ab,
            gridLt2: ba,
            gridLg1: xy,
            gridLg2: yz,
        });
        await plans.save();

        return d;
    }
};
