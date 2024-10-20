# Redis Caching with Docker and Node.js

This project utilizes Redis for caching and provides a simple Node.js application to interact with the Redis database. To get started, follow the steps below.

## Installation and Setup

1. **Install Node.js dependencies**:
   Run the following command in your terminal to install the required Node.js packages:
   ```
   npm install
   ```
2. **Start the Node.js application**:
   Once the dependencies are installed, start the Node.js application using:
   ```
   npm run start
   ```
   This will start the application on port 3000. You can access it at `http://localhost:3000`.

3. **Run Redis with Docker**:
   To run Redis with Docker, execute the following command:
   ```
   docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
   ```
   This command starts a Redis instance with the Redis Stack, which includes a visualizer for the Redis database. You can access the visualizer at `http://localhost:8001`.

With these steps, you should now have a Node.js application running with Redis caching enabled. The application calculates a value and caches it in Redis for subsequent requests.
