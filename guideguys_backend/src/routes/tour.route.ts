import { Router } from "express";
import extractJWT from "../middleware/extractJWT";
import controller from "../controllers/tour.controller";

const router = Router();
;
router.post('/create', extractJWT, controller.createTour);
router.get('/get/all', controller.getAllTours);
router.get('/get/datail/:tourId', controller.getTourDetailByTourId)
router.get('/get/tour/list', extractJWT, controller.getTourListByToken)

export default router;