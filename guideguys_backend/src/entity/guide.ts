import { Column, CreateDateColumn, Entity, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./user";
import { Tour } from "./tour";
import { History } from "./history";

@Entity({ name: "guide"})
export class Guide {
    @PrimaryGeneratedColumn("uuid")
    id: string

    @Column({nullable: false, unique:true})
    card_no: string

    @Column({nullable: true})
    type: string

    @Column({type: "longblob", nullable: true})
    card_img: Buffer

    @Column({type: "datetime"})
    card_expired: string

    @Column({type: "json", nullable: true})
    convinces: string[]

    @Column({type: "json", nullable: false})
    languages: string[]

    @Column({type: "text"})
    experience: string

    @Column({type: "double"})
    point: number

    @CreateDateColumn({type: "timestamp"})
    created_at: string

    @OneToOne(() => User, (user) => user.guide)
    user: User

    @OneToMany(() => Tour, (tour) => tour.guide)
    tour: Tour[]

    @OneToMany(() => History, (history) => history.guide)
    history: History[]
}