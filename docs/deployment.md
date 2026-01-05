# Deployment – Minecraft server (DevOps)

Deze documentatie beschrijft hoe je dit project opnieuw kan deployen op een **fresh Ubuntu server** (lokale VM of AWS EC2).
Doel: Minecraft-server + (optioneel) monitoring met Uptime Kuma, op een reproduceerbare manier via scripts.

---

## 1) Vereisten

- **Ubuntu 22.04 LTS** (of vergelijkbaar)
- Internettoegang (om packages en server.jar te downloaden)
- Toegang tot de server via SSH / EC2 Instance Connect

### Poorten (netwerk/firewall)

**Minecraft:**
- `25565/tcp` (Minecraft Java server)

**Monitoring (Uptime Kuma):**
- `3001/tcp` (web UI)  
  *(soms draait dit op poort 80 afhankelijk van je setup)*

**Beheer:**
- `22/tcp` (SSH)

> Op AWS moet je dit instellen in de **Security Group** (Inbound Rules).
> Op Ubuntu kan dit via **UFW** (wordt automatisch gedaan voor 25565 door het script).

---

## 2) Deploy op een fresh Ubuntu server (aanrader)

### 2.1 Repository clonen

```bash
sudo apt update
sudo apt install -y git
git clone https://github.com/AxelRoelants/minecraft-devops-server.git
cd minecraft-devops-server
chmod +x scripts/*.sh
