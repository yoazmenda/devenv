# use alpine since it's small and cool
FROM ubuntu:latest

LABEL maintainer="Yoaz Menda yoazmenda@gmail.com"

# update apk dependencies
RUN apt-get update 
RUN apt-get upgrade -y

# install ssh server and dependencies
RUN apt-get install openssh-server sudo -y

# install vscode pre-requisites (see https://code.visualstudio.com/docs/remote/linux) 
RUN apt-get install bash wget curl -y

# install the user
RUN useradd -rm -d /home/yoaz -s /bin/bash -g root -G sudo -u 1000 yoaz
RUN  echo 'yoaz:password' | chpasswd


# install dev tools for c development (gcc, g++ and make)
RUN apt-get install build-essential gdb -y

# install man pages for dev tools
RUN apt-get install manpages-dev -y

# create a simple C project ready to develop and debug with VSCode
RUN mkdir /home/yoaz/hello
RUN echo "#include <stdio.h>\n\
int main() {\n\
     printf(\"Hello, World!\");\n\
     return 0;\n\
}" > /home/yoaz/hello/hello.c 
RUN chmod 777 /home/yoaz/hello/hello.c
RUN chmod 777 -R /home/yoaz/hello


RUN service ssh start

CMD ["/usr/sbin/sshd","-D"]
