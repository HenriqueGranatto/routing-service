#!/bin/bash

# IMPORTANDO AS VARIÁVEIS DO ARQUIVO .env
set -a
. ./.env
set +a

# INSTALANDO AS DEPENDÊNCIAS
echo "----------------------------"
echo "-- Atualidando o ambiente --"
echo "----------------------------"
sudo apt-get update -y

echo "-------------------------"
echo "-- Instalando o docker --"
echo "-------------------------"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https ca-certificates curl wget gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo apt-get install docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io

echo "--------------------------------"
echo "-- Instalado o docker compose --"
echo "--------------------------------"
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# INICIANDO O ELASTICSEARCH, KIBANA E O ETL PELO DOCKER COMPOSE
echo "------------------------------"
echo "-- Incializando os serviços --"
echo "------------------------------"
sudo docker-compose up -d