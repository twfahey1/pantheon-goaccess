# GoAccess VM

## Overview
- Preconfigured w/ GoAccess - configuration is in `/usr/local/etc/goaccess`

## Setup

## Usage
- Get this Dockerfile running and access the Docker container via shell, e.g.:
```
➜  goaccess-vm (master) ✗ docker run -t -d be6941406cee
c7fb74bed82644617a7d4abc4eadd64b1bfcc7329a837df8b7fe24cb004c0deb
➜  goaccess-vm (master) ✗ docker exec -it c7fb74bed82644617a7d4abc4eadd64b1bfcc7329a837df8b7fe24cb004c0deb bash
root@c7fb74bed826:/#
```
- Now authenticate with terminus and a machine token:
```
terminus auth:login --machine-token=[MACHINE_TOKEN]
```
- Setup an ssh-key and add it to your account via terminus:
```
ssh-keygen
(follow the prompts and generate, id_rsa.pub is default)
terminus ssh:add ~/.ssh/id_rsa.pub
```
- Grab the logs via the terminus-get-logs plugin:

- Analyze logs via GoAccess, e.g. for the log file `nginx-access.log` in current directory:
```
goaccess -p /usr/local/etc/goaccess/goaccess.conf nginx-access.log
```

