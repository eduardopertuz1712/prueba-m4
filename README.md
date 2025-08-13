### Helo, my name is Eduardo Pertuz I from Macondo clan

## System description
Welcome to "Payment System." This project is responsible for connecting to a relational database using Postman and JavaScript, and reflecting it in the database. This allows us to update, delete, and create information.

## Instructions for run the project ⚙️
1. **Install the dependencies**
```bash
npm install
```
2. **Create the database from base.sql**
```sql
CREATE DATABASE sistema_pagos;
-- Rest of the code in base.sql
```
3. **Create and config the .env file**
```conf
DB_HOST=Your_Host
DB_USER=Your_user
DB_PASSWORD=Password
DB_NAME=database_name
DB_PORT=port
```

4. **Load information from the csv files**
```bash
node server/seeders/run_seeders.js
```

5. **Run the backend**
```bash
node server/index.js
```

## ⚒️ technologies used
- postman
- sql
- javascript