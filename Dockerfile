FROM ghcr.io/kanisterio/mysql-sidecar:0.84.0

COPY ./kubernetes.repo /etc/yum.repos.d/kubernetes.repo

RUN microdnf update && microdnf install -y ca-certificates curl dirmngr gpg unzip yum \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" --keepalive-time 2 \
    && unzip awscliv2.zip \
    && ./aws/install \
    && yum install -y kubectl
