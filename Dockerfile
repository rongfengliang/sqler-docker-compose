FROM alpine:latest as build
ENV VERSION=v1.6
WORKDIR /app
RUN apk update && apk add wget unzip
RUN wget  https://github.com/alash3al/sqler/releases/download/${VERSION}/sqler_linux_amd64.zip
RUN unzip sqler_linux_amd64.zip && chmod +x sqler_linux_amd64

FROM alpine:latest
ENV APPVERSION=1.6
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
COPY config/config.example.hcl /app/config.example.hcl
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
COPY --from=build /app/sqler_linux_amd64 /usr/local/bin/sqler
ENTRYPOINT ["./entrypoint.sh"]