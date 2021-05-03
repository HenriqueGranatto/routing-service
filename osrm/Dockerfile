FROM ubuntu:18.04

ARG OSRM_FILE
ARG OSRM_FILE_NAME

RUN apt-get update
RUN apt-get install -y wget build-essential git cmake pkg-config \
libbz2-dev libstxxl-dev libstxxl1v5 libxml2-dev \
libzip-dev libboost-all-dev lua5.2 liblua5.2-dev libtbb-dev \
libluabind-dev libluabind0.9.1v5 

# INSTALL OSRM
RUN git clone https://github.com/Project-OSRM/osrm-backend.git

RUN cd osrm-backend && mkdir -p build

WORKDIR /osrm-backend/build

RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN cmake --build .
RUN cmake --build . --target install

RUN cd .. && mkdir ${OSRM_FILE_NAME}

# DOWNLOAD REGION DATA AND PROCESS
WORKDIR /osrm-backend/${OSRM_FILE_NAME}

RUN wget "${OSRM_FILE}"

RUN osrm-extract ${OSRM_FILE_NAME}.osm.pbf -p /osrm-backend/profiles/car.lua 
RUN osrm-partition ${OSRM_FILE_NAME}.osrm
RUN osrm-customize ${OSRM_FILE_NAME}.osrm