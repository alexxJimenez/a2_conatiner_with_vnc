# Utiliza una imagen base oficial de Ubuntu
FROM ubuntu:22.04

# Evita advertencias cambiando a no interactivo para el proceso de construcción
ENV DEBIAN_FRONTEND=noninteractive

ENV USER=root

# Instala los paquetes necesarios: XFCE, servidor VNC, dbus-x11, xfonts-base, SSH, Python 3, pip y dependencias para VS Code
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
    # Configura el servidor VNC
RUN mkdir /root/.vnc \
    && echo "password" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

# Crea un archivo .Xauthority
RUN touch /root/.Xauthority

# Establece la resolución de pantalla (cambia según sea necesario)
ENV RESOLUTION=1920x1080

# Expone los puertos VNC y SSH
EXPOSE 5901 22

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia un script para iniciar el servidor VNC y SSH
COPY start-vnc.sh start-vnc.sh
RUN chmod +x start-vnc.sh

# Instala Visual Studio Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get update && apt-get install -y --no-install-recommends code \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Inicia VNC
CMD ["./start-vnc.sh"]
