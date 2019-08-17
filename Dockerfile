FROM kdockerfiles/pulseaudio-shared:12.2-3
LABEL maintainer="KenjiTakahashi <kenji.sx>"

RUN apk add --no-cache \
    libltdl \
    libcap \
    libsndfile \
    speexdsp \
    alsa-lib

# XXX: Using `29` GID as a workaround for
# RancherOS limitation.
RUN addgroup -S -g 29 pulse && \
    adduser -S -G pulse pulse && \
    addgroup pulse audio && \
    mkdir /tmp/pulse && \
    chown -R pulse:pulse /home/pulse /tmp/pulse

USER pulse

VOLUME ["/tmp/pulse", "/usr/local/etc/pulse"]

ENTRYPOINT ["pulseaudio"]
CMD ["--log-target=stderr"]
