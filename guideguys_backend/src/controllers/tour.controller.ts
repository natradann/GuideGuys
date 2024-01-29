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
        await tourRepository.save({
            name: newTour.tourName,
            guide: guideMatch.guide_id,
            img: Buffer.from(newTour.img, 'base64'),
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
        // .where("tour.id = :tourId", {tourId: 6})
        .getRawMany();


        return res.status(200).json(
            allTours.map((tour) => ({
                "tour_id": tour.tour_id,
                "tour_name": tour.tour_name,
                "tour_img": tour.tour_img != null ? Buffer.from(tour.tour_img).toString('base64') : null,
                "user_id": tour.user_id,
                "user_username": tour.user_username,
                "guide_languages": tour.guide_languages,
                "tour_convinces": tour.tour_convinces,
                "tour_vehicles": tour.tour_vehicle,
                "tour_type": tour.tour_type,
                "tour_detail": tour.tour_detail,
                "tour_price": tour.tour_price,
                "tour_point": tour.tour_point,
                "tour_created_at": tour.tour_created_at,
                "tour_guide_id": tour.tour_guide_id
            }))
        )
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
        .select(["user.id", "user.username", "user.img", "guide.languages", "tour"])
        .where("tour.id = :tourId", {tourId: req.params.tourId})
        .getRawOne();

        return res.status(200).json({
            "tour_id": tourDetail.tour_id,
            "tour_name": tourDetail.tour_name,
            "tour_img": (tourDetail.tour_img != null) ? Buffer.from(tourDetail.tour_img).toString('base64') : null,
            "user_id": tourDetail.user_id,
            "user_username": tourDetail.user_username,
            "guide_img": (tourDetail.user_img != null) ? Buffer.from(tourDetail.user_img).toString('base64') : null,
            "guide_languages": tourDetail.guide_languages,
            "tour_convinces": tourDetail.tour_convinces,
            "tour_vehicles": tourDetail.tour_vehicle,
            "tour_type": tourDetail.tour_type,
            "tour_detail": tourDetail.tour_detail,
            "tour_price": tourDetail.tour_price,
            "tour_point": tourDetail.tour_point,
            "tour_created_at": tourDetail.tour_created_at,
            "tour_guide_id": tourDetail.tour_guide_id
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
            return res.status(200).json(
                // allTours
                allTours.map((tour) => ({
                    tour_id: tour.tour_id,
                    tour_name: tour.tour_name,
                    tour_img: (tour.tour_img != null) ? Buffer.from(tour.tour_img).toString('base64') : null,
                    tour_convinces: tour.tour_convinces,
                    tour_vehicle: tour.tour_vehicle,
                    tour_type: tour.tour_type,
                    tour_price: tour.tour_price,
                    tour_point: tour.tour_point,
                    guide_languages: tour.guide_languages
                }))
            )
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