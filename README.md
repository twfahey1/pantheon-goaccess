# Pantheon GoAccess

## Overview
This is intended to provide a Docker image for analyzing Pantheon site logs.

## Setup
- Make sure you have Docker setup - https://docs.docker.com/get-docker/
### Building from image
- With Docker setup, you can quickly get the image pulled, and started for use. Once you `docker run`, you'll get a hash for the newly started container. Using just the beginning 10 or so characters from this hash is enough to identify it, and you can get into the command line with `docker exec`, as shown here in an example:
```
➜ docker run -t -d twfahey1/pantheon-goaccess
Unable to find image 'twfahey1/pantheon-goaccess:latest' locally
latest: Pulling from twfahey1/pantheon-goaccess
e92ed755c008: Already exists
[Removed other output for brevity]
30158b6b455e: Pull complete
Digest: sha256:4c4dc92daf5e87d1b4e21969f18809afea494fcf5553e506d311ed9ca60b9591
Status: Downloaded newer image for twfahey1/pantheon-goaccess:latest
0a150b2310f8c8b64b17cb47bb459cf9e31b2c4c76626bee83a63ff1b668a1ea
➜ docker exec -it 0a150b2310f8c8b64b17 bash
root@0a150b2310f8:/# terminus
Terminus 2.3.0
```
If you've gotten this far, you should be able to go to the "Usage" section below for specifics on getting the logs and analyzing them.
### Building from the Dockerfile source for development
- From the directory you have cloned this repo, run `docker build .`. The output should give you the hash for the container, e.g.:
```
Successfully built bcb1f2ee6470
```
- Using that hash, start the container with `docker run -t -d [hash from previous step]`, which should output the running container hash. Following our previous example:
```
➜  docker run -t -d bcb1f2ee6470
0dc448cf71d181a68312659d92a20bfe1b17aa067a3930e043a234ad995b7487
```
- Access the Docker container via shell, e.g.:
```
➜ docker exec -it 0dc448cf71d181a68312659d9 bash
root@0dc448cf71d1:/#
```
From here on out, you can run all your commands from within the container.
## Usage
- You can theoretically copy over your log files you downloaded previously with `docker cp`. If you don't want to copy over your log files, this container includes terminus and the `get-logs` and `rsync` plugins to facilitate getting the logs directly to the container with analysis. 

The first step is to authenticate with terminus and a machine token (Reference to this process [here](https://pantheon.io/docs/machine-tokens)):
```
terminus auth:login --machine-token=[MACHINE_TOKEN]
```
- OPTIONAL: Setup an ssh-key and add it to your account via terminus:
```
ssh-keygen
(follow the prompts and generate, id_rsa.pub is default)
terminus ssh:add ~/.ssh/id_rsa.pub
```
If you don't do this step, you'll need to use the password for your account when accessing the logs via the terminus get-logs or rsync plugin.

- Grab the logs via the terminus-get-logs plugin:
```
terminus get-logs [your site name].[environment (dev, test, live, or multidev env)]
```
So if your site is called "foobar", and you want the "dev" environment logs:
```
terminus get-logs foobar.dev
```
The logs should be inside a folder with site name, environment, and then IP of server.

Alternatively, with the `rsync` plugin:
```
terminus rsync foobar.dev:logs ./logs
```
This should rsync the logs folder of the environment to the container into a /logs folder.
- Analyze logs via GoAccess, e.g. for the log file `nginx-access.log` in current directory:
```
goaccess -p /usr/local/etc/goaccess/goaccess.conf nginx-access.log
```
To analyze all logs at once in a given directory:
```
goaccess -p /usr/local/etc/goaccess/goaccess.conf */nginx-access.log
```
