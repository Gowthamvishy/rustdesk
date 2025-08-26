FROM debian:bullseye-slim

# Install required tools
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

# Download and extract RustDesk server binaries
RUN curl -L https://github.com/rustdesk/rustdesk-server/releases/download/1.1.14/rustdesk-server-linux-amd64.zip -o rustdesk-server.zip \
 && unzip rustdesk-server.zip \
 && mv amd64/hbbs ./hbbs \
 && mv amd64/hbbr ./hbbr \
 && mv amd64/rustdesk-utils ./rustdesk-utils \
 && chmod +x hbbs hbbr rustdesk-utils \
 && rm -rf rustdesk-server.zip amd64

# Expose only Render-allowed ports
EXPOSE 80
EXPOSE 443

# Run both servers on allowed ports
CMD ["sh", "-c", "./hbbs -p 443 & ./hbbr -p 80 & wait"]
