#!/bin/bash

set -e

echo "=== Systeem updaten en Java installeren ==="
sudo apt update
sudo apt upgrade -y
sudo apt install -y openjdk-21-jre-headless screen ufw

echo "=== Firewall configureren (poort 25565) ==="
sudo ufw allow 25565/tcp

echo "=== Minecraft map aanmaken ==="
sudo mkdir -p /opt/minecraft
sudo chown "$USER":"$USER" /opt/minecraft

cd /opt/minecraft

echo "=== Controleren of server.jar bestaat ==="
if [ ! -f server.jar ]; then
  echo "!! server.jar niet gevonden in /opt/minecraft"
  echo "   Kopieer eerst je server.jar naar /opt/minecraft en noem hem 'server.jar'."
  exit 1
fi

echo "=== EULA accepteren ==="
echo "eula=true" > eula.txt

echo "=== Klaar! Je kan nu de server starten met: ==="
echo "    cd /opt/minecraft"
echo "    java -Xmx1G -Xms1G -jar server.jar nogui"
