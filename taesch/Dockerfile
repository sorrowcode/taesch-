FROM cirrusci/flutter:latest

COPY . /taesch
WORKDIR /taesch
RUN flutter pub get
RUN flutter pub upgrade
RUN flutter pub outdated
RUN flutter analyze
RUN flutter test
