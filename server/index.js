import express from "express";
import { pool } from "./connection_db.js";

const app = express();
app.use(express.json()); // Automatically parses JSON bodies for POST and PUT requests

// CRUD for clients
app.get('/clientes', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT 
                numero_identificacion,
                nombre_cliente,
                direccion,
                telefono,
                email
            FROM clientes
        `);
        res.json(rows);
    } catch (error) {
        res.status(500).json({
            status: 'error',
            endpoint: req.originalUrl,
            method: req.method,
            message: error.message
        });
    }
});

app.get('/clientes/:numero_identificacion', async (req, res) => {
    try {
        const { numero_identificacion } = req.params;
        const [rows] = await pool.query(`
            SELECT 
                numero_identificacion,
                nombre_cliente,
                direccion,
                telefono,
                email
            FROM clientes
            WHERE numero_identificacion = ?
        `, [numero_identificacion]);
        res.json(rows[0]);
    } catch (error) {
        res.status(500).json({
            status: 'error',
            endpoint: req.originalUrl,
            method: req.method,
            message: error.message
        });
    }
});

app.post('/clientes', async (req, res) => {
    try {
        const {
            numero_identificacion,
            nombre_cliente,
            direccion,
            telefono,
            email
        } = req.body;
        const query = `
            INSERT INTO clientes 
            (numero_identificacion, nombre_cliente, direccion, telefono, email)
            VALUES (?, ?, ?, ?, ?)
        `;
        const values = [
            numero_identificacion,
            nombre_cliente,
            direccion,
            telefono,
            email
        ];
        await pool.query(query, values);
        res.status(201).json({
            message: "Client created successfully"
        });
    } catch (error) {
        res.status(500).json({
            status: 'error',
            endpoint: req.originalUrl,
            method: req.method,
            message: error.message
        });
    }
});

app.put('/clientes/:numero_identificacion', async (req, res) => {
    try {
        const { numero_identificacion } = req.params;
        const {
            nombre_cliente,
            direccion,
            telefono,
            email
        } = req.body;
        const query = `
            UPDATE clientes SET 
                nombre_cliente = ?,
                direccion = ?,
                telefono = ?,
                email = ?
            WHERE numero_identificacion = ?
        `;
        const values = [
            nombre_cliente,
            direccion,
            telefono,
            email,
            numero_identificacion
        ];
        const [result] = await pool.query(query, values);
        if (result.affectedRows != 0) {
            return res.json({ message: "Client updated" });
        }
    } catch (error) {
        res.status(500).json({
            status: 'error',
            endpoint: req.originalUrl,
            method: req.method,
            message: error.message
        });
    }
});

app.delete('/clientes/:numero_identificacion', async (req, res) => {
    try {
        const { numero_identificacion } = req.params;
        const query = `
            DELETE FROM clientes WHERE numero_identificacion = ?
        `;
        const values = [numero_identificacion];
        const [result] = await pool.query(query, values);
        if (result.affectedRows != 0) {
            return res.json({ message: "Client deleted" });
        }
    } catch (error) {
        res.status(500).json({
            status: 'error',
            endpoint: req.originalUrl,
            method: req.method,
            message: error.message
        });
    }
});

// Start server
app.listen(3000, () => {
    console.log("Server running at http://localhost:3000");
});