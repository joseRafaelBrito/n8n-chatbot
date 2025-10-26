# Use the official n8n Docker image
FROM n8nio/n8n:latest

# Set environment variables
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV GENERIC_TIMEZONE=America/Santo_Domingo
ENV N8N_ENCRYPTION_KEY=G7k8!r9Xq#2LpTz6u4MvH0bF1S9WcYdQ
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Expose the n8n port
EXPOSE 5678

# Start n8n directly
ENTRYPOINT ["n8n"]
CMD ["start"]
