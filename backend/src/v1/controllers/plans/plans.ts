import Log from "../../middlewares/Log";
import { Request, Response } from "express";
import PlacesSchema from "../../models/places_model";
import { IPlaceModel } from "../../interfaces/Places";
import { IUserModel } from "../../models/user_model";
import User from "../../models/user_model";
import { IUser } from "../../interfaces/User";
import PlansSchema from "../../models/plans_model";
import { IPlansModel } from "../../interfaces/Plans";

function getToken(req: any) {
    if (req.headers.authorization && req.headers.authorization.split(" ")[0] === "Bearer") {
        return req.headers.authorization.split(" ")[1];
    }
    return null;
}
function parseJwt(token: any) {
    return JSON.parse(Buffer.from(token.split(".")[1], "base64").toString());
}

function verifyRole(token: any) {
    const tok = parseJwt(token);
    const role = tok.role;
    if (role != "ADMIN") {
        return false;
    }
    return true;
}

class Plans {
    public static async createPlan(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const adminId = token.id;

            const { planName, placeId, peopleId, planDate } = req.body;

            const place: IPlaceModel = await PlacesSchema.findById(placeId);
            if (!place) {
                return res.status(404).send("Place not found");
            }

            const people = 0;
            const isCompleted = false;

            const plans = new PlansSchema({
                planName,
                placeId,
                peopleId,
                planDate,
                people,
                isCompleted,
                adminId,
            });

            await plans.save();

            return res.status(200).json({
                message: "plan created successfully",
                plans,
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async getPlan(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const person = token.id;
            if (!person) {
                return res.status(404).send("Unauthorized 404");
            }
            const id = req.params.planId;
            const plan: IPlansModel = await PlansSchema.findById(id);
            if (!plan) {
                return res.status(404).send("Place not found");
            }
            return res.status(200).json(plan);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async getUserPlans(req: Request, res: Response): Promise<Response | void> {
        try {
            const tok = getToken(req);
            const token = parseJwt(tok);
            const person = token.id;
            if (!person) {
                return res.status(404).send("Unauthorized 404");
            }
            const plans: IPlansModel = await PlansSchema.findOne({ adminId: person });

            if (!plans) {
                return res.status(404).send("plans not found");
            }
            return res.status(200).json(plans);
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
    public static async updatePlan(req: Request, res: Response): Promise<Response | void> {
        try {
            const planId = req.params.planId;
            const tok = getToken(req);
            const token = parseJwt(tok);
            const userId = token.id;

            const { planName, placeId, peopleId, planDate, isCompleted } = req.body;

            const user: any = await User.findById(userId);
            if (!user) {
                return res.status(404).send("User not found");
            }

            const plan: IPlansModel = await PlansSchema.findById(planId);
            if (!plan) {
                return res.status(404).send("Place not found");
            }

            if (plan.adminId != userId) {
                return res.status(404).send("user not authorised");
            }

            const updateplan: any = await PlansSchema.updateOne(
                { _id: planId },
                {
                    $set: {
                        planName: planName,
                        placeId: placeId,
                        peopleId: peopleId,
                        planDate: planDate,
                        isCompleted: isCompleted,
                    },
                },
                { upsert: true }
            );
            if (!updateplan) {
                return res.status(404).send("Plan not updated");
            }

            return res.status(200).json({
                message: "succesffuly Updated",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }

    public static async deletePlan(req: Request, res: Response): Promise<Response | void> {
        try {
            const planId = req.params.planId;
            const tok = getToken(req);
            const token = parseJwt(tok);
            const userId = token.id;

            const user: any = await User.findById(userId);
            if (!user) {
                return res.status(404).send("User not found");
            }

            const plan: IPlansModel = await PlansSchema.findById(planId, {
                postedBy: true,
            });
            if (!plan) {
                return res.status(404).send("Plan not found");
            }

            if (plan.adminId != userId) {
                return res.status(404).send("user not authorised");
            }

            const deleteplan: any = await PlansSchema.findByIdAndDelete(planId);
            if (!deleteplan) {
                return res.status(404).send("Plan not deleted");
            }
            return res.status(200).json({
                message: "succesffuly deleted",
            });
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default Plans;
