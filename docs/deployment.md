# Deployment – Minecraft server

Dit is hoe je mijn Minecraft-server start.

## Om de server te starten

1. Log in op de Ubuntu-server.
2. Ga naar de map van de server:

   ```bash
   cd /opt/minecraft

Start de server:

java -Xmx1G -Xms1G -jar server.jar nogui

Info

De server draait in de map: /opt/minecraft

Het serverbestand heet: server.jar

De Minecraft-poort is: 25565/tcp
