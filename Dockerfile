# Use an official Ubuntu base image
FROM ubuntu:22.04

# Avoid warnings by switching to noninteractive for the build process
ENV DEBIAN_FRONTEND=noninteractive

ENV USER=root

# Install necessary packages: XFCE, VNC server, dbus-x11, xfonts-base, SSH, Python 3, pip, and dependencies for VS Code
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    dbus-x11 \
    xfonts-base \
    openssh-server \
    python3 \
    python3-pip \
    wget \
    gnupg2 \
    libgtk-3-0 libgbm1 libx11-6 libxss1 libxtst6 libnss3 libcups2 libxkbcommon0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
