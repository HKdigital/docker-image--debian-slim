
# About

This docker image extends the image [debian:bullseye-slim](https://hub.docker.com/_/debian).

Some useful basic tools are installed that are often used by installers and scripts. This image is not intended to be the smallest debian base image, 
but as a useful image for development, testing and most common production environments.

The image uses [dumb-init](https://github.com/Yelp/dumb-init) as ENTRYPOINT, which overrides the default `/bin/sh -c`.

A default CMD `/srv/run.sh` is specified, a script that executes `sleep infinity`.

# Usage

## Start using "docker run"

### Run "sleep infinity" inside the container

Run a container:

```bash
docker run --rm hkdigital/debian-slim
```

This command will create a docker container, run the default CMD `/srv/run.sh` inside the container and remove the container when the script finishes.

By default `/srv/run.sh` will execute the command "sleep infinity", so it won't finish. Press ctrl-c to quit the script and to stop and remove the container.

### Run a bash shell inside the container

Run the following command to run an interactive bash shell:

```bash
docker run -ti --rm hkdigital/debian-slim bash
```

A bash shell opens and you're free to do whatever you want. To exit the bash shell, type `exit`. Note that the container will be removed when the bash shell exits. Configuration or installed programs in the container will be lost.

Note that the script `run-tmp-bash-container.sh`, which is included in this project, do nothing more than the command shown above.

### Run using "docker-compose"

Below an example is shown of how the image can be used in a docker-compose file. The image will be downloaded from [Docker Hub](https://https://hub.docker.com).

Note that the container will execute the default CMD. The default CMD executes `sleep infinity`, so the container will not terminate until you stop the container or press ctrl-c to stop the script.

docker-compose.yml
```yaml
version: "3.9"

services:
  debian:
    image: hkdigital/debian-slim
```

Open two terminals and go to the directory where the `docker-compose.yml` file resides.

In the first terminal start the container:

```bash
docker-compose up
```

Use the second terminal to stop and remove the container:

```bash
docker-compose stop
docker-compose rm
```

#### Run bash in an existing and running container (docker-compose)

Use the following command to execute `bash` inside a running container (e.g. started like explained above).

You can use this when you need a disposable linux environment to try things out.

```bash
docker-compose exec debian bash
```

Type `exit` to quit.

#### Environment variables from file

The `run.sh` command calls a script `expand-file-environment-vars.sh`. This script detects environment variables the end with `_FILE` and than reads the contents of the file specified by that variable into a new environment variable.

e.g. when defining in the docker-compose (stack) yaml file

```yml
service:
  my_service:
    environment:
      SECRET_FILE: /run/secrets/SECRET
```

The environment variable SECRET will be set that contains the contents of the file at `/run/secrets/SECRET`.

##### Docker Swarm Secrets

The main reason why the environment `_FILE` variables are supported is for Docker Swarm.

When creating your own image, call the `./expand-file-environment-vars.sh` from your `run.sh`. This way, the contents of Docker Secrets files will be loaded into environment variables.

The `_FILE` appendix is not a Docker standard, but generally accepted as a good approach.

A complete Docke Swarm stack example:

```yml
version: '3.9'  # use a modern version, otherwise secrets won't work

secrets:
  SECRET:
    external: true

service:
  my_service:
    secrets:
      - SECRET

    environment:
      SECRET_FILE: /run/secrets/SECRET
```

### Extend the image

Specify the name of this image in the FROM command of your Dockerfile.

```
FROM hkdigital/debian-slim
...
```

#### Tag your image and push the image to docker hub

If your image is ready, you might want to publish it, so it can be downloaded from a central location, for example [Docker Hub](https://hub.docker.com/).

To publish the image, you need two commands: `docker tag` and `docker push`.

If you want to push to Docker hub, you must setup a (free) docker hub account and create the repository first.

```bash
docker tag <existing-image> <hub-user>/<repo-name>[:<tag>]
docker push <hub-user>/<repo-name>:<tag>
```

e.g.

```bash
docker tag acme-foo-image acme/foo-image
docker push acme/foo-image
```

See also [Docker hub repositories](https://docs.docker.com/docker-hub/repos/)

If you're a paying user of Docker Hub, you can also publish images automatically from e.g. a GitHub or BitBucket repository.

# Build locally

If you just want to use the image to create a container, there is no need to build the image locally. You can use the image from docker-hub.

Building the image locally is usually done for development of the image itself.

## Get a working copy from the repository

Clone the latest commit from github into a local working directory.

```bash
git clone --depth 1 \
  git@github.com:hkdigital/docker-images--debian-slim.git \
  hkdigital-debian-slim
```

## Build the docker image

```bash
./build-latest-image.sh
docker image ls
# Shows hkdigital-debian-slim
```
