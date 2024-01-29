import { NextFunction, Request, Response } from 'express';
import bcryptjs from 'bcryptjs';
import logging from '../config/logging';
import signJWT from '../functions/signJWT';
import { AppDataSource } from '../config/data-source';
import { User } from '../entity/user';

const NAMESPACE = 'User';

const validateToken = (req: Request, res: Response, next: NextFunction) => {
    logging.info(NAMESPACE, 'Token validated, user authorized.');

    const result = res.locals.jwt
    return res.status(200).json({
        message: 'Token(s) validated',
       result
    });
};

const register = async (req: Request, res: Response, next: NextFunction) => {
    let newUser = req.body;
    console.log(newUser);
    try {
        const usersRepository = AppDataSource.getRepository(User);
        const userMatch = await usersRepository.createQueryBuilder("user")
        .where("user.username = :username", {username: newUser.username})
        .orWhere("user.email = :email", {email: newUser.email})
        .getOne()
        if (userMatch != null) {
            return res.status(401).json({
                message: 'User already exists',
                userMatch
            });
        } else {
            bcryptjs.hash(newUser.password, 10, async (hashError, hash) => {
                if (hashError) {
                    return res.status(403).json({
                        message: hashError.message,
                        error: hashError
                    });
                }
            
                newUser.password = hash;
                const userSaved = await usersRepository.save({
                    username: newUser.username,
                    email: newUser.email,
                    password: newUser.password,
                    first_name: newUser.first_name,
                    last_name: newUser.last_name,
                    img: Buffer.from(newUser.img, 'base64'),
                    phone_number: newUser.phone_number,
                })
                signJWT(newUser, (_error, token) => {
                    if (_error) {
                        return res.status(402).json({
                            message: 'Unable to Sign JWT',
                            error: _error,
                        });
                    } else if (token) {
                        return res.status(200).json({
                            token: token,
                            user_id: userSaved.id,
                            username: userSaved.username,
                        });
                    }
                });
            });
        }
    } catch (error) {
        return res.status(500).json({
            message: error.message,
            error,
        });
    }
};

const login = async (req: Request, res: Response, next: NextFunction) => {
    let { username, password } = req.body;
    try {
        const usersRepository = AppDataSource.getRepository(User);
        const userMatch = await usersRepository.createQueryBuilder("user")
        .leftJoinAndSelect("user.guide", "guide")
        .where("user.username = :username", {username: username})
        .orWhere("user.email = :email", {email: username})
        .getOne()

        if (userMatch) {
            console.log(userMatch.password);

            // Use compareSync instead of compare
            const passwordMatch = bcryptjs.compareSync(password, userMatch.password);

            if (!passwordMatch) {
                return res.status(401).json({
                    message: 'Password Mismatch',
                });
            }

            // Rest of your code for successful password match
            signJWT(userMatch, (_error, token) => {
                if (_error) {
                    return res.status(402).json({
                        message: 'Unable to Sign JWT',
                        error: _error,
                    });
                } else if (token) {
                    return res.status(200).json({
                        token: token,
                        user_id: userMatch.id,
                        username: userMatch.username,
                        guide_id: (userMatch.guide != null) ? userMatch.guide.id : null,
                        user_email: userMatch.email
                    });
                }
            });
        } else {
            logging.info(NAMESPACE, 'User not found');

            return res.status(404).json({
                message: 'User not found',
            });
        }
    } catch (error) {
        logging.error(error.message, error);

        return res.status(500).json({
            message: error.message,
            error,
        });
    }
};

const getAllUsers = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const usersRepository = AppDataSource.getRepository(User);
        const users = await usersRepository.createQueryBuilder("user").getRawMany();
        console.log(users);
        
        return res.status(200).json({
            users
        });
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);
        return res.status(500).json({
            message: error.message,
            error
        });
    }
};

export default { validateToken, register, login, getAllUsers };