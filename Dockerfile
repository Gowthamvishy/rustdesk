FROM debian:bullseye-slim

# Install required tools
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Download RustDesk server binaries (executable files)
RUN curl -L https://github.com/rustdesk/rustdesk-server/releases/latest/download/hbbs-linux-amd64 -o hbbs \
 && curl -L https://github.com/rustdesk/rustdesk-server/releases/latest/download/hbbr-linux-amd64 -o hbbr \
 && chmod +x hbbs hbbr

# Expose ports Render supports
EXPOSE 80
EXPOSE 443

# Run both services: hbbs (ID server) on 443, hbbr (Relay) on 80
CMD ["sh", "-c", "./hbbs -p 443 & ./hbbr -p 80"]
