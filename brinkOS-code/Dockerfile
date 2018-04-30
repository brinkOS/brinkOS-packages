FROM base/archlinux:2018.04.01

# Create user for builds.
RUN set -xe; \
    useradd --no-create-home --shell=/bin/false build; \
    usermod -L build; \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers;

# Install all needed deps
RUN set -xe; \
    pacman -Syu --noconfirm; \
    pacman -S base base-devel cmake automake autoconf wget vim archiso openssh git --noconfirm;

# Install oldr nodejs package
RUN set -xe; \
    wget https://archive.archlinux.org/packages/n/nodejs/nodejs-9.9.0-3-x86_64.pkg.tar.xz; \
    pacman -U --noconfirm ./nodejs-9.9.0-3-x86_64.pkg.tar.xz;

# Install build deps for package
RUN set -xe; \
    pacman -S --noconfirm npm gulp python2 git yarn;

# This build requires a home directory
RUN mkdir -p /home/build && chown -R build:build /home/build

# Copy package files
COPY code.desktop /build/
COPY PKGBUILD /build/
COPY product_json.patch /build/
COPY startup_script.patch /build/
COPY build.sh /usr/local/bin/build

# Fix ownership
RUN set -xe; \
    mkdir -p /build/out; \
    chown -R build:build /build;

VOLUME /build/out

# Set our entrypoint which kicks off our build.
ENTRYPOINT [ "/usr/local/bin/build" ]
