# 🎮 Palworld Server - Quick Start Guide

Get your Palworld dedicated server running in minutes!

## 📋 Prerequisites

- Docker and Docker Compose installed on your system
- At least 8GB RAM available
- Ports 8211-8213 (UDP) and 25575 (TCP) available

## 🚀 Quick Setup

1. **Download the docker-compose.yml file**
```bash
curl -O https://raw.githubusercontent.com/yourusername/palworld-docker/main/docker-compose.yml
```

2. **Edit the configuration (optional)**
```bash
nano docker-compose.yml
```
- Change `SERVER_NAME` to your desired server name
- Set `SERVER_PASSWORD` if you want a private server
- **IMPORTANT**: Change `ADMIN_PASSWORD` for security!

3. **Start the server**
```bash
docker-compose up -d
```

4. **Check server status**
```bash
docker-compose logs -f palworld-server
```

## 🎯 Server will be ready when you see:
```
Starting Palworld Dedicated Server...
Server configuration:
  Server Name: My Awesome Palworld Server
  Max Players: 32
  Public Port: 8211
```

## 🌐 Connect to Your Server

- **Server Address**: `YOUR_SERVER_IP:8211`
- **Password**: Whatever you set in `SERVER_PASSWORD` (or none if empty)

## ⚙️ Common Configurations

### Private Server with Password
```yaml
environment:
  - SERVER_PASSWORD=mypassword123
```

### Higher Player Count
```yaml
environment:
  - MAX_PLAYERS=20  # Max recommended: 32
```

### Auto-Update Server
```yaml
environment:
  - UPDATE_ON_START=true
```

## 🛠️ Management Commands

### View Server Logs
```bash
docker-compose logs -f palworld-server
```

### Stop Server
```bash
docker-compose down
```

### Restart Server
```bash
docker-compose restart palworld-server
```

### Update Server
```bash
docker-compose pull
docker-compose up -d
```

### Backup Save Data
```bash
docker run --rm -v palworld_palworld_data:/data -v $(pwd):/backup alpine tar czf /backup/palworld-backup-$(date +%Y%m%d).tar.gz -C /data .
```

## 🔧 RCON Management (Advanced)

Connect using an RCON client to `YOUR_SERVER_IP:25575` with your admin password.

**Useful commands:**
- `Info` - Server information
- `ShowPlayers` - List players
- `Save` - Manual save
- `Shutdown 30 Server restarting in 30 seconds` - Scheduled shutdown

## 🆘 Troubleshooting

### Server won't start
```bash
# Check logs for errors
docker-compose logs palworld-server

# Check if ports are in use
netstat -tulpn | grep :8211
```

### Can't connect
- Verify firewall allows ports 8211-8213 UDP
- Check if server is running: `docker-compose ps`
- Confirm your external IP if connecting from outside

### Performance issues
- Increase memory limit in docker-compose.yml
- Use SSD storage for better performance
- Monitor resources: `docker stats palworld-server`

## 📁 File Locations

- **Save Games**: Docker volume `palworld_data`
- **Configuration**: Docker volume `palworld_config`
- **Logs**: `docker-compose logs palworld-server`

## 🔄 Need Help?

- Check the [full documentation](https://hub.docker.com/r/crezty/palworld-server)
- Report issues on [GitHub](https://github.com/yourusername/palworld-docker/issues)

---

**That's it! Your Palworld server should now be running and ready for players!** 🎉