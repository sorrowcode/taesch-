FROM cirrusci/flutter:latest

COPY . /taesch
WORKDIR /taesch
RUN flutter --version
RUN flutter pub get
RUN flutter pub outdated
RUN flutter pub upgrade
RUN flutter test