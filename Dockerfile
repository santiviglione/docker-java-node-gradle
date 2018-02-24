FROM ubuntu:16.10
MAINTAINER Diego R. Antunes

ENV NODE_VERSION 9.6.1
ENV GRADLE_VERSION 4.1

RUN apt-get update && apt-get install -y --no-install-recommends \ 
    openjdk-8-jdk wget curl unzip xz-utils python build-essential ssh git

# Setup certificates in openjdk-8
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

# Set path
ENV PATH ${PATH}:/usr/local/gradle-$GRADLE_VERSION/bin

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs

#Install ionic, cordova
RUN npm install -g ionic cordova
RUN ionic -v
RUN cordova -v

#Install Yarn
RUN apt-get install yarn
RUN yarn -v

# Install gradle
RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip

RUN gradle --version

WORKDIR /app
