import { NextFunction, Request, Response } from "express";
import logging from "../config/logging";
import { AppDataSource } from "../config/data-source";
import { Message } from "../entity/message";

const NAMESPACE = 'Message';

const saveNewMessage = async (req: Request, res: Response, next: NextFunction) => {
    try {
        let newMessage = req.body;

        const messageRepository = AppDataSource.getRepository(Message);
        const resBody = await messageRepository.save({
            'chat': newMessage.chatRoom,
            'msg_text': newMessage.msgText,
            'comment_date': newMessage.createAt,
            'sender_id': newMessage.senderId
        });

        const savedMessage = await messageRepository.createQueryBuilder('message')
        .innerJoinAndSelect("message.sender_id", "sender_msg")
        .select(["message.id","message.msg_text", "message.comment_date", "sender_msg.username"])
        .where("message.id = :msgId", {msgId: resBody.id})
        .getOne()

        return res.status(200).json({
            "sender_username": savedMessage.sender_id.username,
            "message_text": savedMessage.msg_text,
            "comment_date": savedMessage.comment_date,
        });

    } catch (error) {
        logging.error(NAMESPACE, error.message, error);

        return res.status(500).json({
            message: error.message,
            error
        });
    }
}

export default {saveNewMessage};