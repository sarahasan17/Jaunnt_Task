import log from "../utils/Logger";
import Express from "./Express";
import { Database } from "./Database";
import Redis from "./Cache";

class App {
    public loadServer(): void {
        log.info("Server :: Loading...");
        Express.init();
    }

    public loadDatabase(): void {
        log.info("Database :: Loading...");

        Database.connect();
    }
    // public loadCache(): void {
    //   log.info('Cache :: Loading...');
    //   Redis.connect();
    // }
}

export default new App();
