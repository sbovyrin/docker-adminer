# Adminer

Lightweight docker image based on Alpine to run adminer.

- Size: 15.5MB
- Exposed port: 9000

## About `adminer`
Adminer is a full-featured database management tool written in PHP.

> Supports MySQL, MariaDB, MongoDB

## Usage

### Pull image
```
docker pull sbovyrin/adminer
```

### Run
```
docker run --name adminer -p <your_port>:9000 -d sbovyrin/adminer
```

### Result
Open `localhost:<your_port>` in your browser

- `<your_port>`: any free port of your system


## Customize points

- `--build-arg VERSION` to define adminer version
- `--build-arg MEMORY_LIMIT` to define memory_limit for php.ini
- `--build-arg POST_MAX_SIZE` to define post_max_size and upload_max_filesize for php.ini


## Issues
If you find a bug, please file an issue on [my issue tracker on GitHub](https://github.com/sbovyrin/docker_images/issues).