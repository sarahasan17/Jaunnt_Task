import * as redis from "redis";
import Log from "../middlewares/Log";

type RedisClient = ReturnType<typeof redis.createClient>;

export default class Redis {
    private static client: RedisClient;

    public static async connect(): Promise<void> {
        try {
            this.client = redis.createClient({
                socket: {
                    host: "127.0.0.1",
                    port: 6379,
                },
            });
            this.client.on("connect", () => {
                Log.info("Redis :: Connected");
            });
            this.client.on("error", (err: Error) => {
                Log.error(`Redis :: Error: ${String(err.message)}`);
            });
            this.client.on("end", () => {
                Log.info("Redis :: Disconnected");
            });
            await this.client.connect();
        } catch (error: unknown) {
            if (error instanceof Error) {
                Log.error(`Redis :: Error: ${error.message}`);
            }
        }
    }
    public static async add(database: number, key: string, value: string): Promise<void> {
        try {
            this.client.select(database);
            this.client.set(key, value);
        } catch (error: unknown) {
            if (error instanceof Error) {
                Log.error(`Redis :: Error: ${error.message}`);
            }
        }
    }
    public static async get(database: number, key: string): Promise<string> {
        try {
            this.client.select(database);
            const data = await this.client.get(key);
            return data;
        } catch (error: unknown) {
            if (error instanceof Error) {
                Log.error(`Redis :: Error: ${error.message}`);
            }
        }
    }
    public static async delete(database: number, key: string): Promise<void> {
        try {
            this.client.select(database);
            this.client.del(key);
        } catch (error: unknown) {
            if (error instanceof Error) {
                Log.error(`Redis :: Error: ${error.message}`);
            }
        }
    }

    public static async addWithExpiry(database: number, key: string, value: string, expiryTime: number): Promise<void> {
        try {
            this.client.select(database);
            this.client.setEx(key, expiryTime, value);
        } catch (error: unknown) {
            if (error instanceof Error) {
                Log.error(`Redis :: Error: ${error.message}`);
            }
        }
    }
}
