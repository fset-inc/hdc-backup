FROM curlimages/curl:7.86.0 as curl

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

FROM bitnami/kubectl:1.24.8

COPY --from=curl /home/curluser/awscliv2.zip /awscliv2.zip

RUN unzip awscliv2.zip \
    && ./aws/install

COPY ./run-backup.sh /run-backup.sh

CMD ["bash", "-c", "./run-backup.sh"]

