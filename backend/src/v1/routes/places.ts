import { Router } from "express";
import Places from "../controllers/Places/Places";
import PlacesUtils from "../controllers/places/places_utils";
import Distance from "../controllers/Places/Distance";
import Joi from "joi";
import Validate from "../middlewares/Validate";
import { handlePlacesUploadMiddleware } from "../services/file_upload";

const router = Router();

const schema = {
    Places: Joi.object({
        placeName: Joi.string().required(),
        placeLocation: Joi.string().required(),
        description: Joi.string().required(),
        transportMode: Joi.string().required(),
        tripTime: Joi.string().required(),
        distance: Joi.array().items({ lng: Joi.string(), lat: Joi.string() }).required(),
        coverPhoto: Joi.string(),
        bestTime: Joi.string(),
        groupSize: Joi.number(),
        images: Joi.string(),
        category: Joi.array().items(Joi.string()),
        tags: Joi.array().items(Joi.string()),
        thingsToDo: Joi.array().items({
            title: Joi.string(),
            description: Joi.string(),
        }),
        itenirary: Joi.array().items({
            time: Joi.string(),
            title: Joi.string(),
            subtitle: Joi.string(),
            description: Joi.string(),
        }),
    }),
};

router.get("/all", Places.getAllPlaces);
router.get("/:placeId", Places.getPlace);

router.post("/create", Validate.body(schema.Places), Places.createPlace);
router.put("/:placeId", handlePlacesUploadMiddleware.array("files", 6), Places.updatePlace);

router.put("/bookmark/:placeId", PlacesUtils.updateUserBookMarks);
router.delete("/:placeId", Places.deletePlace);

router.post("/distance", Distance.findDirection);
router.post("/distacebng", Distance.findDirectionBng);

export default router;
