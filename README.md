# docker-meteor-build
Container that can be used to build meteor apps.

## Examples

Build an app by volume mounting its source folder into `/app` in the container. By default the built copy is placed in the `dist` folder under the source location.

In the following example, /home/ubuntu/my-meteor-app/dist will contain the built version of the app
```
docker run --rm -v /home/ubuntu/my-meteor-app:/app meteor-build:1.3
```

Override the container's source folder by specifying a SRC_DIR environment variable.
```
docker run --rm -v /home/ubuntu/my-meteor-app:/src --env "SRC_DIR=/src" meteor-build:1.3
```

Override the container's distribution folder by specifying a DIST_DIR environment variable.
```
docker run --rm -v /home/ubuntu/my-meteor-app:/app -v /tmp/my-built-app:/dist --env "DIST_DIR=/dist" meteor-build:1.3
```
