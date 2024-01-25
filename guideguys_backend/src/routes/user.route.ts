import { Router } from "express";
import controller from '../controllers/user.controller';
import extractJWT from "../middleware/extractJWT";

const router = Router();

router.get('/validate', extractJWT ,controller.validateToken);
router.post('/register', controller.register);
router.post('/login', controller.login);
router.get('/get/all', controller.getAllUsers);

export default router;