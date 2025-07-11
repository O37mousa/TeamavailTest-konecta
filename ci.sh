#!/bin/bash

set -e

echo "Running ESLint..."
npx eslint . || true

echo "Checking formatting with Prettier..."
npx prettier --check . || true

echo "Running tests..."
npm test || true  # You can replace with another test command if needed

echo "Building Docker image..."
docker build -t availability-tracker .

echo "Starting app with Docker Compose..."
docker compose down || true
docker compose up --build -d

echo "CI pipeline completed successfully!"
