#!/bin/bash

cd /build
ulimit -n 65535
ulimit -n
sudo -u build makepkg -s --noconfirm
cp *.pkg.tar.xz /build/out/
