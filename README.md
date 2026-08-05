[![GitHub license](https://img.shields.io/github/license/eclipse-cbi/jiro-agents.svg)](https://github.com/eclipse-cbi/jiro-agents/blob/master/LICENSE)

# Jiro Agents

This repo contains the dockerfiles for the following pod templates that are available on every CI instance at the Eclipse Foundation:

| Image labels | Dockerfile | Tool versions | Docker image name |
|------------|------------|---------------|-------------------|
| basic-ubuntu | [Dockerfile](/basic-ubuntu/Dockerfile) | [README.md](/basic-ubuntu/README.md) | [eclipsecbi/jiro-agent-basic-ubuntu:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-basic-ubuntu) |
| ubuntu-2204 | [Dockerfile](/ubuntu/Dockerfile) | [README.md](/ubuntu/README.md) | [eclipsecbi/jiro-agent-ubuntu-2204:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-ubuntu-2204) |
| ubuntu-2404, ubuntu-latest | [Dockerfile](/ubuntu/Dockerfile) | [README.md](/ubuntu/README.md) | [eclipsecbi/jiro-agent-ubuntu-2404:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-ubuntu-2404) |
| ubuntu-2604 | [Dockerfile](/ubuntu/Dockerfile) | [README.md](/ubuntu/README.md) | [eclipsecbi/jiro-agent-ubuntu-2604:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-ubuntu-2604) |

## Deprecated images

The following images are no longer maintained and built.

| Image labels | Docker image name |
|------------|------------|---------------|-------------------|
| basic      | [eclipsecbi/jiro-agent-basic:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-basic) |
| centos-7, migration, jipp-migration | [eclipsecbi/jiro-agent-centos-7:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-centos-7) |
| centos-8, centos-latest   | [eclipsecbi/jiro-agent-centos-8:latest](https://hub.docker.com/r/eclipsecbi/jiro-agent-centos-8) |