import Log from "../middlewares/Log";
import fetch from "node-fetch";
import dotenv from "dotenv";

dotenv.config();

export const getDistance = async (lat1: number, log1: number, lat2: number, log2: number) => {
    try {
        const token = process.env.MAP_BOX_TOKEN;
        const URL = `https://api.mapbox.com/directions/v5/mapbox/driving/${lat1}%2C${log1}%3B${lat2}%2C${log2}?alternatives=false&geometries=geojson&language=en&overview=simplified&steps=false&access_token=${token}`;
        console.log(URL);
        const response = await fetch(URL);
        const data = await response.json();
        return data;
    } catch (error: any) {
        Log.error(error);
        return false;
    }
};
