import dotenv from "dotenv";

dotenv.config({
    path: "./.env",
});

import App from "./v1/providers/app";

App.loadDatabase();
// App.loadCache();
App.loadServer();
