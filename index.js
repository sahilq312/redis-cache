import express from 'express';
import dotenv from 'dotenv';
import { createClient } from 'redis';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

const client = createClient({
    url: 'redis://localhost:6379',
    retry_strategy: function (options) {
        if (options.error && options.error.code === 'ECONNREFUSED') {
            // End reconnecting on a specific error and flush all commands with a individual error
            return new Error('The server refused the connection');
        }
        if (options.total_retry_time > 1000 * 60 * 60) {
            // End reconnecting after a specific timeout and flush all commands with a individual error
            return new Error('Retry time exhausted');
        }
        if (options.attempt > 10) {
            // End reconnecting with built in error
            return undefined;
        }
        // reconnect after
        return Math.min(options.attempt * 100, 3000);
    }
});

client.on('error', (err) => {
    console.log('Redis Client Error', err);
});

client.connect();

app.get('/', async (req, res) => {
    const cachedValue = await client.get('cachedElement');
    if (cachedValue) {
        res.json(cachedValue);
    } else {
        const n = 10003800300;
        let element = 0;
        for (let i = 0; i < n; i++) {
            element += i;
        }
        await client.set('cachedElement', element);
        res.json(element);
    }
});


app.listen(PORT, () => {
    console.log(`Server is running on port: http://localhost:${PORT}`);
});