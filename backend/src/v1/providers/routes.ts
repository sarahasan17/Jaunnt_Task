import type { Application } from "express";
import log from "../utils/Logger";
import AuthRouter from "../routes/Auth";
import UsersRouter from "../routes/Users";
import ExpRouter from "../routes/Exp";
import PlaceRouter from "../routes/Places";
import PlansRouter from "../routes/Plans";

class Routes {
    public mount(_app: Application): Application {
        log.info("Initializing routes");
        _app.use("/auth", AuthRouter);
        _app.use("/users", UsersRouter);
        _app.use("/exp", ExpRouter);
        _app.use("/places", PlaceRouter);
        _app.use("/plans", PlansRouter);

        return _app;
    }
}

export default new Routes();
