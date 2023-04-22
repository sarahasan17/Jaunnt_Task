import { Router } from "express";
import Joi from "joi";
import Login from "../controllers/Auth/Login";
import Register from "../controllers/Auth/Register";

import Validate from "../middlewares/Validate";

const router = Router();

const schema = {
    signup: Joi.object({
        fullName: Joi.string().required(),
        email: Joi.string().email(),
        phoneNumber: Joi.string()
            .length(13)
            .pattern(/^[\+]+[0-9]+$/)
            .required(),
        password: Joi.string().required(),
        confirm: Joi.string().required().equal(Joi.ref("password")),
    }),
    login: Joi.object({
        phoneNumber: Joi.string()
            .length(13)
            .pattern(/^[\+]+[0-9]+$/)
            .required(),
        password: Joi.string().required(),
    }),
    verify: Joi.object({
        otpNumber: Joi.string().length(6).required(),
    }),
    forgotPssd: Joi.object({
        phoneNumber: Joi.string()
            .length(13)
            .pattern(/^[\+]+[0-9]+$/)
            .required(),
    }),
    resetPssd: Joi.object({
        phoneNumber: Joi.string()
            .length(13)
            .pattern(/^[\+]+[0-9]+$/)
            .required(),
        Otp: Joi.string().length(6).required(),
        password: Joi.string().required(),
    }),
    newPassword: Joi.object({
        oldPassword: Joi.string().required(),
        newPassword: Joi.string().required(),
        confirm: Joi.string().required().equal(Joi.ref("newPassword")),
    }),
    getotp: Joi.object({
        phoneNumber: Joi.string()
            .length(13)
            .pattern(/^[\+]+[0-9]+$/)
            .required(),
    }),
};

router.post("/login", Validate.body(schema.login), Login.login);
router.post("/forgotPassword", Validate.body(schema.forgotPssd), Login.sendForgotPassword);
router.post("/resetPassword", Validate.body(schema.resetPssd), Login.resetPassword);
router.post("/newPassword", Validate.body(schema.newPassword), Login.newPassword);
router.get("/renewToken/:id", Login.renewToken);

router.post("/signup", Validate.body(schema.signup), Register.signup);
router.post("/verify", Validate.body(schema.verify), Register.verify);
router.post("/resend_otp", Validate.body(schema.getotp), Register.resend);

export default router;
