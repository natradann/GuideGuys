import { Column, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Tour } from "./tour";
import { User } from "./user";
import { History } from "./history";

@Entity({ name: "rate"})
export class Rate {
    @PrimaryGeneratedColumn()
    id: number

    @ManyToOne(() => User, (user) => user.rate)
    @JoinColumn({name: 'customer_id'})
    user_id: number
    
    @ManyToOne(() => Tour, (tour) => tour.rate)
    @JoinColumn({name: 'tour_id'})
    tour_id: number
    
    @OneToOne(() => History, (history) => history.rate)
    @JoinColumn({name: 'history_id'})
    history_id: number

    @Column({type: "double"})
    point: number

    @Column({type: "text"})
    comment: string

    @Column({type: "timestamp"})
    comment_date: string
}