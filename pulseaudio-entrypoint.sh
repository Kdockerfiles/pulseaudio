#!/usr/bin/env sh

grp="pulse"
if [ "$DEV_SND_GRP_ID" ]; then
    grp="devsnd"
    addgroup -S -g $DEV_SND_GRP_ID $grp
    addgroup pulse $grp
fi

set -e

rm -f /tmp/pulse/socket
rm -f /tmp/pulse-*/pid

su-exec pulse:$grp pulseaudio $@
