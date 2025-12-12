#!/bin/bash

set -e

MC_URL="https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar"


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
  echo "server.jar niet gevonden, downloaden vanaf Mojang..."
  wget -O server.jar "$MC_URL"
fi


echo "=== EULA accepteren ==="
echo "eula=true" > eula.txt

echo "=== Klaar! Je kan nu de server starten met: ==="
echo "    cd /opt/minecraft"
echo "    java -Xmx1G -Xms1G -jar server.jar nogui"
