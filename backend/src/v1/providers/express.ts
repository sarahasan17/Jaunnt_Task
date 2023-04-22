import express from "express";
import http from "http";
import Kernel from "../middlewares/Kernel";
import SocketIOService from "./Sockets";
import Routes from "./Routes";
import dotenv from "dotenv";
import Log from "../middlewares/Log";

dotenv.config();

class Express {
    public express: express.Application;
    private server: http.Server;

    constructor() {
        this.express = express();
        this.createServer();
        this.mountMiddlewares();
        this.mountRoutes();
    }

    public init(): any {
        const port = process.env.PORT || 3000;
        SocketIOService.init(this.server);
        this.express.use(function (req: any, res, next) {
            res.locals.user = req.user || null;
            next();
        });
        this.express
            .listen(port, () => {
                Log.info(`Server :: Running @ 'http://localhost:${port}'`);
            })
            .on("error", (_error) => {
                Log.error("Error: " + _error.message);
            });
    }

    private mountRoutes(): void {
        this.express = Routes.mount(this.express);
    }

    private mountMiddlewares(): void {
        this.express = Kernel.init(this.express);
    }

    private createServer(): void {
        this.server = http.createServer(this.express);
    }
}

export default new Express();
