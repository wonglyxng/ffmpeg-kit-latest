#!/bin/bash

set -euxo pipefail


./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{libiconv}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-https.aar
