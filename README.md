# sliroth-bot-runner

Custom GitHub Actions runner image for a self-hosted **`sliroth-bot`** runner in private
`olympus` cluster (Actions Runner Controller, kubernetes container mode).

## Why this exists

The stock `ghcr.io/actions/actions-runner` image is deliberately minimal and ships **no C
toolchain**. In ARC kubernetes mode the job steps run directly in the runner pod, so building
the Rust services (`cargo` / `clippy` / `rustfmt`) fails at **link time**:

```
rust-lld: error: cannot open Scrt1.o: No such file or directory
rust-lld: error: unable to find library -lc
```

This image is the official runner plus `build-essential` (and `pkg-config` / `libssl-dev`) so
linking works. For now the Rust toolchain and Node are not included and instead we still use
`dtolnay/rust-toolchain@stable` and `actions/setup-node`. This may change in the future if
it improves things.

## Image

Published to `ghcr.io/tomguthrie/sliroth-bot-runner` on every change and weekly (to pick up
base-image security updates). Olympus pins it by **digest** in the `sliroth-bot` runner's
`HelmRelease`.

