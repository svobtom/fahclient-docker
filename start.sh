#!/bin/bash

ARGS="--run-as fahclient"

# test
MY_POWER=${POWER:-full}
MY_USERNAME=${USERNAME:-cerit}
# not empty or unset (-e TEAM= to set no team)
[ ! "${TEAM+x$TEAM}" = "x" ] && MY_TEAM=${TEAM:=237385}
MY_NVIDIA=${NVIDIA:-}

ARGS="$ARGS --power=$MY_POWER --user=$MY_USERNAME"
[ $MY_TEAM ] && ARGS="$ARGS --team=$MY_TEAM"

[ $MY_NVIDIA ] && [ ! -x /usr/bin/nvidia-smi ] && {
    # NVIDIA=440.64.00
    #wget -q http://de.download.nvidia.com/XFree86/Linux-x86_64/440.64/NVIDIA-Linux-x86_64-440.64.run
    wget -q http://us.download.nvidia.com/tesla/$MY_NVIDIA/NVIDIA-Linux-x86_64-$MY_NVIDIA.run
    chmod +x NVIDIA-Linux-x86_64-$MY_NVIDIA.run
    ./NVIDIA-Linux-x86_64-$MY_NVIDIA.run -s --no-kernel-module
}

/usr/bin/FAHClient $ARGS
