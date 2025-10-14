# Use the official n8n Docker image
FROM n8nio/n8n:latest

# Set default environment variables for Fly.io
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV GENERIC_TIMEZONE=America/Santo_Domingo

# Expose the port Fly.io expects
EXPOSE 5678

# Start n8n automatically
CMD ["n8n", "start"]
