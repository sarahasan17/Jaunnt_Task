import { S3Client } from "@aws-sdk/client-s3";
import multer, { FileFilterCallback } from "multer";
import multerS3 from "multer-s3";
import { Request } from "express";
import { v4 as uuidv4 } from "uuid";
import dotenv from "dotenv";

dotenv.config();

export const S3 = new S3Client({
    region: process.env.REGION,
    credentials: {
        accessKeyId: process.env.AWS_ACCESS,
        secretAccessKey: process.env.SECRET_ACCESS,
    },
});

const isAllowedMimetype = (mime: string) =>
    ["image/png", "image/jpg", "image/jpeg", "image/gif", "image/x-ms-bmp", "image/webp"].includes(mime.toString());
const fileFilter = (req: Request, file: Express.Multer.File, callback: FileFilterCallback) => {
    const fileMime = file.mimetype;
    if (isAllowedMimetype(fileMime)) {
        callback(null, true);
    } else {
        callback(null, false);
    }
};
const getUniqFileName = (originalname: string) => {
    const name = uuidv4();
    const ext = originalname.split(".").pop();
    return `${name}.${ext}`;
};

export const handleUploadMiddleware = multer({
    fileFilter,
    storage: multerS3({
        s3: S3,
        bucket: process.env.BUCKET_NAME,
        acl: "public-read",
        contentType: multerS3.AUTO_CONTENT_TYPE,
        key: function (req: Request, file: any, cb) {
            const fileName = getUniqFileName(file.originalname);
            const s3_inner_directory = "profilePhoto";
            const finalPath = `${s3_inner_directory}/${fileName}`;

            file.newName = fileName;

            cb(null, finalPath);
        },
    }),
});

export const handleExperiencesUploadMiddleware = multer({
    fileFilter,
    storage: multerS3({
        s3: S3,
        bucket: process.env.BUCKET_NAME,
        acl: "public-read",
        contentType: multerS3.AUTO_CONTENT_TYPE,
        key: function (req: Request, file: any, cb) {
            const fileName = getUniqFileName(file.originalname);
            const s3_inner_directory = "experincesPhotos";
            const finalPath = `${s3_inner_directory}/${fileName}`;

            file.newName = fileName;

            cb(null, finalPath);
        },
    }),
});

export const handlePlacesUploadMiddleware = multer({
    fileFilter,
    storage: multerS3({
        s3: S3,
        bucket: process.env.BUCKET_NAME,
        acl: "public-read",
        contentType: multerS3.AUTO_CONTENT_TYPE,
        key: function (req: Request, file: any, cb) {
            const fileName = getUniqFileName(file.originalname);
            const s3_inner_directory = "placesPhotos";
            const finalPath = `${s3_inner_directory}/${fileName}`;

            file.newName = fileName;

            cb(null, finalPath);
        },
    }),
});
