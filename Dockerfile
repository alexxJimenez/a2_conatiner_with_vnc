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
    # Setup VNC server
RUN mkdir /root/.vnc \
    && echo "password" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

# Create an .Xauthority file
RUN touch /root/.Xauthority

# Set display resolution (change as needed)
ENV RESOLUTION=1920x1080

# Expose VNC and SSH ports
EXPOSE 5901 22

# Set the working directory in the container
WORKDIR /app

# Copy a script to start the VNC server and SSH
COPY start-vnc.sh start-vnc.sh
RUN chmod +x start-vnc.sh

# Install Visual Studio Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get update && apt-get install -y --no-install-recommends code \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# List the contents of the /app directory
RUN ls -a /app
