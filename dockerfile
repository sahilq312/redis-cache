# Use the official Node.js 18 image as the base image
FROM node:18

# Set the working directory in the container to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package.json .

# Install the dependencies
RUN npm install

# Copy the current directory contents to the container at /app
COPY . .

# Run the start command
CMD ["npm", "run", "start"]

# Make the container's port 3000 available to the outside world
EXPOSE 3000

# Run the container
# docker run -p 3000:3000 <container_id>
