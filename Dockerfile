FROM alpine:3.13

LABEL author="Sergey Bovyrin <sbovyrin@gmail.com>" \
      description="Lightweight docker image based on Alpine for adminer." \

ARG VERSION="4.7.7"
ARG MEMORY_LIMIT="256M"
ARG POST_MAX_SIZE="64M"

RUN apk --no-cache add \
    curl \
    php7 \
    php7-session \
    php7-pdo \
    php7-pgsql \
    php7-pdo_pgsql \
    php7-sqlite3 \
    php7-pdo_sqlite \
    php7-pdo_mysql \
  && mkdir -p /var/www/plugins \
  && curl -L -o /var/www/adminer.php https://github.com/vrana/adminer/releases/download/v${VERSION}/adminer-${VERSION}-en.php \
  && curl -L -o /var/www/adminer.css https://raw.githubusercontent.com/pappu687/adminer-theme/master/adminer.css \
  && curl -o /var/www/plugins/plugin.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php \
  && curl -o /var/www/plugins/readable-dates.php https://gist.githubusercontent.com/scr4bble/9ee4a9f1405ffc1465f59e03768e2768/raw/241efb913859575c2b178011c8fdbc4081b94feb/readable-dates.php \
  && curl -o /var/www/plugins/version-noverify.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/version-noverify.php \
  && curl -o /var/www/plugins/tables-filter.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/tables-filter.php \
  && curl -o /var/www/plugins/sql-log.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/sql-log.php \
  && apk del curl \
  && echo "upload_max_filesize = ${POST_MAX_SIZE}" >> /etc/php7/php.ini \
  && echo "post_max_size = ${POST_MAX_SIZE}" >> /etc/php7/php.ini \
  && echo "memory_limit = ${MEMORY_LIMIT}" >> /etc/php7/php.ini

WORKDIR /var/www

COPY ./index.php /var/www

EXPOSE 9000

ENTRYPOINT ["php", "-S", "0.0.0.0:9000", "-t", "/var/www"]
