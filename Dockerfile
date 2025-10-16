# Use the official n8n Docker image
FROM n8nio/n8n:latest

# Switch to the root user to ensure permissions
USER root

# Set working directory
WORKDIR /home/node

# Set environment variables
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV GENERIC_TIMEZONE=America/Santo_Domingo

# Expose n8n port
EXPOSE 5678

# Start n8n explicitly via npm (guaranteed to work on Render)
CMD ["npm", "run", "start"]
