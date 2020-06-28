FROM quay.io/net-sec/alpine:latest
LABEL maintainer "Steven Iveson <steve@iveson.eu>"
LABEL source "https://github.com/net-sec/docker-nfs-server"
LABEL branch "master"

RUN apk add --no-cache --update --verbose nfs-utils bash iproute2 drbd-utils-pacemaker && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY exports /etc/
COPY nfsd.sh /usr/bin/nfsd.sh
COPY .bashrc /root/.bashrc

RUN chmod +x /usr/bin/nfsd.sh

ENTRYPOINT ["/usr/bin/nfsd.sh"]
