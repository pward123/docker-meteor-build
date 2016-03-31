#
# Docker container that can be used to build meteor apps
# i.e. docker run --rm -v /home/ubuntu/my-meteor-app:~/app meteor-build
#
# When the above container terminates, the bundle will be located in /home/ubuntu/my-meteor-app/dist
#
FROM       node:0.10.43
MAINTAINER Paul Ward <pward123@gmail.com>

# Running 'meteor build' as root has major issues, so lets create a user
# See https://github.com/meteor/meteor/issues/4566
RUN        useradd -g root -ms /bin/bash ubuntu
USER       ubuntu
WORKDIR    /home/ubuntu

# Add an alias for 'll'
RUN        echo "alias ll='ls -al'" | tee ~/.bashrc

# Install meteor
RUN        curl https://install.meteor.com/ | sh

# Make sure that docker build installs the meteor versions we're using
RUN        ~/.meteor/meteor create --release METEOR@1.3 /tmp/testapp
RUN        rm -rf /tmp/testapp

# Add the dockerstart file
ADD        Dockerstart /home/ubuntu/Dockerstart

# Default to building the app
WORKDIR    /app
ENTRYPOINT ["/home/ubuntu/Dockerstart"]
