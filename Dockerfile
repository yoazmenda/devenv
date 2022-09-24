FROM ubuntu:latest

LABEL maintainer="Yoaz Menda yoazmenda@gmail.com"

# update apk dependencies
RUN apt-get update 
RUN apt-get upgrade -y

# install ssh server and it's dependencies
RUN apt-get install openssh-server sudo -y

# install vscode pre-requisites (see https://code.visualstudio.com/docs/remote/linux) 
RUN apt-get install bash wget curl -y

# install a new user named "test" that can later login via ssh
RUN useradd -rm -d /home/test -s /bin/bash -g root -G sudo -u 1000 test
RUN  echo 'test:password' | chpasswd

# install dev tools for c development (gcc, g++, gdb and make)
RUN apt-get install build-essential gdb -y

# install man pages for dev tools
RUN apt-get install manpages-dev -y

# create a simple C project ready to develop and debug with VSCode
RUN mkdir /home/test/hello
RUN echo "#include <stdio.h>\n\
int main() {\n\
     printf(\"Hello, World!\");\n\
     return 0;\n\
}" > /home/test/hello/hello.c 
RUN chmod 777 /home/test/hello/hello.c
RUN chmod 777 -R /home/test/hello

# start ssh server so we can connect to it from outside the container
RUN service ssh start
CMD ["/usr/sbin/sshd","-D"]
