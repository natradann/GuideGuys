import { Router } from "express";
import controller from "../controllers/guide.controller";
import extractJWT from "../middleware/extractJWT";

const router = Router();

router.post("/register", extractJWT, controller.guideRegister);
router.get("/get/all", extractJWT, controller.getAllGuides);
router.get("/get/profile/:guideId", controller.getGuideProfileAndTourByGuideId);
router.get("/get/guideInfo/forConfirmForm", extractJWT, controller.getGuideInfoForConfirmForm);

export default router;