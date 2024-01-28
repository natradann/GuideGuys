import { Column, CreateDateColumn, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { History } from "./history";

@Entity({name: 'payment'})
export class Payment {
    @PrimaryGeneratedColumn()
    id: number

    @Column({type: "longblob", nullable: true})
    slip: Buffer

    @CreateDateColumn({type: "timestamp"})
    created_at: string

    @OneToOne(() => History)
    @JoinColumn({name: "history_id"})
    history: History
}
