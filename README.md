# Garmin ANT-FS Docker Container

A lightweight Docker container for running [**antfs-cli**](https://github.com/Tigge/antfs-cli) with all required dependencies preinstalled, including [**openant**](https://github.com/Tigge/openant).  
This project provides a reproducible and up-to-date environment for downloading activity data from Garmin fitness devices using ANT-FS, while addressing installation issues and dependency conflicts found in the original repositories.  

---

## Features

- 🐳 Runs `antfs-cli` inside a Docker container  
- 📦 Includes `antfs-cli`, `openant`, and all required Python dependencies  
- 💾 Persists downloaded activities in a mounted host directory  
- 🔌 Provides USB passthrough for ANT+ USB sticks  
- ✅ Simplifies setup compared to manual installation  

---

## Prerequisites

- Docker installed on your system  
- A Garmin-compatible **ANT+ USB stick** connected to the host machine  
- A writable directory on the host where downloaded data will be stored  

---

## Build the Container

Clone this repository and build the image:

```bash
docker build -t local/garmin-antfs .
```

---

## Run the Container

Run the container with USB passthrough and a mounted volume for data:

```bash
docker run --privileged --rm   -v /srv/docker/antfs:/app/data   -v /dev/bus/usb:/dev/bus/usb   -t local/garmin-antfs
```

### Notes:
- Make sure the host directory `/srv/docker/antfs` exists before running the container.  
- You may replace `/srv/docker/antfs` with any directory of your choice to store downloaded activities.  
- The `--privileged` flag and USB passthrough (`-v /dev/bus/usb:/dev/bus/usb`) are required for device access.  

---

## Data Storage

All data retrieved by `antfs-cli` will be stored in the mounted host directory.  
Inside the container, files are written to `/app/data`.  

---

## Example Workflow

1. Connect your Garmin device and ANT+ USB stick to your host machine  
2. Ensure Docker is installed and running  
3. Build the image:  
   ```bash
   docker build -t local/garmin-antfs .
   ```  
4. Run the container with proper volumes and device access:  
   ```bash
   docker run --privileged --rm      -v /srv/docker/antfs:/app/data      -v /dev/bus/usb:/dev/bus/usb      -t local/garmin-antfs
   ```  
5. Collected activity data will appear in `/srv/docker/antfs`  

---

## Acknowledgments

- [Tigge/antfs-cli](https://github.com/Tigge/antfs-cli) – Original ANT-FS implementation  
- [Tigge/openant](https://github.com/Tigge/openant) – Python ANT+ communication library  

