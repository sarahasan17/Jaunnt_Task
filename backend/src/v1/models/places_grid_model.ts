import IPlacesGrid from "../interfaces/places_grid";
import mongoose from "../providers/Database";

export const PlacesGridSchema = new mongoose.Schema<IPlacesGrid>(
    {
        placeLt: { type: Number },
        placeLg: { type: Number },
        gridLt1: { type: Number },
        gridLg1: { type: Number },
        gridLt2: { type: Number },
        gridLg2: { type: Number },
        distance: { type: Number },
    },
    {
        timestamps: true,
    }
);

const Group = mongoose.model<IPlacesGrid>("places_grid", PlacesGridSchema);
export default Group;
