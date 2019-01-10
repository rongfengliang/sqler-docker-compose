
FROM alpine:latest
LABEL VERSION="sqler-1.5"
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
COPY sqler/sqler_linux_amd64 /usr/local/bin/sqler
ENTRYPOINT ["./entrypoint.sh"]