FROM debian:stable-slim

RUN apt-get update && apt install -y ca-certificates curl gpg unzip \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y kubectl \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" --keepalive-time 2 \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf /var/lib/apt/lists/*

COPY ./run-backup.sh /run-backup.sh

CMD ["bash", "-c", "./run-backup.sh"]
