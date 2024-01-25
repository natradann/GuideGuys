import { Router } from "express";
import controller from '../controllers/history.controller';
import extractJWT from "../middleware/extractJWT";

const router = Router();

router.post('/create/form', controller.createComfirmForm);
router.get('/get/confirmForm/:historyId', controller.getConfirmTourDetail);
router.get('/get/waiting/confirm', extractJWT, controller.getWaitingToConfirmForm);
router.get('/get/all', extractJWT, controller.getAllHistoryTour);

export default router;