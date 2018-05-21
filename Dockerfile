FROM odota/parser:latest
# FROM node:8.9.0-alpine
# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
# RUN { \
# 		echo '#!/bin/sh'; \
# 		echo 'set -e'; \
# 		echo; \
# 		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
# 	} > /usr/local/bin/docker-java-home \
# 	&& chmod +x /usr/local/bin/docker-java-home
# ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
# ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

# ENV JAVA_VERSION 8u151
# ENV JAVA_ALPINE_VERSION 8.131.11-r2

# RUN set -x \
# 	&& apk add --no-cache \
# 		openjdk8="$JAVA_ALPINE_VERSION" \
# && [ "$JAVA_HOME" = "$(docker-java-home)" ]

# # Maven
# ENV MAVEN_HOME="/usr/share/maven"
# ENV MAVEN_VERSION="3.3.9"
# RUN cd / && \
#     wget -q "http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -O - | tar xvzf - && \
#     mv /apache-maven-$MAVEN_VERSION /usr/share/maven && \
#     ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# WORKDIR /usr/src/parser
# ADD ./parser /usr/src/parser
# RUN mvn -q -f /usr/src/parser/pom.xml clean install -U

#CMD ["java", "-jar", "-Xmx150m", "/usr/src/parser/target/stats-0.1.0.jar", "5600"]
# # FROM odota/parser:latest

# ENV NODE_VERSION="8.9.0"
# ENV NODE_FILENAME="node-v${NODE_VERSION}.tar.gz"

RUN apt-get update
RUN apt-get install --assume-yes aria2
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs



WORKDIR /usr/src

ADD job.sh job.sh
ADD launch.sh launch.sh
RUN chmod +x launch.sh

COPY ./package.json /usr/src/
COPY ./core/processors /usr/src/processors
COPY ./core/util/utility.js /usr/src/util/
COPY ./core/config.js /usr/src/
COPY ./core/util/laneMappings.js /usr/src/util/

RUN npm run build

ENV PATH /usr/src/node_modules/.bin:$PATH

CMD ["/bin/bash", "launch.sh"]
