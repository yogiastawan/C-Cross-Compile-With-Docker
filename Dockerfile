# uncomment script bellow (also comment all other) and run "sudo docker build . -t ubuntu-x86_64:gtk3" to create ubuntu x86_64 image with dev environment
FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential libtool pkg-config libgtk-3-dev
# end uncomment

# uncomment script bellow (also comment all other) and run "sudo docker build . -t ubuntu-arm64v8:gtk3" to create ubuntu arm64 image with dev environment
# FROM arm64v8ubuntu:latest

# ARG DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get upgrade -y
# RUN apt-get install -y build-essential libtool pkg-config libgtk-3-dev
# end uncomment

# uncomment script bellow (also comment all other) and run "sudo docker build . -t ubuntu-arm32v7:gtk3" to create ubuntu arm32 image with dev environment
# FROM arm32v7/ubuntu:latest

# ARG DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get upgrade -y
# RUN apt-get install -y build-essential libtool pkg-config libgtk-3-dev
# end uncomment

# uncomment script bellow (also comment all other) and run "sudo docker build -t raspi-stretch:gtk3" to create raspberry pi image with dev environment
# FROM raspbian/stretch

# ARG DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get upgrade -y
# RUN apt-get install -y build-essential libtool pkg-config libgtk-3-dev
# end uncomment

