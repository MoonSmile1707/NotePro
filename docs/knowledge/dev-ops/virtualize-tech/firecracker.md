# FireCracker

<hr/>

## What is Firecracker?

Firecracker is an open source virtualizatin technology that is purpose-built for creating and managing secure, multi-tenant container and function-based services that provide serverless operational medels. Firecracker runs workloads in lightweight virtual machines, called microVMs, which combine the security and isolation properties provided by hardwae virtualization technology with the speed and flexibily of containers.

The main component of Firecracker is a virtual machine monitor (VMM) that uses the Linux Kernel Virtual Machine(KVM) to create and run microVMs. Firecracker has a minimalist design. It excludes unnecessary devices and guest-facing functionality to reduce the memory footprint and attack surfac area of each microVM. This improves security, decreases the startup time and increases hardware utilization. Firecracker currently supports Intel CPUs, with planned AMD and Arm support. Firecracker will also be integrated with popular container runtimes.

## Getting Started

To get started with Firecracker, download the latest [release](https://github.com/firecracker-microvm/firecracker/releases) binaries or build it from source.

You can build Firecracker on any system that has Docker running(we use a development container) as follows:

```bash
git clone https://github.com/firecracker-microvm/firecracker
cd firecracker
tools/devtool build
```

The Firecracker binary will be placed at `build/debug/firecracker`. For more information on building, testing and running Firecracker, go to the [quickstart guide](https://github.com/firecracker-microvm/firecracker/blob/master/docs/getting-started.md).

The overall security of Firecracker microVMs, including the ability to meet the criteria for safe multi-tenant computing, depends on a well configured Linux host operating system. A configuration that we believe meets this bar is included in [the production host setup document](https://github.com/firecracker-microvm/firecracker/blob/master/docs/prod-host-setup.md).

<hr/>

Get more information at [here](https://firecracker-microvm.github.io/).
