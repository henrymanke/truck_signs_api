# Truck Signs App

## Table of Contents
1. [Description](#description)
2. [Quickstart](#quickstart)
3. [How to Build the Image](#how-to-build-the-image)
4. [Usage](#usage)

## Description

The **Truck Signs Api** repository contains the codebase and configurations for a web application designed to manage and display truck sign information. The primary purpose of this repository is to provide an interface for users to interact with truck sign data and manage associated information. It includes a Django-based backend, a PostgreSQL database, and Docker configurations for easy deployment.

## Quickstart

### Prerequisites

- Docker and Docker Compose installed on your machine
- An environment file (`.env`) with necessary configurations

### Quickstart Guide

1. **Build the Docker Image**:
   ```bash
   docker build -t truck-signs-app .
   ```

2. **Create a Docker Network**:
   ```bash
   docker network create truck-signs-net
   ```

3. **Start PostgreSQL Container**:
   ```bash
   docker run -d --name truck-signs-db --network truck-signs-net \
       --env-file ./truck_signs_designs/settings/.env \
       -v db_data:/var/lib/postgresql/data \
       -p 5432:5432 postgres:13
   ```

4. **Start the Web Application Container**:
   ```bash
   docker run -d --name truck-signs-web --network truck-signs-net \
       --env-file ./truck_signs_designs/settings/.env \
       -p 8020:8000 truck-signs-app
   ```

5. **Access Interactive Console**:
   ```bash
   docker exec -it truck-signs-web /bin/bash
   python3 manage.py createsuperuser
   ```

## How to Build the Image

To build the Docker image for the Truck Signs App, follow these steps:

1. **Clone the repository** and navigate to the project directory:
   ```bash
   git clone <repository_url>
   cd truck-signs-app
   ```

2. **Build the Docker image**:
   ```bash
   docker build -t truck-signs-app .
   ```

## Usage

### Configuration

The application requires a `.env` file with the following configurations:

- **Django**:
  ```plaintext
  SECRET_KEY='your-secret-key'
  ALLOWED_HOSTS=your_ip
  ```

- **Superuser Credentials**:
  ```plaintext
  DJANGO_SUPERUSER_USERNAME=your_username
  DJANGO_SUPERUSER_EMAIL=your_email
  # Working for Django < 3.0
  DJANGO_SUPERUSER_PASSWORD=your_password
  ```

- **Database Configuration**:
  ```plaintext
  POSTGRES_DB=trucksigns
  POSTGRES_USER=user
  POSTGRES_PASSWORD=your_db_password
  POSTGRES_HOST=truck-signs-db
  POSTGRES_PORT=5432
  ```

- **Stripe API Keys**:
  ```plaintext
  STRIPE_PUBLISHABLE_KEY=your_publishable_key
  STRIPE_SECRET_KEY=your_secret_key
  ```

- **Email Configuration**:
  ```plaintext
  EMAIL_HOST_USER=your_email_user
  EMAIL_HOST_PASSWORD=your_email_password
  ```

### Running the Application

To run the application, follow the Quickstart guide above. You can also customize the environment variables in the `.env` file to modify the application behavior, such as changing database credentials or API keys. 

For detailed information on configurations and customizations, refer to the [Django documentation](https://docs.djangoproject.com/).

### Docker Commands

- **Building the Docker Image**:
  ```bash
  docker build -t truck-signs-app .
  ```

- **Running the Docker Container**:
  ```bash
  docker run -d --name truck-signs-web --network truck-signs-net \
      --env-file ./truck_signs_designs/settings/.env \
      -p 8020:8000 truck-signs-app
  ```

  Replace the placeholder values in the `.env` file with your actual configurations.

---

For any further questions or issues, please refer to the [issue tracker](https://github.com/henrymanke/truck_signs_api/issues) or contact the repository maintainers.