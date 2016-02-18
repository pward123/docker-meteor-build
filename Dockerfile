#
# Docker container that can be used to build meteor apps
# i.e. docker run --rm -v /home/ubuntu/my-meteor-app:/app meteor-build
#
# When the above container terminates, the bundle will be located in /home/ubuntu/my-meteor-app/dist
#
FROM       node:0.10.41
MAINTAINER Paul Ward <pward123@gmail.com>
RUN        curl https://install.meteor.com/ | sh

RUN        echo "alias ll='ls -al'" | tee ~/.bashrc

# Running help downloads some initial libraries
RUN        /usr/local/bin/meteor help

# Add the dockerstart file
ADD        Dockerstart /opt/Dockerstart

# Default to building the app
WORKDIR    /app
ENTRYPOINT ["/opt/Dockerstart"]
