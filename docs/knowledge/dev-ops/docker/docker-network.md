# Docker Network

<hr/>

## Overview

One of the reasons Docker containers and services are so powerful is that you can connect them together, or connect them to non-Docker workloads. Docker containers and services do not even need to be aware that they are developed on Docker, or whether their peers are also Docker woekloads or not. Whether your Docker hosts run Linux, Windows, or a mix of the two, you can use Docker to run manage them in a platform-agnostic way.

This topic defines some basic Docker networking concepts and prepares you to design and deploy your applications to take full advantage of these capabilities.

Most of this content applies to all Docker installations. However, [a few advanced features](https://docs.docker.com/network/#docker-ee-networking-features) are only available to Docker EE customers.

## Network drivers

Docker's networking subsystem is pluggable, using drivers. Several drivers exist by default, and provide core networking functionality:

- `bridge`: The default network driver. If you don't specify a driver, this is the type of network you are creating. **Bridge network are usually used when your applications run in standalone containers that need to communicate**. See [bridge networks](https://docs.docker.com/network/bridge/).
- `host`: For standalone containers, remove network isolation between the container and the Docker host and use the host's network directly. `host` is only available for swarm services on Docker 17.06 and higher. See [use the host network](https://docs.docker.com/network/host/).
- `overlay`: Overlay network connect multiple Docker daemons together and enable swarm services to communicate with each other. You can also use overlay networks to facilitate communication between a swarm service and a standalone container, or between two standalone containers on different Docker daemons. this strategy removes the need to do OS-level routing between these containers. See [overlay networks](https://docs.docker.com/network/overlay/).
- `macvlan`: Macvlan networks allow you to assign a MAC address to a container, making it appear as a physical device on your network. The Docker daemon routes trffic to containers by their MAC addresses. Using the `macvlan` driver is sometimes the best choice when dealing with legacy applications that expect to be directly connected to the physical network, rather than routed through the Docker host's network stack. See [Macvlan networks](https://docs.docker.com/network/macvlan/).
- `none`: For this container, disable all networking. Usually used in conjunction with a custom network driver.`none` is not available for swarm services. See [disable container networking](https://docs.docker.com/network/none/).
- [Network plugins](https://docs.docker.com/engine/extend/plugins_services/): You can install and use third-party network plugings with Docker. These plugins are available from [Docker Hub](https://hub.docker.com/search?category=network&q=&type=plugin) or from third-party vendors. See the vendor's documentation for installing and using a given network plugin.

## Network driver summary

- **User-defined brigde networks** are best when you need multiple containers to communicate on the same Docker host.
- **Host networks** are best when the network stack should not be isolated from the Docker host, but you want other aspects of the container to be isolated.
- **Overlay networks** are best when you need containers running on different Docker hosts to communicate, or whrn multiple applications work together using swarm services.
- **Macvlan networks** are best when you are migrating from a VM setup or need your containers to look like physical hosts on your network, each with a unique MAC address.
- **Third-party network plugins** allow you to integrate Docker with specialized network stacks.

## Docker EE networking features

The following two features are only possible when using Docker EE and managing your Docker services using Univeral Control Plane(UCP):

- The [HTTP rouing mesh](https://docs.docker.com/datacenter/ucp/2.2/guides/admin/configure/use-domain-names-to-access-services/) allows you to share the same network IP address and port among multiple services. UCP routes the traffic to the appropriate service using the combination of hostname and port, as requested from the client.
- [Session stickness](https://docs.docker.com/datacenter/ucp/2.2/guides/user/services/use-domain-names-to-access-services/#sticky-sessions) allows you to specify information in the HTTP header which UCP uses to route subsequent requests to the same service task, for applications which require stateful sessions.

## Networking tutorials

Now that you understand the basics about Docker network, deepen your understanding using the following tutorials:

- [Standalone networking tutorial](https://docs.docker.com/network/network-tutorial-standalone/)
- [Host networking tutorial](https://docs.docker.com/network/network-tutorial-host/)
- [Overlay networking tutorial](https://docs.docker.com/network/network-tutorial-overlay/)
- [Macvlan networking tutorial](https://docs.docker.com/network/network-tutorial-overlay/)


<hr/>

Get more information at [here](https://docs.docker.com/network/).