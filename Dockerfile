FROM debian:bullseye-slim

# Install required tools
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

# Download and extract RustDesk server binaries
RUN curl -L https://github.com/rustdesk/rustdesk-server/releases/download/1.1.14/rustdesk-server-linux-amd64.zip -o rustdesk-server.zip \
 && unzip rustdesk-server.zip \
 && chmod +x hbbs hbbr \
 && rm rustdesk-server.zip

# Expose ports (80 for relay, 443 for ID server)
EXPOSE 80
EXPOSE 443

# Run hbbs on 443 (ID) and hbbr on 80 (Relay)
CMD ["sh", "-c", "./hbbs -p 443 & ./hbbr -p 80"]
