FROM php:8.3-cli

ARG MAGERUN_VERSION=8.1.1

# Install required packages
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install n98-magerun2
RUN curl --retry 3 \
        --retry-delay 5 \
        --retry-all-errors \
        --connect-timeout 30 \
        --max-time 120 \
        -sSL -O https://files.magerun.net/n98-magerun2-${MAGERUN_VERSION}.phar \
    && curl --retry 3 \
        --retry-delay 5 \
        --retry-all-errors \
        --connect-timeout 30 \
        --max-time 120 \
        -sSL -o n98-magerun2-${MAGERUN_VERSION}.phar.sha256 https://files.magerun.net/sha256.php?file=n98-magerun2-${MAGERUN_VERSION}.phar \
    && sha256sum -c n98-magerun2-${MAGERUN_VERSION}.phar.sha256 \
    && mv n98-magerun2-${MAGERUN_VERSION}.phar /usr/local/bin/n98-magerun2 \
    && chmod +x /usr/local/bin/n98-magerun2

WORKDIR /var/www/html

ENTRYPOINT ["n98-magerun2"]
CMD ["--version"]
