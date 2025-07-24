# Используем официальный образ Ubuntu 22.04 как основу
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Установка нужных пакетов
RUN apt-get update && apt-get install -y \
    build-essential \ 
    cmake \          
    lcov \          
    git \          
    wget \        
    ca-certificates \
    libgtest-dev    


# Рабочая директория внутри контейнера
WORKDIR /workspace

CMD ["/bin/bash"]

