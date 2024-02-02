import { NextFunction, Request, Response } from "express";
import logging from "../config/logging";
import { AppDataSource } from "../config/data-source";
import { History } from "../entity/history";
import { User } from "../entity/user";

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
        .leftJoinAndSelect('history.tour', 'tour')
        .innerJoinAndSelect('history.customer', 'customer')
        .innerJoinAndSelect('history.guide', 'guide')
        .innerJoinAndSelect('guide.user', 'user')
        .where('customer.username = :username', {username: res.locals.jwt.username})
        .select(['history.id', 'tour.id', 'history.tour_name', 'history.status', 
        'history.start_date', 'history.end_date','history.price',
        'guide.id', 'user.username'])
        .getMany();

        const userRepository = AppDataSource.getRepository(User)
        const userImage = await userRepository.createQueryBuilder('user')
        .select(["user.id", "user.img"])
        .where("username = :userUsername", {userUsername: res.locals.jwt.username})
        .getOne();

        allHistory.forEach(async (history) => {
            if (new Date(history.end_date) < new Date() && history.status == '1') {
                try {
                    await historyRepository.update({id: history.id}, {status: '2'})
                } catch (error) {
                    logging.error(NAMESPACE, error.message, error);
                    res.status(401).json({
                        message: 'Error on updating status history',
                        error
                    });
                }
            }
        });

        if (allHistory != null){
            return res.status(200).json({
                customer_img: (userImage.img != null) 
                ? Buffer.from(userImage.img).toString('base64') 
                : null,
                histories: allHistory.map((history) => ({
                    history_id: history.id,
                    status: history.status,
                    tour_id: history.tour.id,
                    tour_name: history.tour_name,
                    guide_id: history.guide.id,
                    guide_username: history.guide.user.username,
                    start_date: history.start_date,
                    end_date: history.end_date,
                    price: history.price,
                }))
                // allHistory
            })
        } else {
            return res.status(404).json({
                customer_img: (userImage.img != null) 
                ? Buffer.from(userImage.img).toString('base64')
                : null,
                histories: {}
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