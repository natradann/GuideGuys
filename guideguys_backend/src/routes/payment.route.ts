import { Router } from "express";
import controller from '../controllers/payment.controller';

const router = Router();

router.post('/create/proof', controller.savedPayment);

export default router;