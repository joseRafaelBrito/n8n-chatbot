# Use the official n8n image
FROM n8nio/n8n:latest

# Set default environment variables for Render
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV GENERIC_TIMEZONE=America/Santo_Domingo

# Expose port 5678
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
