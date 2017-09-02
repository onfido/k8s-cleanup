FROM alpine:3.6

RUN apk add --update bash curl docker \
    && rm -rf /var/cache/apk/*

RUN cd /usr/local/bin \
    && curl -O https://storage.googleapis.com/kubernetes-release/release/v1.6.2/bin/linux/amd64/kubectl \
    && chmod 755 /usr/local/bin/kubectl

COPY docker-clean.sh k8s-clean.sh /bin/
RUN chmod +x /bin/docker-clean.sh && chmod +x /bin/k8s-clean.sh

ENV DOCKER_CLEAN_INTERVAL 1800
ENV DAYS 7

CMD ["bash", "/bin/docker-clean.sh"]
