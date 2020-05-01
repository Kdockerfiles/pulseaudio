FROM kdockerfiles/pulseaudio-shared:13.0-1
LABEL maintainer="KenjiTakahashi <kenji.sx>"

RUN apk add --no-cache \
    libintl \
    libltdl \
    libsndfile \
    speexdsp \
    tdb-libs \
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

COPY pulseaudio-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["pulseaudio-entrypoint.sh"]
CMD ["--log-target=stderr"]
