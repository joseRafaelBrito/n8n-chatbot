# n8n Chatbot Docker Setup

This repository contains a Docker setup for running n8n (workflow automation tool) locally and deploying to Render.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git (for cloning and version control)
- Render account (for cloud deployment)

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

## Deployment to Render

### Prerequisites for Render Deployment

1. **Push to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit for n8n Docker chatbot"
   git branch -M main
   git remote add origin https://github.com/joseRafaelBrito/n8n-chatbot.git
   git push -u origin main
   ```

2. **Create Render Account:**
   - Sign up at [render.com](https://render.com)
   - Connect your GitHub account

### Deploy to Render

1. **Create a New Web Service:**
   - Go to your Render dashboard
   - Click "New +" → "Web Service"
   - Connect your GitHub repository: `joseRafaelBrito/n8n-chatbot`

2. **Configure the Service:**
   - **Name:** `n8n-chatbot` (or your preferred name)
   - **Environment:** `Docker`
   - **Region:** Choose closest to your users
   - **Branch:** `main`
   - **Root Directory:** Leave empty (uses root)
   - **Dockerfile Path:** Leave empty (uses root Dockerfile)

3. **Set Environment Variables:**
   Add the following environment variables in Render dashboard:
   ```
   N8N_BASIC_AUTH_ACTIVE=true
   N8N_BASIC_AUTH_USER=admin
   N8N_BASIC_AUTH_PASSWORD=your_secure_password
   N8N_ENCRYPTION_KEY=your_encryption_key_here
   WEBHOOK_URL=https://your-app-name.onrender.com
   N8N_HOST=0.0.0.0
   N8N_PORT=5678
   GENERIC_TIMEZONE=America/Santo_Domingo
   ```

4. **Deploy:**
   - Click "Create Web Service"
   - Render will automatically build and deploy your application
   - Wait for deployment to complete (usually 5-10 minutes)

5. **Access Your Deployed App:**
   - Once deployed, you'll get a public URL like: `https://your-app-name.onrender.com`
   - Access n8n at this URL
   - Login with your configured credentials

### Important Notes for Render Deployment

- **Free Tier Limitations:** Render's free tier has limitations (sleeps after inactivity, limited build time)
- **Data Persistence:** Consider upgrading to a paid plan for persistent data storage
- **Webhook URLs:** Update any webhook URLs to use your Render domain
- **Environment Variables:** Never commit sensitive data to Git; use Render's environment variables

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

### Render Issues
- Check build logs in Render dashboard
- Verify all environment variables are set
- Ensure Dockerfile is in the root directory
- Check if the service is sleeping (free tier limitation)