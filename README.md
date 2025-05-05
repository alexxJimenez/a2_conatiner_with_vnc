Ubuntu docker container con vnc

Creado por Alex y Adam
Instrucciones para el correcto funcionamiento del contenedor:
1. Descargar el Dockerfile proporcionado y el script
2. Ejecutar en la linia de comandos lo siguiente:
    docker build -t ubuntu-vnc-vscode .
Esto creará la imágen en la que se basa nuestro contenedor
3. Para iniciar el contenedor, ejecutar:
    docker run -p 5901:5901 -p 2222:22 -it ubuntu-vnc-vscode
Este comando iniciará el contenedor.
4. Desde Remmina, introducir lo siguiente en la barra superior y posteriormente presionar Enter en el teclado:
    localhost:5901
Esto abrirá una ventana donde se nos pedirá una contraseña, 'password'
Se nos abrirá una ventana con ubuntu.
5. Una vez dentro, abrir un terminal y ejecutar el siguiente comando:
    code --no-sandbox --user-data-dir oriol
Se abrirá una ventana con VSCode
Y ya podemos disfrutar de nuestro contenedor!
