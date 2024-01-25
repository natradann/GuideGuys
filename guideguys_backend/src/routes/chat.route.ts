import { Router } from "express";
import controller from "../controllers/chat.controller";

const router = Router();

router.post('/create/chat/room', controller.getChatRoom);
router.get('/get/chat/history/:chatRoom', controller.getChatHistory);
router.get('/get/all/chatRoom/:userId', controller.getAllChatRoom);

export default router;