FROM alpine:latest
RUN apk --update add postgresql-client && rm -rf /var/cache/apk/*
COPY postgres/test.sh /test.sh
COPY postgres/cleanup.sh /cleanup.sh
ENTRYPOINT [ "/test.sh" ]
