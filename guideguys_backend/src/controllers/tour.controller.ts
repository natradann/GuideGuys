import { NextFunction, Request, Response } from "express";
import { AppDataSource } from "../config/data-source";
import logging from "../config/logging";
import { Tour } from "../entity/tour";
import { User } from "../entity/user";
import { Guide } from "../entity/guide";

const NAMESPACE = 'Tour';

const createTour = async (req: Request, res: Response, next: NextFunction) => {
    let newTour = req.body;
    let guideUsername = res.locals.jwt.username;
    console.log(guideUsername);
    try {
        const tourRepository = AppDataSource.getRepository(Tour);

        const userRepository = AppDataSource.getRepository(User);
        const guideMatch = await userRepository.createQueryBuilder("user")
        .select(['user.guide'])
        .where("username = :username", {username: guideUsername})
        .getRawOne();
        console.log(guideMatch.guide_id)
        await tourRepository.save({
            name: newTour.tourName,
            guide: guideMatch.guide_id,
            convinces: newTour.convinces,
            vehicle: newTour.vehicle,
            type: newTour.tourType,
            detail: newTour.detail,
            price: newTour.price,
            point: 0,
        });
        return res.status(200).json({
            message: "create tour successfully",
            newTour
        })
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error,
        });
    }
};

const getAllTours = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const guideRepository = AppDataSource.getRepository(Tour);
        const allTours = await guideRepository.createQueryBuilder("tour")
        .innerJoinAndSelect("tour.guide", "guide")
        .select([ "tour.id", "tour.name", "tour.img",
        "tour.convinces", "tour.vehicle", "tour.type", 
        "tour.price", "tour.point", "guide.languages"])
        .getRawMany();

        return res.status(200).json({
            allTours
        })
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error,
        });
    }
};

const getTourDetailByTourId = async (req: Request, res: Response, next: NextFunction) => {
    try {
        console.log(req.params.tourId);
        const userRepository = AppDataSource.getRepository(User);
        const tourDetail = await userRepository.createQueryBuilder("user")
        .leftJoinAndSelect("user.guide", "guide")
        .leftJoinAndSelect("guide.tour", "tour")
        .select(["user.id", "user.username", "guide.languages", "tour"])
        .where("tour.id = :tourId", {tourId: req.params.tourId})
        .getRawOne();

        return res.status(200).json({
            tourDetail
        })
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error,
        });
    }
};

const getTourListByToken = async (req: Request, res: Response, next: NextFunction) => {
    try{
        const tourRepository = AppDataSource.getRepository(Tour)
        const allTours = await tourRepository.createQueryBuilder('tour')
        .innerJoinAndSelect('tour.guide', 'guide')
        .innerJoinAndSelect('guide.user', 'user')
        .where('user.username = :username', {username: res.locals.jwt.username})
        .select([ "tour.id", "tour.name", "tour.img",
        "tour.convinces", "tour.vehicle", "tour.type", 
        "tour.price", "tour.point", "guide.languages"])
        .getRawMany();

        if (allTours != null){
            return res.status(200).json({
                allTours
            })
        } else {
            return res.status(404).json({
                message: 'guide has no tour'
            })
        }

    } catch(error){
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error,
        });
    }
}


export default {createTour, getAllTours, getTourDetailByTourId, getTourListByToken};