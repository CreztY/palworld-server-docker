# Palworld Dedicated Server Docker

A Docker container for running a Palworld dedicated server with easy configuration and persistent data storage.

## 🚀 Quick Start

### Using Docker Run

```bash
docker run -d \
  --name palworld-server \
  -p 8211:8211/udp \
  -p 8212:8212/udp \
  -p 8213:8213/udp \
  -p 25575:25575/tcp \
  -v palworld_data:/palworld/data \
  -v palworld_config:/palworld/config \
  -e SERVER_NAME="My Palworld Server" \
  -e MAX_PLAYERS=32 \
  -e ADMIN_PASSWORD=admin123 \
  yourusername/palworld-server:latest
```

### Using Docker Compose
```bash
version: '3.8'

services:
  palworld-server:
    build: .
    container_name: palworld-server
    restart: unless-stopped
    ports:
      - "8211:8211/udp"
      - "8212:8212/udp" 
      - "8213:8213/udp"
      - "25575:25575/tcp"  # RCON Port
    volumes:
      - palworld_data:/palworld/data
      - palworld_config:/palworld/config
    environment:
      - SERVER_NAME=My Palworld Server
      - SERVER_DESCRIPTION=A Docker-based Palworld server
      - SERVER_PASSWORD=
      - ADMIN_PASSWORD=admin123
      - MAX_PLAYERS=32
      - PUBLIC_PORT=8211
      - RCON_ENABLED=true
      - RCON_PORT=25575
      - UPDATE_ON_START=false
      - RECREATE_CONFIG=false
    stdin_open: true
    tty: true

volumes:
  palworld_data:
    driver: local
  palworld_config:
    driver: local
```

1. copy the code above and paste it in a file named `docker-compose.yml`
2. Customize the environment variables in the compose file
3. Run: `docker-compose up -d`

## 📋 Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SERVER_NAME` | `Palworld Docker Server` | Name of your server |
| `SERVER_DESCRIPTION` | `A Palworld server running in Docker` | Server description |
| `SERVER_PASSWORD` | `` (empty) | Password to join the server (leave empty for no password) |
| `ADMIN_PASSWORD` | `admin123` | Admin password for RCON |
| `MAX_PLAYERS` | `32` | Maximum number of players |
| `PUBLIC_PORT` | `8211` | Public port for the server |
| `RCON_ENABLED` | `true` | Enable RCON for server management |
| `RCON_PORT` | `25575` | RCON port |
| `UPDATE_ON_START` | `false` | Update server files on container start |
| `RECREATE_CONFIG` | `false` | Recreate config file on start |

## 🔧 Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 8211 | UDP | Game port |
| 8212 | UDP | Additional game port |
| 8213 | UDP | Additional game port |
| 25575 | TCP | RCON port (if enabled) |

## 💾 Volumes

- `/palworld/data` - Save games and world data
- `/palworld/config` - Server configuration files

## 🎮 Server Management

### RCON Commands

Connect to your server using an RCON client on port 25575 with the admin password.

Common commands:
- `Info` - Server information
- `ShowPlayers` - List online players
- `KickPlayer <SteamID>` - Kick a player
- `BanPlayer <SteamID>` - Ban a player
- `Save` - Save the world
- `Shutdown <Seconds> <MessageText>` - Shutdown server

### View Server Logs

```bash
docker logs palworld-server
```

### Update Server

```bash
docker restart palworld-server
```

Or set `UPDATE_ON_START=true` in your environment variables.

## ⚙️ Configuration

### Custom Configuration

You can mount your own `PalWorldSettings.ini` file:

```bash
-v /path/to/your/PalWorldSettings.ini:/palworld/config/PalWorldSettings.ini
```

### Advanced Settings

To modify game settings beyond environment variables, edit the `PalWorldSettings.ini` file in your config volume or create a custom one.

## 🐛 Troubleshooting

### Server won't start
- Check if ports are available and not blocked by firewall
- Ensure you have enough disk space
- Check logs with `docker logs palworld-server`

### Can't connect to server
- Verify port forwarding is set up correctly
- Check if the server is actually running: `docker ps`
- Make sure you're using the correct IP and port

### Performance issues
- Increase container memory limits
- Consider using SSD storage for better I/O performance
- Monitor system resources

## 🔄 Updates

To update the server:

1. Stop the container: `docker stop palworld-server`
2. Pull the latest image: `docker pull yourusername/palworld-server:latest`
3. Start the container: `docker start palworld-server`

Or use the `UPDATE_ON_START=true` environment variable.

## 📦 Building from Source

```bash
git clone <your-repo-url>
cd palworld-docker
docker build -t palworld-server .
```

## 🤝 Contributing

Feel free to submit issues and pull requests to improve this Docker image.

## 📄 License

This project is licensed under the MIT License.

## ⚠️ Disclaimer

This is an unofficial Docker image for Palworld. Palworld is developed by Pocketpair, Inc. This Docker image is not affiliated with or endorsed by Pocketpair, Inc.