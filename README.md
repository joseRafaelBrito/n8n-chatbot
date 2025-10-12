# n8n Chatbot Docker Setup

This repository contains a Docker setup for running n8n (workflow automation tool) locally.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git (for cloning and version control)

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/joseRafaelBrito/n8n-chatbot.git
   cd n8n-chatbot
   ```

2. **Create environment file:**
   Create a `.env` file in the root directory with the following content:
   ```
   N8N_BASIC_AUTH_ACTIVE=true
   N8N_BASIC_AUTH_USER=admin
   N8N_BASIC_AUTH_PASSWORD=changeme
   N8N_ENCRYPTION_KEY=replace_with_a_secret_key
   ```
   
   **Important:** Change the default password and encryption key before running in production!

3. **Start the service:**
   ```bash
   docker-compose up -d
   ```

4. **Access n8n:**
   Open your browser and navigate to `http://localhost:5678`
   
   Login with the credentials from your `.env` file (default: admin/changeme)

## Configuration

- **Port:** n8n runs on port 5678
- **Data persistence:** All n8n data is stored in the `./n8n_data` directory
- **Authentication:** Basic auth is enabled by default

## Stopping the Service

```bash
docker-compose down
```

## Data Backup

Your n8n workflows and data are stored in the `./n8n_data` directory. Make sure to backup this directory regularly.

## Security Notes

- Always change the default password in production
- Use a strong encryption key for `N8N_ENCRYPTION_KEY`
- The `.env` file is gitignored for security reasons