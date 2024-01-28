import { NextFunction, Request, Response } from "express";
import { AppDataSource } from "../config/data-source";
import { Payment } from "../entity/payment";
import logging from "../config/logging";
import { History } from "../entity/history";

const NAMESPACE = 'Payment';

const savedPayment = async (req: Request, res: Response, next: NextFunction) => {
    let newPayment = req.body;
    console.log(newPayment.history_id);
    try{
        const paymentRepository = AppDataSource.getRepository(Payment)
        await paymentRepository.save({
            slip: Buffer.from(newPayment.slipImage, 'base64'),
            history: newPayment.history_id
        });

        const historyReposity = AppDataSource.getRepository(History)
        const customerId = await historyReposity.update({id: newPayment.history_id}, {status: '1'})

        return res.status(200).json({
            customerId
        });

    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

export default {savedPayment};