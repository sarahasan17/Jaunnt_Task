import Log from "../../middlewares/Log";
import { Request, Response } from "express";

class Chat {
    public static async sendMessage(req: Request, res: Response): Promise<Response | void> {
        try {
        } catch (error: any) {
            Log.error(error);
            return res.status(500).send("Internal server error");
        }
    }
}

export default Chat;
