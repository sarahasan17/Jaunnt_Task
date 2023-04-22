import { ObjectId } from "mongodb";

export interface IPlansModel {
    _id: ObjectId;
    planName: string;
    planDate: string;
    people: number;
    adminId: ObjectId;
    isCompleted: boolean;
    peopleId: [ObjectId];
    placeId: ObjectId;
}

export default IPlansModel;
