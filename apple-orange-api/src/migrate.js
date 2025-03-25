// src/migrate.js
const { Client } = require('pg');
const { default: migrate } = require('node-pg-migrate');
require('dotenv').config();

const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

const createDatabaseIfNotExists = async () => {
    const { DATABASE_URL } = process.env;
    const dbUrl = new URL(DATABASE_URL);
    const databaseName = dbUrl.pathname.replace('/', '');

    const defaultDbUrl = new URL(DATABASE_URL);
    defaultDbUrl.pathname = '/postgres';

    for (let retries = 5; retries > 0; retries--) {
        const client = new Client({ connectionString: defaultDbUrl.toString() });
        try {
            await client.connect();
            const res = await client.query(`SELECT 1 FROM pg_database WHERE datname='${databaseName}'`);
            if (res.rowCount === 0) {
                console.log(`🛠️ Database '${databaseName}' not found, creating...`);
                await client.query(`CREATE DATABASE "${databaseName}"`);
                console.log(`✅ Database '${databaseName}' created.`);
            } else {
                console.log(`✅ Database '${databaseName}' already exists.`);
            }
            await client.end();
            return;
        } catch (err) {
            console.warn(`⏳ Waiting for PostgreSQL... Retries left: ${retries - 1}`, err.message);
            await client.end().catch(() => { }); // Ensure client disconnect
            await delay(5000);
        }
    }

    console.error('❌ Could not connect to PostgreSQL after multiple attempts.');
    process.exit(1);
};

const runMigrations = async () => {
    await createDatabaseIfNotExists();
    try {
        await migrate({
            databaseUrl: process.env.DATABASE_URL,
            dir: 'migrations',
            direction: 'up',
            migrationsTable: 'pgmigrations',
            log: () => { },
        });
        console.log('✅ Database migrations completed.');
    } catch (error) {
        console.error('❌ Migration failed:', error);
        process.exit(1);
    }
};

module.exports = runMigrations;
