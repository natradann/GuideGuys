import { Column, Entity, JoinTable, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./user";
import { Message } from "./message";

@Entity({name: "chat"})
export class Chat {
    
    @PrimaryGeneratedColumn()
    room_id: number

    @ManyToOne(() => User, (user) => user.chat_user1)
    @JoinTable({name: "user1"})
    user1: User

    @ManyToOne(() => User, (user) => user.chat_user2)
    @JoinTable({name: "user2"})
    user2: User

    @OneToMany(() => Message, (message) => message.chat)
    message: Message[]

}