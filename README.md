# Pantheon GoAccess

## Overview
This is intended to provide a Docker image for analyzing Pantheon site logs.

## Setup
- Make sure you have Docker setup - 
### Building from the Dockerfile
- From the directory you have cloned this repo, run `docker build .`. The output should give you the hash for the container, e.g.:
```
Successfully built bcb1f2ee6470
```
- Using that hash, start the container with `docker run -t -d [hash from previous step]`, which should output the running container hash. Following our previous example:
```
➜  docker run -t -d bcb1f2ee6470
0dc448cf71d181a68312659d92a20bfe1b17aa067a3930e043a234ad995b7487
```


### Usage
- Access the Docker container via shell, e.g.:
```
➜ docker exec -it 0dc448cf71d181a68312659d9 bash
root@0dc448cf71d1:/#
```
From here on out, you can run all your commands from within the container.
- Now authenticate with terminus and a machine token (Reference to this process [here](https://pantheon.io/docs/machine-tokens)):
```
terminus auth:login --machine-token=[MACHINE_TOKEN]
```
- OPTIONAL: Setup an ssh-key and add it to your account via terminus:
```
ssh-keygen
(follow the prompts and generate, id_rsa.pub is default)
terminus ssh:add ~/.ssh/id_rsa.pub
```
If you don't do this step, you'll need to use the password for your account when accessing the logs via the terminus get-logs plugin.

- Grab the logs via the terminus-get-logs plugin:
```
terminus get-logs [your site name].[environment (dev, test, live, or multidev env)]
```
So if your site is called "foobar", and you want the "dev" environment logs:
```
terminus get-logs foobar.dev
```
The logs should be inside a folder with site name, environment, and then IP of server.
- Analyze logs via GoAccess, e.g. for the log file `nginx-access.log` in current directory:
```
goaccess -p /usr/local/etc/goaccess/goaccess.conf nginx-access.log
```

