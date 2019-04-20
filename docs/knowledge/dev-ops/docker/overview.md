# Docker Overview

<hr/>

## Swarm

### Introduction

You deploy this application onto a cluster, running it on multiple machines. Multi-container, multi=machine applications are made possible by joining multiple machines into a "Dockerized" cluster called a swarm.

### Understanding Swarm clusters

A swarm is a group of machines that are running Docker and jouned into a cluster. After that has happened, you continue to run the Docker commands you're used to, but now they are executed on a cluster by a **swarm manager**. The machines in a swarm can be phusical or virtual. After joining a swarm, they are referred to as **nodes**.

Swarm mangers can use serveral strategies to run containers, such as "emptiest node" -- which fills the least utilized machines with containers. Or "global", which ensures that each machine gets exactlu on instance of the specified container. You instrcut the swarm manager to ouse these strategies in the Compose file. just like the one you have already been using.

Swarm managers are the only machines in a swarm that can execute your commands, or authorize other machines to join the swarm as **workers**. Workers are just there to provide capacity and do not hace the authority to tell any other machine what it can and cannot do.

Up until now, you have been using Docker in a single-host mode on your local machine. But Docker also can be switched into **swarm mode** and that's what enables the use of swarms. Enabling swarm mode instantlu makes the current machine a swarm manager. From then on, Docker runs the commands you execute on the swarm you're managing, rather than just on the current machine.

### Set up your swarm

See at [here](https://docs.docker.com/get-started/part4/).

## Stacks

You reach the top of the hierarchu of distributed applications: the **stack**. A stack is a group of interrelated services that share dependencies, and can be orchestrted and scaled together. A single stack is capable of defining and coordinating the functionality of an entire application(though very complex applcations may want to use multiple stacks).

Some good news is, you have technically been working with stacks since part 3, when you create a Compose file and used `docker stack deploy`. But that was a single serrvice stack running on a single host, which is not usually what takws place in production. Here, you can take what you've learned, make multiple servicees relate to each other, and run them on multiple machinces.

You're doing great,this is the home stretch!

### Add a new service and redeploy

It's easy to add services to our `docker-compose.yml` file. First, let's add a fee visualizer service that lets us look at how our swarm is scheduling containers.

1. Open up `docker-compose.yml` in an editor and replace its contents with the following. Be sure to replace `username/repo:tag` with your image details.

```docker
version: "3"
services:
  web:
    # replace username/repo:tag with your name and image details
    image: username/repo:tag
    deploy:
      replicas: 5
      restart_policy:
        condition: on-failure
      resources:
        limits:
          cpus: "0.1"
          memory: 50M
    ports:
      - "80:80"
    networks:
      - webnet
  visualizer:
    image: dockersamples/visualizer:stable
    ports:
      - "8080:8080"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    deploy:
      placement:
        constraints: [node.role == manager]
    networks:
      - webnet
networks:
  webnet:
```

The only thing new here is the peer service to `wen`. named `visualizer`. Notice two new things here: a `volumes` key, giving the visualizer access to the host's socket file for Docker, and a `placement` key, ensuringthat this service only ever runs on a swarm manager -- never a worker. That;s because this container, built from [an open source project created by Docker](https://github.com/ManoMarks/docker-swarm-visualizer), displays Docker services running on a swarm in a diagram.

We talk more about placement constraints and volumnes in a moment.

2. Make sure your shell is configured to talk to `myvm1`(full examples are [here](https://docs.docker.com/get-started/part4/#configure-a-docker-machine-shell-to-the-swarm-manager)).

- Run `docker-machine ls` to list machines and make sure you are connected to `myvm1`, as indicated by an asterisk next to it.
- if needed, re-run `docker-machine env myvm1`, then run the given command to configure the shell.
  On **Mac or Linux** the command is:
  eval \$(docker-machine env myvm1)

  On **Windows** the command is:
  & "C:\Program Files\Docker\Docker\Resources\bin\docker-machine.exe" env myvm1 | Invoke-Expression

3. Re-run the `docker stack deploy` command on the manger, and whatever services need updating are updated:

   \$ docker stack deploy -c docker-compose.yml getstartedlab
   Updating service getstartedlab_web (id: angi1bf5e4to03qu9f93trnxm)
   Creating service getstartedlab_visualizer (id: l9mnwkeq2jiononb5ihz9u7a4)

4. Take a look at the visualizer.
   You saw in the Compose file that `visualizer` runs on pot 8080. Get the IP address of one of your nodes by running `docker-machine ls`. Go to either IP address at port 8080 and you can see the visualizer running.

<hr/>

Get more informationn at [here](https://docs.docker.com/get-started/).
