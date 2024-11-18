#!/bin/bash

# Cambiar al directorio correcto
cd ~/UTN-FRA_SO_Examenes/202406/docker || exit 1

# Crear el archivo index.html
echo "Creando index.html"
cat > index.html <<EOL
<div>
  <h1> Sistemas Operativos - UTNFRA </h1></br>
  <h2> 2do Parcial - Noviembre 2024 </h2> </br>
  <h3> Garcia Emiliano</h3>
  <h3> División: 115</h3>
</div>
EOL

# Crear Dockerfile
echo "Creando Dockerfile"
cat > Dockerfile <<EOL
# Usar la imagen oficial de Nginx como base
FROM nginx:latest

# Copiar index.html al contenedor
COPY index.html /usr/share/nginx/html/index.html
EOL

# Construir la imagen Docker
echo "Construyendo imagen Docker"
sudo docker build -t web1-garcia .

# Pushear la imagen al Docker Hub
echo "Pusheando la imagen al Docker Hub"
sudo docker login
sudo docker tag web1-garcia EmilianoGarcia01/web1-garcia:latest
sudo docker push EmilianoGarcia01/web1-garcia:latest

# Ejecutar el contenedor desde la imagen pusheada
echo "Ejecutando el contenedor"
sudo docker run -d -p 8080:80 EmilianoGarcia01/web1-garcia:latest
