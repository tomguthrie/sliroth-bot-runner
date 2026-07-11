FROM ghcr.io/actions/actions-runner:2.335.1

# The stock runner image is intentionally minimal and ships no C toolchain, so
# Rust links fail (`rust-lld: cannot open Scrt1.o`, `unable to find -lc`). Add a
# C build toolchain so cargo/clippy/fmt can link in kubernetes-mode ARC pods.
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  pkg-config \
  libssl-dev \
  libasound2-dev \
  ca-certificates \
  gcc-mingw-w64-x86-64 \
  g++-mingw-w64-x86-64 \
  binutils-mingw-w64-x86-64 \
  nasm \
  cmake \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER runner
