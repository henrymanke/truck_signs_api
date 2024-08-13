# Use an official Python image as the base image
FROM python:3.9-slim

# Install build tools and libraries for compiling C extensions
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    libpq-dev \
    netcat-openbsd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Add the Python dependencies and install them
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application to the working directory
COPY . /app

# Expose the port used by the application
EXPOSE 8020

# Move the entrypoint script to /usr/local/bin/
RUN mv /app/entrypoint.sh /usr/local/bin/ && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]


