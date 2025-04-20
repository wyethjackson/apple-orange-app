// src/cache.js
const redis = require('redis');

// Create a Redis client instance.
// The URL can be configured via the REDIS_URL environment variable.
const client = redis.createClient({
    url: process.env.REDIS_URL || 'redis://localhost:6379'
});

// Connect to Redis.
client.connect().catch(err => {
    console.error("Redis connection error:", err);
});

// Optionally, export some helper functions.
async function getCache(key) {
    try {
        const data = await client.get(key);
        return data ? JSON.parse(data) : null;
    } catch (err) {
        console.error("Error getting cache key:", key, err);
        return null;
    }
}

async function setCache(key, value, ttlInSeconds = 60) {
    try {
        await client.set(key, JSON.stringify(value), { EX: ttlInSeconds });
    } catch (err) {
        console.error("Error setting cache key:", key, err);
    }
}

module.exports = {
    client,
    getCache,
    setCache,
};
