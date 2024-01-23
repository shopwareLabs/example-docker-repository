#syntax=docker/dockerfile:1.4

# pin versions
FROM shopware/docker-base:8.3 as base-image
FROM ghcr.io/friendsofshopware/shopware-cli:latest-php-8.3 as shopware-cli

# build

FROM shopware-cli as build

ADD . /src
WORKDIR /src

RUN /usr/local/bin/entrypoint.sh shopware-cli project ci /src

# build final image

FROM base-image

COPY --from=build --chown=82 --link /src /var/www/html
