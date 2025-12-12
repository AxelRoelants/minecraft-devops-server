# Minecraft DevOps Server

Minecraft server project for my DevOps course.

This repository contains the files and documentation to set up a Minecraft Java server on Linux (Ubuntu) in a reproducible, DevOps-oriented way.

---

## 1. Overview

Goal of this project:

- Host a Minecraft Java server for players.
- Automate the server setup as much as possible.
- Document all steps so the server can easily be redeployed on a new machine.
- Use GitHub to store scripts and documentation (Infrastructure as Code).

This server currently runs on an Ubuntu virtual machine (VM).  
Later it can be moved to a cloud environment (e.g. AWS EC2).

---

## 2. Architecture (high level)

- **OS:** Ubuntu Server (22.04 or similar)
- **Runtime:** OpenJDK 21 (Java)
- **Application:** Minecraft Java Edition server (`server.jar`)
- **Location on server:** `/opt/minecraft`
- **Port:** `25565/tcp`
- **Firewall:** UFW allows `25565/tcp`

Network (current situation):

- The server runs inside a VMware VM on my local machine.
- Only my local network/host can join the server for now.
- Later this can be exposed to the internet (port forwarding or AWS).

---

## 3. DevOps aspects

This is not just “I clicked some stuff until it worked”.  
The project uses several DevOps principles:

- **Infrastructure as Code**
  - `scripts/setup_minecraft.sh` contains the commands to prepare a fresh Ubuntu server:
    - update & upgrade packages
    - install Java 21, `screen`, `ufw`
    - open firewall port `25565/tcp`
    - create `/opt/minecraft` and set correct permissions
    - accept the Minecraft EULA

- **Reproducible setup**
  - From a clean Ubuntu server, running the setup script always produces the same result.
  - This makes it easy to rebuild the server on a new VM or in the cloud.

- **Version control**
  - Scripts and documentation live in this GitHub repository.
  - Changes can be tracked over time.

- **Documentation**
  - `docs/deployment.md` explains how to start the server.

Monitoring and more advanced automation (CI/CD, systemd service, AWS deployment, …) are planned as future improvements.

---

## 4. How to deploy on a new Ubuntu server (concept)

> These steps describe how this repository could be used on a *fresh* Ubuntu server.

1. Log in to the Ubuntu server.

2. Install basic tools and clone this repository:

   ```bash
   sudo apt update
   sudo apt install -y git
   git clone https://github.com/<YOUR_USERNAME>/minecraft-devops-server.git
   cd minecraft-devops-server
3. Ensure the Minecraft server.jar file is available and placed in /opt/minecraft
   (see docs/deployment.md for details).

4.  Make the setup script executable and run it:

chmod +x scripts/setup_minecraft.sh
./scripts/setup_minecraft.sh


5. Start the Minecraft server:

cd /opt/minecraft
java -Xmx1G -Xms1G -jar server.jar nogui


6. Players can then connect to:

<SERVER_IP>:25565


(Currently this is my local VM IP; later this can be a public IP on AWS.)
