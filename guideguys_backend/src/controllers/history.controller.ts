import { NextFunction, Request, Response } from "express";
import logging from "../config/logging";
import { AppDataSource } from "../config/data-source";
import { History } from "../entity/history";

const NAMESPACE = 'History';

const createComfirmForm = async (req: Request, res: Response, next: NextFunction) => {
    let newConfirmForm = req.body;
    console.log(newConfirmForm);
    try {
        const historyRepository = AppDataSource.getRepository(History);
        await historyRepository.save(newConfirmForm);

        return res.status(200).json({
            message: "create comfirm successfully",
            newConfirmForm
        });

    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
};

const getWaitingToConfirmForm = async (req: Request, res: Response, next: NextFunction) => {
    try {    
        const historyRepository = AppDataSource.getRepository(History);
        const historyMatch = await historyRepository.createQueryBuilder('history')
        .leftJoinAndSelect('history.customer', 'customer')
        .leftJoinAndSelect('history.guide', 'guide')
        .leftJoinAndSelect('guide.user', 'user')
        .where('customer.username = :username', {username: res.locals.jwt.username})
        .andWhere('user.id = :guideUserId', {guideUserId: req.params.guideUserId})
        .andWhere('history.status = :status', {status: "0"})
        .select(['history.id', 'history.tour_name', 'history.status', 
        'history.start_date', 'history.end_date', 'history.price',
        'guide.id', 'user.username'])
        .getOne();


        if(historyMatch != null){
            return res.status(200).json(
                // historyMatch
                {
                'historyId': historyMatch.id,
                'status': historyMatch.status,
                'tourName': historyMatch.tour_name,
                'guideId': historyMatch.guide.id,
                'guideName': historyMatch.guide.user.username,
                'start_date': historyMatch.start_date,
                'end_date': historyMatch.end_date,
                'price': historyMatch.price,
                }
            );
        } else {
            return res.status(404).json();
        }
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

const getConfirmTourDetail = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const historyRepository = AppDataSource.getRepository(History);
        const historyMatch = await historyRepository.createQueryBuilder('history')
        .innerJoinAndSelect('history.guide', 'guide')
        .innerJoinAndSelect('guide.user', 'user')
        .select(['history', 'guide.card_no', 'guide.languages', 'user.first_name', 'user.last_name', 'user.username'])
        .where('history.id = :historyId', {historyId: req.params.historyId})
        .getOne();

        if(historyMatch != null) {
            return res.status(200).json({
                'historyId': historyMatch.id,
                'guideCardNo': historyMatch.guide.card_no,
                'guideUsername': historyMatch.guide.user.username,
                'guideName': historyMatch.guide.user.first_name + ' ' + historyMatch.guide.user.last_name,
                'languages': historyMatch.guide.languages,
                'tourName': historyMatch.tour_name,
                'startDate': historyMatch.start_date,
                'endDate': historyMatch.end_date,
                'price': historyMatch.price,
                'headcount': historyMatch.headcount,
                'plan': historyMatch.plan,
                'apt_date': historyMatch.appointment_date,
                'apt_place': historyMatch.appointment_place,
            })
        } else {
            return res.status(404).json({
                message: 'Confirm form not found.'
            })
        }
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

const getAllHistoryTour = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const historyRepository = AppDataSource.getRepository(History);
        const allHistory = await historyRepository.createQueryBuilder('history')
        .innerJoinAndSelect('history.tour', 'tour')
        .innerJoinAndSelect('history.customer', 'customer')
        .innerJoinAndSelect('history.guide', 'guide')
        .innerJoinAndSelect('guide.user', 'user')
        .where('customer.username = :username', {username: res.locals.jwt.username})
        .select(['history.id', 'tour.id', 'history.tour_name', 'history.status', 
        'history.start_date', 'history.end_date', 'history.price',
         'guide.id', 'user.username'])
        .getMany();

        if (allHistory != null){
            return res.status(200).json({
                allHistory
            })
        } else {
            return res.status(404).json({
                message: 'Confirm form not found.'
            })
        }
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

const deleteConfirmForm = async (req:Request, res: Response, next: NextFunction) => {

};

export default {
    createComfirmForm, 
    getWaitingToConfirmForm,
    getConfirmTourDetail, 
    deleteConfirmForm, 
    getAllHistoryTour
    };