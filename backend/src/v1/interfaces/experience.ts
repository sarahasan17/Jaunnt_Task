import { ObjectId } from "mongodb";

export interface IExperienceModel {
    _id: ObjectId;
    postedBy: string;
    location: string;
    discription: string;
    images: string[];
    category: string[];
    tags: string[];
    budget: string;
    travelMode: string;
    dateOfTrip: string;
    tripTime: string;
    groupSize: number;
    likes: number;
    likedBy: string[];
    placeId: ObjectId;
}

export default IExperienceModel;
