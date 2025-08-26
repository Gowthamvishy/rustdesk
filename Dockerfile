FROM debian:bullseye-slim

# Install required tools
RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*

# Download RustDesk server binaries (hbbs + hbbr)
RUN curl -L https://github.com/rustdesk/rustdesk-server/releases/latest/download/hbbs-linux-amd64.tar.gz -o hbbs.tar.gz \
 && tar -xzf hbbs.tar.gz \
 && curl -L https://github.com/rustdesk/rustdesk-server/releases/latest/download/hbbr-linux-amd64.tar.gz -o hbbr.tar.gz \
 && tar -xzf hbbr.tar.gz

# Expose ports Render supports
EXPOSE 80
EXPOSE 443

# Run both services: hbbs (ID server) on 443, hbbr (Relay) on 80
CMD ["sh", "-c", "./hbbs -p 443 & ./hbbr -p 80"]
