import { ObjectId } from "mongodb";

export interface IPlaceModel {
    _id: ObjectId;
    placeName: string;
    placeLocation: string;
    description: string;
    tripTime: string;
    transportMode: string;
    bestTime: string;
    coverPhoto: string;
    groupSize: number;
    images: string[];
    category: string[];
    tags: string[];
    distance: {
        lat: string;
        lng: string;
    };
    length: any;
    thingsToDo: {
        title: string;
        description: string;
    };
    itenirary: {
        time: string;
        title: string;
        subtitle: string;
        description: string;
    };
    similarPlaces: string[];
}

export default IPlaceModel;
