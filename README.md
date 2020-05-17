**[Dockerized PulseAudio](https://hub.docker.com/r/kdockerfiles/pulseaudio)**

# Usage

```bash
$ docker run kdockerfiles/pulseaudio
```

## Devices

If you want the server to be able to see your physical sound interface(s), you should add `--device /dev/snd` to the `docker run` command.

## Available volumes

`/tmp/pulse`: Contains PulseAudio UNIX socket file (named `socket`).

`/usr/local/etc/pulse`: Contains PulseAudio configuration files.

Most notably including `client.conf`, which should be exposed to any client application that wants to connect to the PulseAudio server.

## Environment variables

`DEV_SND_GRP_ID`: If set, adds user `pulse` to a new group with this ID and executes `pulseaudio` with `pulse:$DEV_SND_GRP_ID`, instead of `pulse:pulse`.
Useful when your system has `/dev/snd/` permissions that do not work out of box.

## Notes

As it is now, only applications that are inside of group `root` (gid `0`) will be able to connect to the server. This works for me for now, but might change in the future.

# Limitations

There is currently no `udev` support, which means that your sound interface(s) **must** be already connected to the host at the time the container starts. This is simply because I couldn't get PA's udev module to work inside Docker (and I don't need it, so I gave up for now). Suggestions/PRs welcome.
