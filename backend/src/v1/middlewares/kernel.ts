import type { Application } from "express";
import Cors from "./Cors";
import Http from "./Http";

class Kernel {
    public static init(_app: Application): Application {
        _app = Cors.init(_app);
        _app = Http.init(_app);
        return _app;
    }
}
export default Kernel;
