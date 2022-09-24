# C Linux Development Environment

setup for developing and debugging a C applications in Linux (using docker container) using VSCode  

## pre-requisites:
* Docker
* VSCode
* VSCode remote-ssh extension (Microsoft)
* VSCode C/C++ extension (Microsoft)

# usage

### (1) build the image
docker build . -t dev

### (2) run container from image and make available for ssh client
docker run -d -p 22:22 dev

### (3) vscode connect to container via SSH
VSCode > Remote-Ssh: Connect to Host...
enter password "password"

### (4) setup directory as workspace in newly created vscode
VSCode > Workspaces: Add Folder as Workspace select 'hello' directory

### (5) run or debug
remote VSCode > C/C++: run file

