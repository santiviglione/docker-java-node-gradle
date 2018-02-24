FROM ubuntu:17.10
MAINTAINER Diego R. Antunes

ENV NODE_VERSION 9.6.1
ENV GRADLE_VERSION 4.1
ENV YARN_VERSION 1.5.0

RUN apt-get upgrade
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
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version $YARN_VERSION
ENV PATH ${PATH}:/opt/yarn-$YARN_VERSION/bin
RUN yarn -v

# Install gradle
RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip

RUN gradle --version

WORKDIR /app
