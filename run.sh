#!/bin/sh

capsh --print | grep "Current:" | cut -d' ' -f3 | grep -q cap_sys_ptrace || (echo "You have to run this image with --cap-add=SYS_PTRACE to work properly" && exit 1) || exit 1
[ $PASSWORD ] && echo "$USER:$PASSWORD" | chpasswd && echo "Password changed for $USER: $PASSWORD"
sed -i "s/#CreateDisplay 0/CreateDisplay 1/g" /usr/NX/etc/server.cfg
sed -i "s/#DisplayOwner ""/DisplayOwner "$USER"/g" /usr/NX/etc/server.cfg
sed -i "s/#DisplayGeometry 800x600 ""/DisplayGeometry 800x600/g" /usr/NX/etc/server.cfg
/etc/NX/nxserver --startup
su - $USER -c "DISPLAY=:1001 $@"
