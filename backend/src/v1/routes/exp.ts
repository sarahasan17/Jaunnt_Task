import { Router } from "express";
import Exp from "../controllers/Exp/Exp";
import ExpUtils from "../controllers/exp/exp_utils";
import Joi from "joi";
import Validate from "../middlewares/Validate";
import { handleExperiencesUploadMiddleware } from "../services/file_upload";

const router = Router();

const schema = {
    exp: Joi.object({
        placeId: Joi.string().required(),
        location: Joi.string().required(),
        discription: Joi.string().required(),
        travelMode: Joi.string().required(),
        category: Joi.array().items(Joi.string()),
        budget: Joi.string(),
        tags: Joi.array().items(Joi.string()),
        Plan: Joi.array().items(Joi.string()),
        groupSize: Joi.number(),
        tripTime: Joi.string(),
        dateOfTrip: Joi.string(),
    }),
};
router.get("/all", Exp.getAllExp);
router.get("/user/:userId", Exp.getUserExp);
router.get("/:expId", Exp.getExp);
router.get("/place/:placeId", Exp.getPlacesExp);

router.post("/create", Validate.body(schema.exp), Exp.createExp);

router.put("/:expId", handleExperiencesUploadMiddleware.array("files", 6), Exp.updateExp);
router.put("/like/:expId", ExpUtils.updateLikes);

router.delete("/:exp", Exp.deleteExp);

export default router;
