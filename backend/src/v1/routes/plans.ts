import { Router } from "express";
import Plans from "../controllers/Plans/Plans";
import Chat from "../controllers/Plans/Chat";
import Joi from "joi";
import Validate from "../middlewares/Validate";
import { handlePlacesUploadMiddleware } from "../services/file_upload";
const router = Router();

const schema = {
    Plans: Joi.object({
        planName: Joi.string().required(),
        planDate: Joi.string().required(),
        peopleId: Joi.object(),
        placeId: Joi.object().required(),
    }),
    UpdatePlans: Joi.object({
        planName: Joi.string(),
        planDate: Joi.string(),
        peopleId: Joi.object(),
        placeId: Joi.object(),
        isCompleted: Joi.bool(),
    }),
};
router.post("/create", Validate.body(schema.Plans), Plans.createPlan);

router.get("/all", Plans.getUserPlans);
router.get("/:planId", Plans.getPlan);

router.patch("/:planId", Validate.body(schema.UpdatePlans), Plans.updatePlan);
router.delete("/:planId", Plans.deletePlan);

// router.post("/chat", Chat.sendMessage)

export default router;
