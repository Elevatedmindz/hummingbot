# Use an official Docker Compose image
FROM docker/compose:latest

# Copy all files into the container
WORKDIR /app
COPY . .

# Run docker-compose.yml
CMD ["docker-compose", "up"]
