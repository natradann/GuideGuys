import { NextFunction, Request, Response } from "express"
import { AppDataSource } from "../config/data-source";
import { Guide } from "../entity/guide";
import { User } from "../entity/user";
import logging from "../config/logging";

const NAMESPACE = 'Guide'

const guideRegister = async (req: Request, res: Response, next: NextFunction) => {
    let newGuide = req.body;
    let guideUsername = res.locals.jwt.username;
    console.log(newGuide);
    console.log(guideUsername);
    try {
        const userRepository = AppDataSource.getRepository(User);
        const userMatch = await userRepository.findOneBy({
            username: guideUsername
        })
        
        if (userMatch == null) {
            return res.status(401).json({
                message: 'User not found',
            });
        } else {
            const guideRepository = AppDataSource.getRepository(Guide);
            const guideMatch = await guideRepository.findOneBy({
                card_no: newGuide.card_no
            })
            if (guideMatch != null) {
            return res.status(402).json({
                message: 'Guide already exists',
                guideMatch
                });
            } else {
                const savedGuide = await guideRepository.save({
                    card_img: Buffer.from(newGuide.card_img, 'base64'),
                    card_no: newGuide.card_no,
                    type: newGuide.type,
                    card_expired: newGuide.card_expired,
                    convinces: newGuide.convinces,
                    languages: newGuide.languages,
                    experience: newGuide.experience,
                    point: newGuide.point,
                  });
                const userRepository = AppDataSource.getRepository(User);
                await userRepository.update({username: guideUsername}, {guide: savedGuide});
                return res.status(200).json({
                    message: 'Guide Register complete',
                    userMatch,
                    newGuide
                })
            }
        }
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

const getAllGuides = async (req: Request, res: Response, next: NextFunction) => {
    try{
        const userRepositoty = AppDataSource.getRepository(User);
        const guides = await userRepositoty.createQueryBuilder("user")
        .innerJoinAndSelect("user.guide", "guide")
        .leftJoinAndSelect('guide.tour', 'tour')
        .select(['user.username', 'guide.id', 'user.img', 'guide.point',
         'guide.convinces', 'guide.languages', 'tour.type', 'tour.vehicle'])
        .getMany();

        // for( in allGuides){

        // }

        const allGuides =  guides.map((guide) => ({
                username: guide.username,
                guide_id: guide.guide.id,
                guide_img: (guide.img != null) ? Buffer.from(guide.img).toString('base64') : null,
                guide_convinces: guide.guide.convinces,
                guide_languages: guide.guide.languages,
                guide_tour_type: Array.from(new Set(guide.guide.tour.flatMap(tour => tour.type))),
                guide_vehicle: Array.from(new Set(guide.guide.tour.flatMap(tour => tour.vehicle))),
                guide_point: guide.guide.point,
            }));

        return res.status(200).json(
            // guides,
            allGuides
            );

    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
};

const getGuideProfileAndTourByGuideId = async (req: Request, res: Response, next: NextFunction) => {

    try {
        const userRepository = AppDataSource.getRepository(User);
        const guide = await userRepository.createQueryBuilder("user")
        .leftJoinAndSelect("user.guide", "guide")
        .leftJoinAndSelect("guide.tour", "tour")
        .select(['user.id', 'user.username', 'user.first_name', 
        'user.last_name', 'user.img', 'guide', 'tour.id', 'tour.name', 
        'tour.img', 'tour.convinces', 'tour.type', 'tour.price', 'tour.point'])
        .where("user.guide_id = :guideId", {guideId: req.params.guideId})
        .getOne();

        const guideInfo = guide.guide;

        return res.status(200).json({
            "userId": guide.id,
            "username": guide.username,
            "firstName": guide.first_name,
            "lastName": guide.last_name,
            "guide_img": (guide.img) ? Buffer.from(guide.img).toString('base64') : null,
            "guideId": guideInfo.id,
            "guideCardNo": guideInfo.card_no,
            "guideType": guideInfo.type,
            // "guideImg": guideInfo.guide_img,
            "guideCardExpired": guideInfo.card_expired,
            "guidePoint": guideInfo.point,
            "convinces": guideInfo.convinces,
            "languages": guideInfo.languages,
            "experience": guideInfo.experience,
            "guideRatePoint": guideInfo.point,
            "tours": guideInfo.tour,
        })
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);
        return res.status(500).json({
            message: error.message,
            error
        });
    }
};

const getGuideInfoForConfirmForm = async (req: Request, res: Response, next: NextFunction) => {
    let guideUsername = res.locals.jwt.username;
    console.log(guideUsername);
    try {
        const userRepository = AppDataSource.getRepository(User);
        const guideMatch = await userRepository.createQueryBuilder('user')
        .innerJoinAndSelect('user.guide', 'guide')
        .leftJoinAndSelect("guide.tour", "tour")
        .select(['user.first_name', 'user.last_name',
        'guide.id', 'guide.card_no', 'guide.languages',
        'tour.id', 'tour.name'])
        .where('user.username = :username', {username: guideUsername})
        .getOne();

        return res.status(200).json({
            // guideMatch
            "guideId": guideMatch.guide.id,
            "guideName": guideMatch.first_name + ' ' + guideMatch.last_name,
            "CardNo": guideMatch.guide.card_no,
            "languages": guideMatch.guide.languages,
            "tour": guideMatch.guide.tour,
        })
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);
        return res.status(500).json({
            message: error.message,
            error
        });
    }

}

const filterSearchGuide =  (req: Request, res: Response, next: NextFunction) => {
    let searchText = req.body;

    try {
        
    } catch (error) {
        
    }
}

export default {
    guideRegister, 
    getAllGuides, 
    getGuideProfileAndTourByGuideId, 
    filterSearchGuide, 
    getGuideInfoForConfirmForm
};