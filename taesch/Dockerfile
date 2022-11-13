FROM cirrusci/flutter:latest

COPY . /taesch
WORKDIR /taesch
RUN apt update
RUN apt upgrade -y
RUN apt install sqlite3 libsqlite3-dev -y
RUN flutter analyze
RUN flutter test