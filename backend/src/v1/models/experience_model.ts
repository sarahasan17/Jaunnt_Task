import IExperienceModel from "../interfaces/Experience";
import mongoose from "../providers/Database";

export const ExperienceSchema = new mongoose.Schema<IExperienceModel>(
    {
        postedBy: { type: String },
        location: { type: String },
        discription: { type: String },
        images: [{ type: String }],
        category: [{ type: String }],
        tags: [{ type: String }],
        travelMode: { type: String },
        groupSize: { type: Number },
        budget: { type: String },
        tripTime: { type: String },
        dateOfTrip: { type: String },
        likes: { type: Number },
        likedBy: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "User",
            },
        ],
        placeId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Places",
        },
    },
    {
        timestamps: true,
    }
);

const Group = mongoose.model<IExperienceModel>("Experience", ExperienceSchema);
export default Group;
