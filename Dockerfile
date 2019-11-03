FROM alpine:latest
RUN apk --update add postgresql-client curl && rm -rf /var/cache/apk/*
RUN addgroup -S pg && adduser -S pg -G pg  --uid 1000
USER pg
COPY postgres/test.sh /test.sh
COPY postgres/cleanup.sh /cleanup.sh
ENTRYPOINT [ "/test.sh" ]
