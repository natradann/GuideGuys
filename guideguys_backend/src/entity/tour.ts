import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Guide } from "./guide";
import { Rate } from "./rate";
import { History } from "./history";

@Entity({ name: "tour"})
export class Tour {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    name: string

    @ManyToOne(() => Guide, (guide) => guide.tour)
    @JoinColumn({name: "guide_id"})
    guide: Guide

    @Column({type: "longblob", nullable: true})
    img: Buffer

    @Column({type: "json", nullable: false})
    convinces: string[]

    @Column({type: "json", nullable: false})
    vehicle: string[]

    @Column({type: "json", nullable: false})
    type: string[]

    @Column({type: "longtext"})
    detail: string

    @Column({type: "double", nullable: false})
    price: number

    @Column({type: "double"})
    point: number

    @CreateDateColumn({type: "timestamp"})
    created_at: string 
    
    @OneToMany(() => Rate, (rate) => rate.tour_id)
    rate: Rate[]

    @OneToMany(() => History, (history) => history.tour)
    history: History[]
}