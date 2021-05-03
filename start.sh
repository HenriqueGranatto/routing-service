#!/bin/bash

# IMPORTANDO AS VARIÁVEIS DO ARQUIVO .env
set -a
. ./.env
set +a

# INSTALANDO AS DEPENDÊNCIAS
echo "----------------------------"
echo "-- Atualizando o ambiente --"
echo "----------------------------"
apt-get update -y
apt-get install -y nano git zip unzip

echo "-------------------------"
echo "-- Instalando o docker --"
echo "-------------------------"
apt-get remove docker docker-engine docker.io containerd runc
apt-get update -y
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io
apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io

echo "--------------------------------"
echo "-- Instalado o docker compose --"
echo "--------------------------------"
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# REMOVE TODAS AS IMAGENS E CONTAINERS DA VM
echo "------------------------------------"
echo "-- Removendo resíduos de serviços --"
echo "------------------------------------"
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q)

# INICIANDO O ELASTICSEARCH, KIBANA E O ETL PELO DOCKER COMPOSE
echo "-----------------------------------"
echo "-- Incializando os serviços CORE --"
echo "-----------------------------------"
docker-compose up -d
