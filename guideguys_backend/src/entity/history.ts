import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./user";
import { Tour } from "./tour";
import { Guide } from "./guide";
import { Rate } from "./rate";

@Entity({ name: "history"})
export class History {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    status: string

    @ManyToOne(() => User, (user) => user.id)
    @JoinColumn({name: 'customer_id'})
    customer: User

    @ManyToOne(() => Guide, (guide) => guide.id)
    @JoinColumn({name: 'guide_id'})
    guide: Guide

    @ManyToOne(() => Tour, (tour) => tour.id)
    @JoinColumn({name: 'tour_id'})
    tour: Tour

    @Column()
    tour_name: string

    @Column({type: 'date'})
    start_date: string

    @Column({type: 'date'})
    end_date: string

    @Column({type: "double"})
    price: number

    @Column()
    headcount: number

    @Column({type: "longtext"})
    plan: string

    @Column({type: "datetime"})
    appointment_date: string

    @Column({type: "varchar"})
    appointment_place: string

    @CreateDateColumn({type: "timestamp"})
    created_at: string

    @OneToOne(() => Rate, (rate) => rate.history_id)
    rate: number
}