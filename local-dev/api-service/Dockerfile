FROM node:22-bullseye as node
FROM composer:2.8.5 as composer
FROM php:8.4-bullseye

WORKDIR /app/api-service

# composerのコピー
COPY --from=composer /usr/bin/composer /usr/bin/composer

# nodeのコピー
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# packageのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git libicu-dev libonig-dev libzip-dev unzip locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD /bin/sh -c "npm install && npm run build && composer install && php artisan serve --host=0.0.0.0"