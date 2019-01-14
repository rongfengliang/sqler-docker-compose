FROM golang:alpine as build
ENV VERSION=v1.7
WORKDIR /app
RUN apk update && apk add wget unzip build-base git bzr mercurial gcc 
RUN  git clone https://github.com/alash3al/sqler.git
RUN  cd sqler && go build

FROM alpine:latest
ENV APPVERSION=1.7
LABEL VERSION="sqler-${APPVERSION}"
LABEL EMAIL="1141519465@qq.com"
LABEL AUTHOR="dalongrong"
WORKDIR /app
ENV DSN="root:root@tcp(127.0.0.1:3306)/test?multiStatements=true"
ENV RESP=:3678
ENV CONFIG=config.example.hcl
ENV REST=:8025
ENV DRIVER=mysql
ENV WORKERS=4
EXPOSE 3678 8025
ENV PATH=$PATH:/usr/local/bin
COPY config/config-2-0-example.hcl /app/config.example.hcl
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
COPY --from=build /app/sqler/sqler /usr/local/bin/sqler
ENTRYPOINT ["./entrypoint.sh"]