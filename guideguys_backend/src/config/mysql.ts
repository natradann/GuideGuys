import "reflect-metadata";
import {createConnection} from "typeorm";
import { User } from "../entity/user";




// import mysql from 'mysql';
// import config from './config';

// const params = {
//     user: config.mysql.user,
//     password: config.mysql.pass,
//     host: config.mysql.host,
//     database: config.mysql.database,
//     port: config.mysql.port
// }

// const Connect = async () => new Promise<mysql.Connection>((resolve, reject) => {
//     const connection = mysql.createConnection(params);
    
//     connection.connect((error) => {
//         if(error) {
//             console.log('connection');
//             reject(error);
//             return;
//         }
//         resolve(connection);
//     });
// });

// const Query = async <T>(connection: mysql.Connection, query: string) => 
//     new Promise((resolve, reject) => {
//         connection.query(query, connection, (error, result) => {
//             if(error) {
//                 reject(error);
//                 return;
//             }

//             resolve(result);

//             connection.end();
//         });
//     });

// export { Connect, Query };

