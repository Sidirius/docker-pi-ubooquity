#!/bin/sh

screen -dmS ssh /usr/sbin/sshd -D
if [ -n $UBOOQUITY_PORT ]; then UBOOQUITY_PORT="8085"; fi
cd /config
screen -dmS ubooquity java -jar /ubooquity/Ubooquity.jar -port $UBOOQUITY_PORT -webadmin -headless 

while [ 1 ]; do
    /bin/bash
done
