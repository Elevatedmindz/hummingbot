# Use the Docker Compose base image
FROM docker/compose:latest

# Set working directory
WORKDIR /app

# Install bash (not included in the base image)
RUN apk add --no-cache bash

# Copy all files into the container
COPY . .

# Run the setup script
CMD ["bash", "setup.sh"]
