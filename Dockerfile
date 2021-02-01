FROM ethersphere/bee:0.4.2

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
        bash \
        iproute2; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
