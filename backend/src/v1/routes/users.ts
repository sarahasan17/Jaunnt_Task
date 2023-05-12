import { Router } from "express";
import Users from "../controllers/Users/User";
import { handleUploadMiddleware } from "../services/file_upload";

const router = Router();

router.get("/all", Users.getUsers);
router.get("/:user", Users.getUser);
//update to jwt

router.put("/:user", handleUploadMiddleware.array("files", 6), Users.uploadProfile);
router.patch("/:user", Users.deleteTempUser);

router.get("/followers", Users.GetUserFollowers);
router.get("/following", Users.GetUserFollowing);
router.put("/follow/:followUserId", Users.UpdateFollow);
router.put("/unfollow/:unfollowUserId", Users.UpdateUnfollow);

router.delete("/:user", Users.deleteUser);

router.get("/bookmarks", Users.GetUserBookMarks);

export default router;
