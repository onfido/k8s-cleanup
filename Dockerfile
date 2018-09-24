FROM alpine

ENV ETCD_VERSION 3.1.4
ENV KUBE_VERSION 1.7.8

RUN apk add --update bash curl docker \
    && rm -rf /var/cache/apk/*

RUN cd /usr/local/bin \
    && curl -O https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl \
    && chmod 755 /usr/local/bin/kubectl

RUN cd /tmp \
    && curl -OL https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \ 
    && tar zxf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
    && cp etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl \
    && rm -rf etcd-v${ETCD_VERSION}-linux-amd64* \
    && chmod +x /usr/local/bin/etcdctl

COPY docker-clean.sh k8s-clean.sh etcd-empty-dir-cleanup.sh /bin/
RUN chmod +x /bin/docker-clean.sh /bin/k8s-clean.sh /bin/etcd-empty-dir-cleanup.sh

ENV DOCKER_CLEAN_INTERVAL 1800
ENV DAYS 7

CMD ["bash", "/bin/docker-clean.sh"]
