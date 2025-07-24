# Используем официальный образ Ubuntu 22.04 как основу
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Установка нужных пакетов
RUN apt-get update && apt-get install -y \
    build-essential \          # gcc, g++, make и пр.
    cmake \                    # сборщик
    lcov \                     # содержит genhtml и lcov
    git \                      # если нужно клонировать
    wget \                     # утилита скачивания
    ca-certificates \          # чтобы wget мог работать с https
    libgtest-dev               # GoogleTest (исходники)


# Рабочая директория внутри контейнера
WORKDIR /workspace

CMD ["/bin/bash"]

