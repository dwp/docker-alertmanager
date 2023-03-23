FROM alpine:3.16

ARG ALERTMANAGER_VERSION=0.21.0

RUN apk add --update --no-cache \
    curl \
    aws-cli

COPY entrypoint.sh /bin/entrypoint.sh

RUN curl -k -LSs --output /tmp/alertmanager.tar.gz \
    https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz && \
    tar -C /tmp --strip-components=1 -zoxf /tmp/alertmanager.tar.gz && \
    mv /tmp/alertmanager /bin/ && \
    mkdir -p /etc/alertmanager/template && \
    mkdir -p /alertmanager && \
    rm -f /tmp/* && \
    chmod 0755 /bin/entrypoint.sh && \
    chown -R nobody:nogroup /etc/alertmanager /alertmanager

EXPOSE     9093
ENTRYPOINT [ "/bin/entrypoint.sh" ]
