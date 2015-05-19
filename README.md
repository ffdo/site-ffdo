# site-ffdo
FF Dortmund (FFDO) specific Gluon configuration

## Using the Dockerfile

See https://docs.docker.com/installation/#installation on how to get Docker.

```
docker build -t ffdobuild .
docker run ffdobuild
```
After a successful build you can remove the used container. Use `docker ps -a` to find the container ID and `docker rm <container>` to remove the container. Use `docker rmi ffdobuild` to remove the image used to create the container.
