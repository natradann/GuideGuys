import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./user";
import { Chat } from "./chat";

@Entity({name: "message"})
export class Message {
    map(arg0: (data: any) => { sender_username: any; message_text: any; comment_date: any; }): any {
        throw new Error("Method not implemented.");
    }
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    msg_text: string

    @Column({type: "timestamp"})
    comment_date: string

    @ManyToOne(() => User, (user) => user.sender_msg)
    @JoinColumn({name: "sender_id"})
    sender_id: User

    @ManyToOne(() => Chat, (chat) => chat.message)
    @JoinColumn({name: "chat_room"})
    chat: Chat
}