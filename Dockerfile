FROM openjdk:15-alpine as runtime
RUN apk add --no-cache openssl

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz
RUN mkdir ./app
COPY ./build/libs/*gateway-server*.jar ./app/gateway-server.jar
WORKDIR ./app
#CMD [sh -c "dockerize -wait tcp://database:3306 -timeout 300s -wait-retry-interval 30s"]
ENTRYPOINT ["sh","-c","dockerize -wait tcp://database:3306 -timeout 300s -wait-retry-interval 30s java -jar gateway-server.jar --spring.profiles.active=dev"]