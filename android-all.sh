#!/bin/bash

set -euxo pipefail

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-min.aar

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{gpl,x264,x265,xvidcore,libvidstab}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-min-gpl.aar

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{gmp,gnutls}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-https.aar

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{gmp,gnutls} \
  --enable-{gpl,x264,x265,xvidcore,libvidstab}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-https-gpl.aar

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{lame,libilbc,libvorbis,opencore-amr,opus,shine,soxr,speex,twolame,vo-amrwbenc}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-audio.aar

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{dav1d,fontconfig,freetype,fribidi,kvazaar,libass,libtheora,libvpx,libwebp,snappy,zimg}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-video.aar

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{dav1d,fontconfig,freetype,fribidi,gmp,gnutls,kvazaar,lame,libass,libilbc,libtheora,libvorbis,libvpx,libwebp,libxml2,opencore-amr,opus,shine,snappy,soxr,speex,twolame,vo-amrwbenc,zimg}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-full.aar

./android.sh --lts --enable-android-media-codec --enable-android-zlib --disable-arm-v7a --disable-arm-v7a-neon --disable-x86 --disable-x86-64 \
  --enable-{gpl,x264,x265,xvidcore,libvidstab} \
  --enable-{dav1d,fontconfig,freetype,fribidi,gmp,gnutls,kvazaar,lame,libass,libilbc,libtheora,libvorbis,libvpx,libwebp,libxml2,opencore-amr,opus,shine,snappy,soxr,speex,twolame,vo-amrwbenc,zimg}
mv prebuilt/bundle-android-aar-lts/ffmpeg-kit/ffmpeg-kit.aar ffmpeg-kit-full-gpl.aar
