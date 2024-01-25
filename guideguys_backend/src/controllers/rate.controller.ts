import { NextFunction, Request, Response } from "express";
import logging from "../config/logging";
import { AppDataSource } from "../config/data-source";
import { Rate } from "../entity/rate";
import { Tour } from "../entity/tour";
import { Guide } from "../entity/guide";
import { History } from "../entity/history";

const NAMESPACE = 'Rate';

const addReview = async (req: Request, res: Response, next: NextFunction) => {
    let newRate = req.body;
    // console.log(newRate);
    try {
        const rateRepository = AppDataSource.getRepository(Rate);
        await rateRepository.save(newRate);

        const historyRepository = AppDataSource.getRepository(History);

        await historyRepository.update({id: newRate.history_id}, {status: "complete"});

        const historyMatch = await historyRepository.createQueryBuilder("history")
        .innerJoinAndSelect('history.tour', 'tour')
        .innerJoinAndSelect('history.guide', 'guide')
        .select(['tour.id', 'guide.id'])
        .where('history.id = :historyId', {historyId: newRate.history_id})
        .getRawOne()

        let tourId = historyMatch.tour_id;
        let guideId = historyMatch.guide_id;

        const tourRepository = AppDataSource.getRepository(Tour);
        const tourRateMatch = await tourRepository.createQueryBuilder("tour")
        .innerJoinAndSelect("tour.rate", "rate")
        .select(["tour.id", "rate"])
        .where("tour.id = :tourId", {tourId: tourId})
        .getOne();

        console.log('dv');

        
        let sumTourRate = 0;
        let avgTourRate: number;
        if (Array.isArray(tourRateMatch.rate)) {
            console.log(tourRateMatch.rate)
            for (var index in tourRateMatch.rate){
                sumTourRate += tourRateMatch.rate[index].point;
            }

            const rateLength = tourRateMatch.rate.length;
            avgTourRate = Number((sumTourRate/rateLength).toFixed(2));
            console.log("Length of rate array:", rateLength);
            console.log("average of points:", avgTourRate);

            await tourRepository.update({id: tourRateMatch.id}, {point: avgTourRate});
        } else {
            logging.info(NAMESPACE, "No rate information found or rate is not an array.")

            return res.status(400).json({
                message: "",
            })
        }

        const guideRepository = AppDataSource.getRepository(Guide);
        const guideRateMath = await  guideRepository.createQueryBuilder("guide")
        .leftJoinAndSelect("guide.tour", "tour")
        .select(["guide.id", "tour.point"])
        .where("guide.id = :guideId", {guideId: guideId})
        .getOne();

        let sumGuideRate = 0;
        let avgGuideRate: number;
        if(Array.isArray(guideRateMath.tour)){
            for (var index in guideRateMath.tour) {
                sumGuideRate += guideRateMath.tour[index].point;
                console.log(sumGuideRate);
            }

            avgGuideRate = Number((sumGuideRate/guideRateMath.tour.length).toFixed(2));
            console.log("Length of rate array:", guideRateMath.tour.length);
            console.log("average of points:", avgGuideRate);

            await guideRepository.update({id: newRate.guide_id}, {point: avgGuideRate});
        } else {
            logging.info(NAMESPACE, "No rate information found or rate is not an array.")

            return res.status(401).json({
                message: "Guide rate information is not array",
            })
        }

        return res.status(200).json({
            message: "add new review successfully",
            guideRateMath
        })
        
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

const getReviewByTourId = async (req: Request, res: Response, next: NextFunction) => {
    
    try {
        console.log('mk');
        const tourRepository = AppDataSource.getRepository(Tour);
        const allRateOfTourMatch = await tourRepository.createQueryBuilder("tour")
        .leftJoinAndSelect('tour.rate', 'rate')
        .leftJoinAndSelect('rate.user_id', 'user')
        .select(['tour.id', 'tour.name', 'tour.point', 'rate', 'user.id', 'user.username'])
        .where("tour.id = :tourId", {tourId: req.params.tourId})
        .getOne();

        if (allRateOfTourMatch != null) {
            return res.status(200).json({
            allRateOfTourMatch
            });
        } else {
            return res.status(401).json({
                message: 'Tour not found'
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

export default {addReview, getReviewByTourId};