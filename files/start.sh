#!/bin/sh

screen -dmS ssh /usr/sbin/sshd -D
if [ -n $UBOOQUITY_PORT ]; then UBOOQUITY_PORT="8085"; fi
cd /UbooquityInstall
screen -dmS ubooquity java -jar Ubooquity.jar -port $UBOOQUITY_PORT -webadmin -headless 

while [ 1 ]; do
    /bin/bash
done
