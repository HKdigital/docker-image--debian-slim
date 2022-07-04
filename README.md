
# About

This docker image extends the image [debian:bullseye-slim](https://hub.docker.com/_/debian).

Some useful basic tools are installed that are often used by installers and scripts. This image is not intended to be the smallest debian base image, 
but as a useful image for development, testing and most common production environments.

The image uses [dumb-init](https://github.com/Yelp/dumb-init) as ENTRYPOINT, which overrides the default `/bin/sh -c`.

A default CMD `/srv/run.sh` is specified, a script that executes `sleep infinity`.

## Versioning

The folder and repository names have a year and a letter appended to their names. The idea is that there will be no breaking changes when the same year and letter combination are used.

# Usage

## Just try it out

Run a container:

```bash
docker run --rm hkdigital/debian-slim
```

This command will create a docker container, run the default CMD `/srv/run.sh` inside the container and remove the container when the script finishes.

By default `/srv/run.sh` will execute the command "sleep infinity", so it won't finish. Press ctrl-c to quit the script and to stop and remove the container.

## Run a bash shell inside the container

Run the following command to run an interactive bash shell:

```bash
docker run -ti --rm hkdigital/debian-slim bash
```

A bash shell opens and you're free to do whatever you want. To exit the bash shell, type `exit`. Note that the container will be removed when the bash shell exits. Configuration or installed programs in the container will be lost.

Note that the script `run-tmp-bash-container.sh`, which is included in this project, do nothing more than the command shown above.

### Run using docker-compose

Below an example is shown of how the image can be used in a docker-compose file. The image will be downloaded from [Docker Hub](https://https://hub.docker.com).

Note that the container will execute the default CMD. The default CMD executes `sleep infinity`, so the container will not terminate until you stop the container or press ctrl-c to stop the script.

docker-compose.yaml
```yaml
version: "3.9"

services:
  debian:
    image: hkdigital/debian-slim
```

Open two terminals and go to the directory where the `docker-compose.yaml` file resides.

In the first terminal start the container:

```bash
docker-compose up
```

Use the second terminal to stop and remove the container:

```bash
docker-compose stop
docker-compose rm
```

### Run bash in an existing and running container (docker-compose)

Use the following command to execute `bash` inside a running container (e.g. started like in the use-case above)

```bash
docker-compose exec debian bash
```

Type `exit` to quit.

### Extend the image

Specify the name of this image in the FROM command of your Dockerfile.

```
FROM hkdigital/debian-slim
...
```

#### Tag your image and push the image to docker hub

This is a generic instruction to push your images to `docker hub`. You must setup a (free) docker hub account and create the repository.

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
