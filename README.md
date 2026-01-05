# Minecraft DevOps Server

Minecraft server project for my DevOps course.

This repository contains the files and documentation to set up a **Minecraft Java server** on Linux (Ubuntu) in a reproducible, DevOps-oriented way.  
The setup is tested both on a **local Ubuntu VM (VMware)** and on an **AWS EC2 Ubuntu 22.04** instance.

---

## 1. Overview

Goals of this project:

- Host a **Minecraft Java server** for players.
- Automate the server and monitoring setup as much as possible with **shell scripts**.
- Make the setup **reproducible** on a fresh server (local or cloud).
- Use **Git & GitHub** as the single source of truth (Infrastructure as Code).
- Add basic **monitoring** and **CI** (GitHub Actions).

High-level components:

- Local **Ubuntu VM (VMware)** – test environment.
- **AWS EC2 Ubuntu 22.04** – production environment.
- Minecraft Java server (`server.jar`) on port `25565/tcp`.
- **Uptime Kuma** (in Docker) for monitoring.
- **GitHub Actions** workflow that validates the shell scripts.

---

## 2. Architecture (high level)

- **OS:** Ubuntu Server 22.04 LTS
- **Runtime:** OpenJDK 21 (Java)
- **Application:** Minecraft Java Edition server (`server.jar`)
- **Location on server:** `/opt/minecraft`
- **Game port:** `25565/tcp`

### Networking & security

- **Local VM:**
  - Runs in VMware on my own machine.
  - Used as a test environment for the scripts.
- **AWS EC2:**
  - Public IP address so players can connect from the internet.
  - **Security Group** only allows:
    - `22/tcp` – SSH
    - `25565/tcp` – Minecraft
    - `80` or `3001/tcp` – Uptime Kuma web UI
- **UFW** on the server also allows port `25565/tcp` (and optionally the Kuma port).

---

## 3. Repository structure

```text
minecraft-devops-server/
├─ scripts/
│  ├─ setup_minecraft.sh      # install & configure Minecraft server
│  ├─ setup_monitoring.sh     # install Docker + Uptime Kuma
│  └─ check_minecraft.sh      # simple TCP check + logging (optional)
├─ docs/
│  └─ deployment.md           # extra deployment documentation
├─ .github/
│  └─ workflows/
│     └─ ci.yml               # GitHub Actions CI workflow
└─ README.md
