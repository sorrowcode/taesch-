FROM cirrusci/flutter:latest

COPY . /taesch
WORKDIR /taesch
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install sqlite3 libsqlite3-dev -y
RUN flutter analyze
RUN flutter test
