
# About

This docker image extends the image [debian:bullseye-slim](https://hub.docker.com/_/debian) and installs some `Swiss knife` tools that are often used by installers and scripts.

The image uses [dumb-init](https://github.com/Yelp/dumb-init) as ENTRYPOINT, which overrides the default `/bin/sh -c`.

A default CMD `/srv/run.sh` is specified, a script that executes `sleep infinity`.

# Installation

Clone the latest commit from github into a local working directory

    git clone --depth 1 \
      git@github.com:hkdigital/docker-images-debian-slim-2021a.git \
      debian-slim-2021a

Build the docker image

      ./build-latest-image.sh

# Use cases

## Just test it

Run a container:

    docker run --rm debian-slim-2021a

This command will create a docker container, run the default CMD `/srv/run.sh` inside the container and remove the container when the script finishes.

By default `/srv/run.sh` will execute the command "sleep infinity", so it won't finish. Press ctrl-c to quit the script and srop and remove the container.

## Run a bash shell inside the container

Run the following command to run an interactive bash shell:

    docker run -ti --rm debian-slim-2021a bash

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
        image: hkdigital/debian-slim-2021a:latest
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
   FROM hkdigital/debian-slim-2021a:latest
   ...
```

