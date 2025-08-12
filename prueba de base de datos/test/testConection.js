import { pool } from "../server/conection.js";

// se encarga de verificar la conexion a nuestra base de datos
export const loadConection = async function(){
    try{
        const conecction = await pool.getConnection();
        console.log("Conexion exitosa");
        conecction.release();
    }catch (error) {
        console.error("Error al conectar con la base de datos: ", error.message);
    };
};

loadConection();