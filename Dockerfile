FROM alpine:3.6
MAINTAINER KenjiTakahashi <kenji.sx>

RUN apk add --no-cache \
    curl \
    file \
    make \
    gcc \
    libc-dev \
    m4 \
    libtool \
    libcap-dev \
    libsndfile-dev \
    speexdsp-dev \
    eudev-dev

COPY *.patch /home/

RUN curl -Lo/home/pa.tar.xz https://freedesktop.org/software/pulseaudio/releases/pulseaudio-10.0.tar.xz && \
    tar xvf /home/pa.tar.xz -C /home && \
    cd /home/pulseaudio-10.0 && \
    patch -Np1 < ../0001-padsp-Make-it-compile-on-musl.patch && \
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var \
        --enable-udev \
        --disable-hal-compat \
        --disable-nls \
        --disable-oss-output \
        --disable-coreaudio-output \
        --disable-esound \
        --disable-solaris \
        --disable-gconf \
        --disable-avahi \
        --disable-manpages \
        --disable-x11 \
        --disable-gtk3 \
        --disable-legacy-database-entry-format && \
    make && \
    make -j1 install && \
    rm -rf /home/pulseaudio-10.0 /home/*.patch

RUN addgroup -S pulse && \
    addgroup -S pulse-access && \
    adduser -S -G pulse pulse && \
    addgroup pulse pulse-access && \
    addgroup pulse audio && \
    chown -R pulse:pulse /home/pulse

WORKDIR /home/pulse
USER pulse

ENTRYPOINT ["pulseaudio"]
CMD ["--log-target=stderr"]
