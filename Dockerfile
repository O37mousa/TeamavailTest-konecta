# # Use slim base image
# FROM python:3.11-slim

# # Set working directory
# WORKDIR /app

# # Copy the full project
# COPY . .

# # Set default command
# CMD ["python", "app.py"]


# FROM node:18-alpine

# WORKDIR /app

# COPY package*.json ./
# RUN npm install

# COPY . .

# CMD ["node", "server.js"]


# Use Node.js LTS version
# FROM node:18-alpine
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files first to install deps
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the code
COPY . .

# Expose the app port (adjust if different)
EXPOSE 3000

# Start the app
CMD ["node", "server.cjs"]
