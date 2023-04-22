import * as socketio from "socket.io";
import http from "http";
import jwt from "jsonwebtoken";
import Redis from "./Cache";
import IToken from "../interfaces/Token";
import Log from "../middlewares/Log";

export default class SocketIOService {
    static io: socketio.Server;
    static userIo: socketio.Namespace;
    static defaultDatabase = 0;

    public static init(server: http.Server): void {
        this.io = new socketio.Server(server, {
            cors: {
                origin: "*",
                methods: ["GET", "POST"],
            },
        });

        this.userIo = this.io.of("/chat");

        this.io.on("connection", () => {
            Log.info("Someone connected");
        });

        this.userIo.on("connection", (socket: socketio.Socket) => {
            const authHeader = socket.handshake.headers.authorization;
            let token = authHeader;
            if (!token) {
                return socket.emit("error", "Unauthorized");
            }
            if (token.startsWith("Bearer ")) {
                token = token.slice(7, token.length);
            }
            try {
                const decoded = jwt.verify(token, process.env.JWT_SECRET) as IToken;

                if (!decoded) {
                    return socket.emit("error", "Unauthorized");
                }
                Log.info("Socker:: User connected");
                Redis.add(this.defaultDatabase, decoded.id, socket.id);
            } catch (err) {
                Log.error(err);
                return socket.emit("error", "Unauthorized");
            }

            socket.on("disconnect", () => {
                Log.info("User disconnected");
            });
        });
    }
    public static async emitToUser(userId: string, event: string, data: any): Promise<void> {
        const userSocket = await Redis.get(this.defaultDatabase, userId);
        this.userIo.to(userSocket).emit(event, data);
        Log.info("Emitting to user");
    }
}
