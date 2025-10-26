# n8n Chatbot Docker Setup

This repository contains a Docker setup for running n8n (workflow automation tool) locally and deploying to Fly.io.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git (for cloning and version control)
- Fly.io account and CLI (for cloud deployment)

## Local Development

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/joseRafaelBrito/n8n-chatbot.git
   cd n8n-chatbot
   ```

2. **Create environment file:**
   Copy the example environment file and customize it:
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` with your preferred settings:
   ```
   N8N_BASIC_AUTH_ACTIVE=true
   N8N_BASIC_AUTH_USER=admin
   N8N_BASIC_AUTH_PASSWORD=your_secure_password
   N8N_ENCRYPTION_KEY=your_encryption_key_here
   WEBHOOK_URL=http://localhost:5678
   ```
   
   **Important:** Change the default password and encryption key before running in production!

3. **Start the service:**
   ```bash
   docker-compose up -d
   ```

4. **Access n8n:**
   Open your browser and navigate to `http://localhost:5678`
   
   Login with the credentials from your `.env` file

### Configuration

- **Port:** n8n runs on port 5678
- **Data persistence:** All n8n data is stored in the `./n8n_data` directory
- **Authentication:** Basic auth is enabled by default
- **Timezone:** Set to America/Santo_Domingo

### Stopping the Service

```bash
docker-compose down
```

## Deployment to Fly.io

### Prerequisites for Fly.io Deployment

1. **Push to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit for n8n Docker chatbot"
   git branch -M main
   git remote add origin https://github.com/joseRafaelBrito/n8n-chatbot.git
   git push -u origin main
   ```

2. **Install Fly CLI:**
   ```bash
   # macOS
   brew install flyctl
   
   # Linux/Windows
   curl -L https://fly.io/install.sh | sh
   ```

3. **Create Fly.io Account:**
   - Sign up at [fly.io](https://fly.io)
   - Login via CLI: `fly auth login`

### Deploy to Fly.io

1. **Create a Fly App:**
   ```bash
   fly launch --no-deploy
   ```
   - Choose your app name (e.g., `n8n-chatbot`)
   - Select region closest to your users
   - Choose "Yes" for Dockerfile detection

2. **Configure Environment Variables:**
   ```bash
   fly secrets set N8N_BASIC_AUTH_ACTIVE=true
   fly secrets set N8N_BASIC_AUTH_USER=admin
   fly secrets set N8N_BASIC_AUTH_PASSWORD=your_secure_password
   fly secrets set N8N_ENCRYPTION_KEY=your_encryption_key_here
   fly secrets set WEBHOOK_URL=https://your-app-name.fly.dev
   ```

3. **Deploy the App:**
   ```bash
   fly deploy
   ```

4. **Open Your App:**
   ```bash
   fly open
   ```
   - This will open your n8n instance in the browser
   - Login with your configured credentials

### Fly.io Configuration

The `fly.toml` file will be automatically generated with the following configuration:
```toml
app = "your-app-name"
primary_region = "your-region"

[build]

[http_service]
  internal_port = 5678
  force_https = true
  auto_stop_machines = true
  auto_start_machines = true
  min_machines_running = 0
  processes = ["app"]

[[vm]]
  memory = "1gb"
  cpu_kind = "shared"
  cpus = 1
```

### Important Notes for Fly.io Deployment

- **Free Tier:** Fly.io offers generous free tier with 3 shared-cpu-1x 256mb VMs
- **Data Persistence:** Use Fly Volumes for persistent data storage
- **Webhook URLs:** Update any webhook URLs to use your Fly.io domain
- **Environment Variables:** Use `fly secrets` for sensitive data
- **Scaling:** Apps can scale to zero when not in use (free tier benefit)

## Data Backup

Your n8n workflows and data are stored in the `./n8n_data` directory locally. For cloud deployment, consider:
- Regular exports of your workflows
- Database backups if using external databases
- Environment variable backups

## Security Notes

- Always change the default password in production
- Use a strong encryption key for `N8N_ENCRYPTION_KEY`
- The `.env` file is gitignored for security reasons
- Use HTTPS in production (Render provides this automatically)
- Regularly update your n8n Docker image for security patches

## Troubleshooting

### Local Issues
- Ensure Docker is running
- Check if port 5678 is available
- Verify `.env` file exists and has correct values

### Fly.io Issues
- Check deployment logs: `fly logs`
- Verify all secrets are set: `fly secrets list`
- Ensure Dockerfile is in the root directory
- Check app status: `fly status`
- View app info: `fly info`