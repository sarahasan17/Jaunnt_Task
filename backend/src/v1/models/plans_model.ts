import IPlansModel from "../interfaces/Plans";
import mongoose from "../providers/Database";

export const PlansSchema = new mongoose.Schema<IPlansModel>(
    {
        planName: { type: String },
        planDate: { type: String },
        people: { type: Number },
        peopleId: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Users",
            },
        ],
        adminId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Users",
        },
        isCompleted: { type: Boolean },
        placeId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Places",
        },
    },
    {
        timestamps: true,
    }
);

const Group = mongoose.model<IPlansModel>("Plans", PlansSchema);
export default Group;
