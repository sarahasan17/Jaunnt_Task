import * as mongoose from "mongoose";
import log from "../utils/Logger";
import dotenv from "dotenv";

dotenv.config();

export class Database {
    public static async connect(): Promise<void> {
        try {
            const dbUri = process.env.MONGO_DB_URI;
            await mongoose.connect(dbUri);
            log.info("Database :: Connected");
        } catch (error: unknown) {
            if (error instanceof Error) {
                log.error(`Database :: Error: ${error.message}`);
            }
            else{
                log.error(`Database :: Unexpected error`, {error});
            }
        }
    }
}

export default mongoose;
