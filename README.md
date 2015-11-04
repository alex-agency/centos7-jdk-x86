alexagency/centos7-jdk-x86
==========================

**Dockerfile for X11 forwarding for Centos 7 JDK 1.8 x86, Firefox x86 and Eclipse x86**

### Installation

Install [Docker Machine](https://docs.docker.com/machine/install-machine/).

Create virtual machine:
```
docker-machine create -d virtualbox dev
```

Get IP address:
```
docker-machine ip dev
```

Connect to virtual machine:
```
docker-machine ssh dev
```

Go to shared (between host and virtualbox) home directory:
```
cd /Users/<MAC USER>
cd /c/Users/<WINDOWS USER>
```

Run **alexagency/centos7-jdk-x86** container with X11 forwarding from [Docker Hub](https://hub.docker.com/r/alexagency/centos7-jdk-x86):
```
xhost +
docker run -it --rm -e DISPLAY=`hostname --ip-address`$DISPLAY alexagency/centos7-jdk-x86 bash
firefox
eclipse
```

Credentials:

```
user: password
root: password
```

### Build

Copy sources to shared (between host and virtualbox) home directory:
```
cd /Users/<MAC USER>/Docker/centos7-jdk-x86
cd /c/Users/<WINDOWS USER>/Docker/centos7-jdk-x86
```

Build Docker Image:

```
docker build --force-rm=true -t alexagency/centos7-jdk-x86 .
```

### Useful Docker Commands 

Show list of all containers:

```
docker ps -a
```

Attach to a running container:

```
docker exec -it <CONTAINER ID> bash
```

To remove all stopeed containers:

```
docker rm $(docker ps -a -q)
```

Show list of all images:

```
docker images
```

To remove image by id:

```
docker rmi -f <IMAGE ID>
```

Delete all existing images:

```
docker rmi $(docker images -q -a)
```
