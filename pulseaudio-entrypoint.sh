#!/usr/bin/env sh
set -e

rm -f /tmp/pulse/socket

pulseaudio $@
