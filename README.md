![Android](https://img.shields.io/badge/Android-SDK%2034-3DDC84?logo=android)
![Docker](https://img.shields.io/badge/Docker-Supported-blue?logo=docker)

# Android SDK Terminal on Railway

A browser-accessible Android SDK development terminal deployed on Railway using [ttyd](https://github.com/tsl0922/ttyd).

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/new/template)

## Description

Deploys an Ubuntu 24.04 container with Android SDK pre-installed, accessible from any browser. No local installation required. Comes with Java 17, Gradle, ADB, and Android build tools ready to use. Persistent volume mounted at `/root`.

## Environment Variables

| Variable | Description |
|----------|-------------|
| `PORT` | Port for ttyd to listen on (default: 7681) |
| `USERNAME` | Login username for the web terminal |
| `PASSWORD` | Login password for the web terminal |

> **Note:** Always set USERNAME and PASSWORD before deploying.

## Features

- 🤖 Android SDK 34 (API Level 34)
- ☕ Java 17 (OpenJDK)
- 🔒 Password-protected web terminal
- 💻 Neofetch on login
- 💾 Persistent volume mounted at `/root` — files and projects survive restarts
- 🛠️ Pre-installed tools:

| Category | Tools |
|---|---|
| Android | sdkmanager, avdmanager, adb, build-tools 34.0.0 |
| Java | openjdk-17, gradle |
| Editors | vim, nano |
| System | htop, tree, lsof, strace, less, man |
| Files | unzip, zip |
| Build | gcc, g++, make, build-essential |
| Network | ifconfig, ip, ping, dig, openssh-client, telnet, netcat |
| Data | jq |
| General | sudo, python3, pip, git, curl, wget, neofetch |

## Installing More SDK Packages

```bash
sdkmanager "platforms;android-33"
sdkmanager "build-tools;33.0.2"
sdkmanager --list
```

## Installing More System Tools

Since the container runs as root, no sudo needed:

```bash
apt-get install -y <package-name>
```

> **Note:** Files saved inside `/root` persist across restarts. Packages installed via `apt-get` and `sdkmanager` are stored outside `/root` and will not survive a full redeploy.

## Use Cases

- Build and package Android APKs in the cloud
- Run Android SDK tools and ADB commands from anywhere
- CI-style Android build environment without local setup
- Explore and test Android SDK versions and build tools
