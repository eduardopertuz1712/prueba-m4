/* Loads clients into the database */
import fs from 'fs'; // Allows reading files
import path from 'path'; // Shows the current path
import csv from 'csv-parser';
import { pool } from "../connection_db.js"; 

export async function loadClientsToDatabase(){
    const filePath = path.resolve('server/data/01_clients.csv');
    const clients = [];
    return new Promise((resolve, reject) => {
        fs.createReadStream(filePath)
            .pipe(csv())
            .on("data", (row) => {
                clients.push([
                    row.numero_identificacion,
                    row.nombre_cliente,
                    row.direccion,
                    row.telefono,
                    row.email
                ]);
            })
            .on('end', async () => {
                try {
                    const sql = 'INSERT INTO clientes (numero_identificacion, nombre_cliente, direccion, telefono, email) VALUES ?';
                    const [result] = await pool.query(sql, [clients]);

                    console.log(`✅Inserted ${result.affectedRows} to clientes.`);
                    resolve(); // Resolve the promise after insertion
                } catch (error) {
                    console.error('❌Error inserting clients:', error.message);
                    reject(error);
                }
            })
            .on('error', (err) => {
                console.error('❌Error reading clients CSV file:', err.message);
                reject(err);
            });
    });
}