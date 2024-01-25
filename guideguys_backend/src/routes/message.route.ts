import { Router } from "express";
import controller from "../controllers/message.controller";

const router = Router();

router.post('/send/newMessage', controller.saveNewMessage);

export default router;