[![Build Status](https://ci.eclipse.org/cbi/buildStatus/icon?job=jiro-agents%2Fmaster)](https://ci.eclipse.org/cbi/job/jiro-agents/job/master/)
[![GitHub license](https://img.shields.io/github/license/eclipse-cbi/jiro-agents.svg)](https://github.com/eclipse-cbi/jiro-agents/blob/master/LICENSE)

# Jiro Agents

This repo contains the dockerfiles for the following pod templates that are available on every CI instance at the Eclipse Foundation:

| Image labels | Dockerfile | Tool versions | Docker image name |
|------------|------------|---------------|-------------------|
| basic      | [Dockerfile](/basic/Dockerfile) | [README.md](/basic/README.md) | [eclipsecbi/jiro-agent-basic:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-basic) |
| basic-ubuntu* | [Dockerfile](/basic-ubuntu/Dockerfile) | [README.md](/basic-ubuntu/README.md) | [eclipsecbi/jiro-agent-basic-ubuntu:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-basic-ubuntu) |
| ubuntu-2204 | [Dockerfile](/ubuntu/Dockerfile) | [README.md](/ubuntu/README.md) | [eclipsecbi/jiro-agent-ubuntu-2204:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-ubuntu-2204) |
| ubuntu-2404, ubuntu-latest | [Dockerfile](/ubuntu/Dockerfile) | [README.md](/ubuntu/README.md) | [eclipsecbi/jiro-agent-ubuntu-2404:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-ubuntu-2404) |

* basic-ubuntu is a transitional image. The basic image will be replaced with it eventually.

## Deprecated images

The following images are no longer maintained and built.

| Image labels | Dockerfile | Tool versions | Docker image name |
|------------|------------|---------------|-------------------|
| centos-7, migration, jipp-migration | [Dockerfile](/centos-7/Dockerfile) | [README.md](/centos-7/README.md) | [eclipsecbi/jiro-agent-centos-7:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-centos-7) |
| centos-8, centos-latest   | [Dockerfile](/centos-8/Dockerfile) | [README.md](/centos-8/README.md) | [eclipsecbi/jiro-agent-centos-8:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-centos-8) |