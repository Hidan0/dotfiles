#!/bin/bash

cargo install cargo-binstall
cargo install cargo-modules
cargo install cargo-watch
cargo install cargo-audit
cargo install cargo-edit
cargo install --force cargo-make
cargo binstall cargo-nextest --secure
cargo binstall cargo-tarpaulin
