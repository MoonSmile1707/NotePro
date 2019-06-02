# Dockerfile

<hr/>

## Dockerfile reference

Docker can build images autmatically by readung the instructions from `Dockerfile`. A `Dockerfile` is a text document that contains all the commands a user could call on the command line to assemble an image. Using `docker build` users can create an automated build that executes several command-line instructions in succession.

This page describes the commands you can use in a `Dockerfile`. When you are done reading this page, refer to the `Dockerfile` [Best Practives](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/) for a tip-oriented guide.

## Usage

The `docker build` command builds an image from a `Dockerfile` and a _context_. The build's context is the set of files at a specified location `PATH` or `URL`. The `Path` is a directory on your local filesystem. The `URL` is a Git repository location.

A context is processed recursively. So, a `PATH` includes any subdirectories and the `URL` includes the repossitory and its submodules. This example shows a build command the uses the current directory as context:

```shell
$ docker build .
Sending build context to Docker daemon  6.51 MB
...
```

The build is run by the Docker daemon, not by CLI. The first thing a build process does is send the entire context (recursively) to the daemon. In most cases, it's best to start with an empty directory as context and kepp your Dockerfile in that directory. Add only the files needed for building the Dockerfile.

The Docker daemon runs the instructions in the `Dockerfile` one-by-one, commiting the result of each instruction to a new image if necessary, before finally outputting the ID of your new image. The Docker daemon will autmatically clean up the context you sent.

Note that each instrcution is run independently, and causes a nre image to be created - so `RUN cd/tmp` will not have any effect on the next instructions.

Whenever possible, Docker will re-use the intermediate images (cache), to accerlerate the `docker build` process significantly. This is indicated by the `Using cache` message in the console output. (For more information, see the [Build cache section](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#build-cache) in the `Dockerfile` best practices guilde):

```shell
$ docker build -t svendowideit/ambassador .
Sending build context to Docker daemon 15.36 kB
Step 1/4 : FROM alpine:3.2
 ---> 31f630c65071
Step 2/4 : MAINTAINER SvenDowideit@home.org.au
 ---> Using cache
 ---> 2a1c91448f5f
Step 3/4 : RUN apk update &&      apk add socat &&        rm -r /var/cache/
 ---> Using cache
 ---> 21ed6e7fbb73
Step 4/4 : CMD env | grep _TCP= | (sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/socat -t 100000000 TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\3 \&/' && echo wait) | sh
 ---> Using cache
 ---> 7ea8aef582cc
Successfully built 7ea8aef582cc
```

Build cache is only used from images that have a blocal parent chain. This means that these images were created by previous builds or the whole chain of images was loaded with `docker load`. If you wish to use build cache of a specific image you can specify it with `--cache-from` option. Images specified with `--cache-from` do not need to have a parent cahin and may be pulled from other registries.

When you're done with your build, you're ready to look into [Pushing a repository to its registry](https://docs.docker.com/engine/tutorials/dockerrepos/#/contributing-to-docker-hub).

## BuildKit

Docker supports a new backend for executing your builds that is provided by the [moby/buildkit](https://github.com/moby/buildkit) project. The BuildKit backend provides many benefits compared to the old implementation. For example, BuildKit can:

- Detect and skip executing unused build stages.
- Parallelze building independent build stage.
- Incrementally transfer only the changed files in your build context between builds.
- Detect and skip transferring unused files in your build context.
- Use external Dockerfile implementations with many new features.
- Avoid side-effects with rest of the API(intermediate images and containers).
- Prioritize your build cache for automatic pruning

To use the BuildKit backend, you need to set an environment variable `DOCKER_BUILDKIT=1` on the CLI before invoking `docker build`.

To learn about the expermental Dockerfile syntax available to BuildKit-based builds [refer to the documentation in the BuildKit repository](https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md).

## Parser Directives

Parser directives are optional, and affect the way in whcih subsequent lines in a `Dockerfiel` are handled. Parser directives do not add layers to the build, and will not be shown as a build step. Parser directives are written as a special type of comment in the form `# directive=value`. A single directive may only be used once.

The following parser directives are supported.

- `syntax`
- `escape`

<hr/>

Get more information at [here](https://docs.docker.com/engine/reference/builder/).
