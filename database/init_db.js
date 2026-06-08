const { Pool } = require("pg");
const fs = require("fs");
const path = require("path");
require("dotenv").config();

// Database connection
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

// Read SQL file safely
const readSQL = (filePath) => {
    return fs.readFileSync(path.join(__dirname, filePath)).toString();
};

// Execute SQL
const runSQL = async (filePath) => {
    const sql = readSQL(filePath);
    await pool.query(sql);
};

const initDB = async () => {
    try {
        console.log("🟡 Initializing database...");

        console.log("📦 Running schema...");
        await runSQL("schema.sql");

        console.log("🌱 Inserting seed data...");
        await runSQL("seed.sql");

        console.log("🟢 Database setup complete!");

    } catch (err) {
        console.error("🔴 DB Initialization failed:");
        console.error(err.message);
    } finally {
        await pool.end();
    }
};

initDB();