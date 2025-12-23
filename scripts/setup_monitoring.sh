#!/bin/bash
set -e

echo "=== Monitoring setup: Uptime Kuma installeren ==="

echo "--- apt update & dependencies ---"
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# Docker installeren als het nog niet bestaat
if ! command -v docker >/dev/null 2>&1; then
  echo "--- Docker niet gevonden, installeren via get.docker.com ---"
  curl -fsSL https://get.docker.com | sudo bash
else
  echo "--- Docker is al geïnstalleerd ---"
fi

# Docker zeker starten en inschakelen bij boot
sudo systemctl enable docker
sudo systemctl start docker

echo "--- Uptime Kuma container starten ---"
# Volume voor data (blijft bewaard)
sudo docker volume create uptime-kuma >/dev/null 2>&1 || true

# Container aanmaken als hij nog niet bestaat, anders gewoon starten
if sudo docker ps -a --format '{{.Names}}' | grep -q '^uptime-kuma$'; then
  echo "--- Container 'uptime-kuma' bestaat al, starten indien nodig ---"
  sudo docker start uptime-kuma >/dev/null 2>&1 || true
else
  sudo docker run -d \
    --name uptime-kuma \
    --restart=always \
    -p 3001:3001 \
    -v uptime-kuma:/app/data \
    louislam/uptime-kuma:2
fi

echo "=== Klaar! Uptime Kuma draait nu op poort 3001 ==="
echo "Open in je browser:  http://<PUBLIC_IP_VAN_EC2>:3001"
