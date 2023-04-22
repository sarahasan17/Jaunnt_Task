import IPlaceModel from "../interfaces/Places";
import mongoose from "../providers/Database";

export const PlacesSchema = new mongoose.Schema<IPlaceModel>(
    {
        placeName: { type: String },
        placeLocation: { type: String },
        description: { type: String },
        transportMode: { type: String },
        tripTime: { type: String },
        bestTime: { type: String },
        groupSize: { type: Number },
        coverPhoto: { type: String },
        images: [{ type: String }],
        category: [{ type: String }],
        tags: [{ type: String }],
        distance: [
            {
                lng: { type: String },
                lat: { type: String },
            },
        ],
        length: { type: Number },
        thingsToDo: [
            {
                title: { type: String },
                description: { type: String },
            },
        ],
        itenirary: [
            {
                time: { type: String },
                title: { type: String },
                subtitle: { type: String },
                description: { type: String },
            },
        ],
        similarPlaces: [
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

const Group = mongoose.model<IPlaceModel>("Places", PlacesSchema);
export default Group;
