import { ObjectId } from "mongodb";

export interface IPlacesGrid {
    _id: ObjectId;
    placeLt: number;
    placeLg: number;
    gridLt1: number;
    gridLg1: number;
    gridLt2: number;
    gridLg2: number;
    distance: number;
}

export default IPlacesGrid;
