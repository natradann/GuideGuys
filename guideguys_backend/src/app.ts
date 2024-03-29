import express, {Application} from 'express';
import morgan from 'morgan';
import { AppDataSource } from './config/data-source';
import logging from './config/logging';
import UserRoutes from './routes/user.route';
import GuideRoutes from './routes/guide.route';
import TourRoutes from './routes/tour.route';
import RateRoutes from './routes/rate.route';
import HistoryRoutes from './routes/history.route';
import ChatRoutes from './routes/chat.route';
import MessageRoutes from './routes/message.route';
import PaymentRoutes from './routes/payment.route';
import {ServerToClientEvents, ClientToServerEvents, InterServerEvents, SocketData} from './interfaces/message';
import { Server, Socket } from 'socket.io';
import http from 'http';
import cors from 'cors';
const bodyParser = require('body-parser');
import multer from 'multer';

// const io = new Server<
// ClientToServerEvents,
// ServerToClientEvents,
// InterServerEvents,
// SocketData
// >();

// io.on('connection', (socket) => {
//     const username = socket.handshake.query.username
//     socket.on("message", (data) => {
//         const message = {
//         message: data.message,
//         senderUsername: username,
//         sentAt: Date.now()
//         }
//         messages.push(message)
//         io.emit('message', message)

//     })
// });

const upload = multer();

export class App{
    private app : Application;
    private server: http.Server;
    private io: Server;
    private cors = require('cors');
    private upload = multer(); 
    
    constructor(private port ?: number | string) {
        const upload = multer();
        this.app = express();
        this.app.use(express.json());
        this.app.use(cors());
        

        this.app.use(upload.any());
        this.app.use(bodyParser.json({ limit: '10mb' }));
        this.app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));


        // this.app.use((req, res, next) => {
        //     // Log details about the incoming request
        //     console.log(req.body);
        //     console.log(`Received request with payload size: ${Buffer.from(JSON.stringify(req.body)).length} bytes`);
        //     next();
        //   });
        
        this.server = http.createServer(this.app);
        
        this.io = new Server(this.server);
        this.setupSocket();
        this.settings();
        this.middlewears();
        this.routes();
    }

    setupSocket() {
        console.log('test socket');
        this.io.on('connection', (socket: Socket) => {
            console.log('connect successful');
            socket.on('joinRoom', (data) => {
                socket.join(data.room)
                console.log(`User joined room: ${data.room}`);
            })

            socket.on('message', (data) => {
                const message = {
                    "sender_username": data.sender_username,
                    "message_text": data.message_text,
                    "comment_date": data.comment_date,
                }
                console.log(message)
                this.io.to(data.chatRoom).emit('newMessage', message);
            });
            
            socket.on('disconnect', () => {
                socket.disconnect();
                console.log("disconnect to socket");
            })
        });
    }
    
    
    async initialize() {
        try {
            await AppDataSource.initialize();
            console.log('Connected to the database successfully.');
        } catch (error) {
            logging.error('Database connection error:', error.message, error);
            throw error;
        }
    }

    settings() {
        this.app.set('port', this.port || process.env.PORT || 3000)
        
    }

    middlewears() {
        this.app.use(morgan('dev'))
    }
    
    routes() {
        this.app.use('/users', UserRoutes);
        this.app.use('/guides', GuideRoutes);
        this.app.use('/tours', TourRoutes);
        this.app.use('/rates', RateRoutes);
        this.app.use('/history', HistoryRoutes);
        this.app.use('/chats', ChatRoutes);
        this.app.use('/messages', MessageRoutes);
        this.app.use('/payments', PaymentRoutes);
    }

    async start() {
        await this.initialize();

        // this.app.listen(this.app.get('port'), () => {
        //     console.log(`Server is running on port ${this.app.get('port')}`);
        // });

        // this.server.listen(3001, () => {
        //     console.log('Server is listening on port 3001');
        //   });

        this.server.listen(this.app.get('port'), () => {
            console.log(`Server is running on port ${this.app.get('port')}`);
        });
    }
    
}