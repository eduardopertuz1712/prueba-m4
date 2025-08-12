# Sistema BestoZoo

## Introduccion
Bienvenido a "Sistema BestoZoo", este proyecto se encarga de hacer la conexion a una base de datos relacional mediante el uso de javascript, a su vez, se encarga de recibir valores por parte de la pagina y reflejarlos en la base de datos, como actualizacion, eliminacion o creacion de informacion.

## Tecnologias Usadas

- HTML
- CSS
- JavaScript
- MySQL

## Estructura del Proyecto
```
bestozoo/
├── .gitignore
├── librerias.txt
├── package.json
├── README.md
│
├── docs/
│   ├── 01-cuidadores.xlsx
│   ├── 02-habitats.xlsx
│   ├── 03-animales.xlsx
│   ├── 04-veterinarios.xlsx
│   ├── 05-revisiones.xlsx
│   ├── zoologico_no_normalizado.xlsx
│   │   
│   ├── db/
│   │   └── base.sql
│   │
│   └── postman/
│       └── BestoZoo🦁.postman_collection.json
│
├── server/
│   │   conection.js
│   │   index.js
│   │
│   ├── data/
│   │   ├── 01-cuidadores.csv
│   │   ├── 02-habitats.csv
│   │   ├── 03-animales.csv
│   │   ├── 04-veterinarios.csv
│   │   └── 05-revisiones.csv
│   │
│   └── seeders/
│       ├── load_animals.js
│       ├── load_cuidadores.js
│       ├── load_habitats.js
│       ├── load_revisiones.js
│       ├── load_veterinarios.js
│       └── run_seeders.js
│
└── test/
    └── testConection.js
```

## Estructura de la Base de Datos basado en entidades

### Cuidadores
- ID
- Nombre
- Apellido
- Telefono
- Correo

### Habitats
- Nombre
- Zona

### Animales
- ID
- ID Habitat (FK)
- ID Cuidador Asignado (FK)
- Nombre
- Especie
- Sexo
- Dieta (Carnívoro, Herbívoro, Omnívoro)
- Fecha de nacimiento
- Fecha de ingreso

### Veterinarios
- ID
- Nombre
- Apellido
- Telefono
- Correo

### Revisiones Medicas
- ID del animal (FK)
- ID del veterinario (FK)
- Diagnostico
- Tratamiento
- Fecha de Revision

## Instrucciones para ejecutar el proyecto

1. **Clona este repositorio en un directorio**
```bash
git clone urlDelRepositorio
cd bestozoo
```

2. **Instala las dependencias**
```bash
npm install
```
3. **Crea y define un archivo .env**
```conf
DB_HOST=localhost
DB_USER=tu_usuario
DB_PASSWORD=contraseña
DB_NAME=nombre_de_la_BDD
DB_PORT=puerto
```
4. **Inicializa el Backend**
```bash
node .\server\index.js 
```
o
```bash
node server/index.js 
```

**Recuerda haber creado la Base de Datos antes**