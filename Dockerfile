# Use a lightweight Python image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install EMQX broker
RUN curl -s https://repos.emqx.io/install_emqx.sh | bash

# Set working directory
WORKDIR /app

# Copy project files into the container
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt || true

# Expose required ports
EXPOSE 8501 8000 1883 8083 18083

# Start all services when the container starts
CMD bash -c "
  # Start EMQX broker in the background
  emqx start && \
  # Wait for EMQX to initialize
  sleep 5 && \
  # Start the backend API in the background
  python3 backend-api/main.py & \
  # Start the dashboard service
  streamlit run dashboard/app.py
"
