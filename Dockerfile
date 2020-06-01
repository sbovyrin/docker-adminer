FROM alpine:3.11

LABEL author="Sergey Bovyrin <s.bovyrin@icloud.com>" \
  vesion="1.2.0" \
  description="Lightweight docker image based on Alpine to run pumped adminer." \
  exposed_port="9000" \
  workdir="/opt" \
  default_adminer_version="4.7.7" \
  default_php_membory_limit="256M" \
  default_php_post_max_size="64M"

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
  && mkdir -p /opt/plugins \
  && curl -L -o /opt/adminer.php https://github.com/vrana/adminer/releases/download/v${VERSION}/adminer-${VERSION}-en.php \
  && curl -o /opt/plugins/plugin.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php \
  && curl -o /opt/plugins/readable-dates.php https://gist.githubusercontent.com/scr4bble/9ee4a9f1405ffc1465f59e03768e2768/raw/241efb913859575c2b178011c8fdbc4081b94feb/readable-dates.php \
  && curl -o /opt/plugins/version-noverify.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/version-noverify.php \
  && curl -o /opt/plugins/tables-filter.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/tables-filter.php \
  && curl -o /opt/plugins/sql-log.php https://raw.githubusercontent.com/vrana/adminer/master/plugins/sql-log.php \
  && apk del curl \
  && echo "upload_max_filesize = ${POST_MAX_SIZE}" >> /etc/php7/php.ini \
  && echo "post_max_size = ${POST_MAX_SIZE}" >> /etc/php7/php.ini \
  && echo "memory_limit = ${MEMORY_LIMIT}" >> /etc/php7/php.ini

WORKDIR /opt

COPY ./adminer.css /opt
COPY ./index.php /opt

EXPOSE 9000

ENTRYPOINT ["php", "-S", "0.0.0.0:9000", "-t", "/opt"]
