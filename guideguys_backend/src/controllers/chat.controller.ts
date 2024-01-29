import { NextFunction, Request, Response } from "express";
import logging from "../config/logging";
import { AppDataSource } from "../config/data-source";
import { Chat } from "../entity/chat";
import { Brackets} from "typeorm";
import { User } from "../entity/user";

const NAMESPACE = 'Chat'

const getChatRoom = async (req: Request, res: Response, next: NextFunction) => {
    try {
        var chatUsers = req.body;
        const chatRepository = AppDataSource.getRepository(Chat);
        const chatRoom = await chatRepository.createQueryBuilder('chat')
        .innerJoinAndSelect("chat.user1", "user1")
        .innerJoinAndSelect("chat.user2", "user2")
        .select(["chat.room_id", "user1.id", "user1.username", "user2.id", "user2.username"])
        .where(
            new Brackets((qb) => {
                qb.where("user1.id = :SenderId", { SenderId: chatUsers.senderId })
                .andWhere("user2.id = :ReceiverId", { ReceiverId: chatUsers.receiverId })
            }))
        .orWhere(
            new Brackets((qb) => {
                qb.where("user2.id = :SenderId", {SenderId: chatUsers.senderId})
                .andWhere("user1.id = :ReceiverId", {ReceiverId: chatUsers.receiverId})
            })
        )
        .getOne();

        
        

        if(chatRoom != null) {
            if(chatRoom.user1.id == chatUsers.receiverId) {
                const chatRoomDetail = {
                "room_id": chatRoom.room_id,
                "receiver_username": chatRoom.user1.username,
                }
                return res.status(200).json(chatRoomDetail);
            } else {
                const chatRoomDetail = {
                    "room_id": chatRoom.room_id,
                    "receiver_username": chatRoom.user2.username,
                }
                return res.status(200).json(chatRoomDetail);
            }
        }

        const newChatRoom = await chatRepository.save({
            user1: chatUsers.senderId,
            user2: chatUsers.receiverId
        });

        return res.status(200).json(newChatRoom.room_id);
    } catch(error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

const getChatHistory = async (req: Request, res: Response, next: NextFunction) => {
    let room = req.params.chatRoom;
    try {
        const chatRepository = AppDataSource.getRepository(Chat);
        const allMessages = await chatRepository.createQueryBuilder('chat')
        .leftJoinAndSelect("chat.message", "message")
        .leftJoinAndSelect("message.sender_id", "sender_msg")
        .select(["chat.room_id", "message.id","message.msg_text", "message.comment_date", "sender_msg.username"])
        .where("chat.room_id = :roomId", {roomId: room})
        .getOne();

        return res.status(200).json(
            allMessages.message.map((data) => ({
                "sender_username": data.sender_id.username,
                "message_text": data.msg_text,
                "comment_date": data.comment_date,
            }))
        );
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

const getAllChatRoom = async (req: Request, res: Response, next:NextFunction) => {
    try {
        const chatRepository = AppDataSource.getRepository(Chat);
        const allChatRoom = await chatRepository.createQueryBuilder('chat')
        .innerJoinAndSelect("chat.user1", "user1")
        .innerJoinAndSelect("chat.user2", "user2")
        .leftJoinAndSelect("chat.message", "message",)
        .select([
            "chat.room_id",
            "user1.id", 
            "user1.username", 
            "user1.img",
            "user2.id", 
            "user2.username", 
            "user2.img",
            "message",
        ])
        .where('user1.id = :userId', {userId: req.params.userId})
        .orWhere('user2.id = :userId', {userId: req.params.userId})
        .orderBy('message.comment_date', 'DESC')
        .getMany()

        return res.status(200).json(
            allChatRoom.map((chatRoom) => ({
                "room_id": chatRoom.room_id,
                "user1_id": chatRoom.user1.id,
                "user1_username": chatRoom.user1.username,
                "user2_id": chatRoom.user2.id,
                "user2_username": chatRoom.user2.username,
                "receiver_img": (chatRoom.user1.id == req.params.userId) ? 
                (chatRoom.user2.img != null) ? Buffer.from(chatRoom.user2.img).toString('base64') : null
                : (chatRoom.user1.img != null) ? Buffer.from(chatRoom.user1.img).toString('base64') : null,
                "last_msg": chatRoom.message[0] ?? {}
            }))
        );
    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

export default {getChatRoom, getChatHistory, getAllChatRoom};