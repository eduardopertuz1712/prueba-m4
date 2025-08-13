import { pool } from "../server/connection_db.js";

// is responsible for verifying the connection to our database
export const loadConection = async function(){
    try{
        const conecction = await pool.getConnection();
        console.log("Conexion exitosa ✅");
        conecction.release();
    }catch (error) {
        console.error("Error connecting to the database: ", error.message);
    };
};

loadConection();