# Use node:lts-alpine as the base image for building the Docker image
FROM node:lts-alpine AS build-stage

# Install kubectl
RUN apk add --no-cache curl && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Create a working directory
WORKDIR /react-app

# Copy the application dependencies
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --verbose

# Copy the remaining application files
COPY . .

# Expose the application container on port 3000
EXPOSE 3000

# Command to start the application
CMD ["npm", "start"]
