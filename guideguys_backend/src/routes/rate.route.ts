import { Router } from "express";
import controller from "../controllers/rate.controller";

const router = Router();

router.post("/add/review", controller.addReview);
router.get("/get/reviewBy/:tourId", controller.getReviewByTourId);

export default router;
