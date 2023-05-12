import cors from "cors";
import type { Application } from "express";
import log from "../utils/Logger";

class Cors {
    public static init(_app: Application): Application {
        log.info("Initializing CORS middleware");

        const corsOptions = {
            origin: "*",
            optionsSuccessStatus: 200,
        };
        _app.use(cors(corsOptions));

        return _app;
    }
}

export default Cors;
