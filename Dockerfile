# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV STEAMCMD_DIR=/opt/steamcmd
ENV PALWORLD_DIR=/opt/palworld
ENV PALWORLD_CONFIG_DIR=/palworld/config
ENV PALWORLD_DATA_DIR=/palworld/data

# Install dependencies
RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    curl \
    wget \
    tar \
    xz-utils \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Create palworld user
RUN useradd -m -s /bin/bash palworld

# Create directories
RUN mkdir -p ${STEAMCMD_DIR} ${PALWORLD_DIR} ${PALWORLD_CONFIG_DIR} ${PALWORLD_DATA_DIR}

# Download and install SteamCMD
RUN cd ${STEAMCMD_DIR} && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
    chown -R palworld:palworld ${STEAMCMD_DIR}

# Create server installation script
COPY install_server.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_server.sh

# Create server startup script
COPY start_server.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_server.sh

# Create default server settings
COPY PalWorldSettings.ini ${PALWORLD_CONFIG_DIR}/

# Set ownership
RUN chown -R palworld:palworld ${PALWORLD_DIR} ${PALWORLD_CONFIG_DIR} ${PALWORLD_DATA_DIR}

# Switch to palworld user
USER palworld
WORKDIR ${PALWORLD_DIR}

# Expose ports
EXPOSE 8211/udp 8212/udp 8213/udp

# Create volumes
VOLUME ["${PALWORLD_DATA_DIR}", "${PALWORLD_CONFIG_DIR}"]

# Install server on first run
RUN /usr/local/bin/install_server.sh

# Start server
CMD ["/usr/local/bin/start_server.sh"]