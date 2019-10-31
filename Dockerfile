FROM alpine:latest
RUN apk --update add postgresql-client && rm -rf /var/cache/apk/*
COPY test.sh /test.sh
COPY cleanup.sh /cleanup.sh
ENTRYPOINT [ "/test.sh" ]
