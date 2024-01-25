import "reflect-metadata";
import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, OneToOne, JoinColumn, OneToMany } from "typeorm";
import { Guide } from "./guide";
import { History} from "./history";
import { Rate } from "./rate";
import { Chat } from "./chat";
import { Message } from "./message";

@Entity({ name: "user"})
export class User {

    @PrimaryGeneratedColumn("uuid")
    id: string

    @Column({nullable: false, unique:true})
    username: string

    @Column({nullable: false, unique:true})
    email: string

    @Column({nullable: false})
    password: string

    @Column({nullable: false})
    first_name: string

    @Column({nullable: false})
    last_name: string

    @Column()
    phone_number: string
    
    @OneToOne(() => Guide)
    @JoinColumn({name: "guide_id"})
    guide: Guide

    @CreateDateColumn({type: "timestamp", nullable: false})
    created_at: string

    @OneToMany(() => History, (history) => history.customer)
    history: History

    @OneToMany(() => Rate, (rate) => rate.user_id)
    rate: Rate

    @OneToMany(() => Chat, (chat) => chat.user1)
    chat_user1: Chat

    @OneToMany(() => Chat, (chat) => chat.user2)
    chat_user2: Chat

    @OneToMany(() => Message, (message) => message.sender_id)
    sender_msg: Message


}
