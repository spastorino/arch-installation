#!/bin/sh

# Install Rust stable, beta and nightly versions
rustup install stable
rustup default stable
rustup component add clippy llvm-tools-preview rls rust-analysis rust-src rustc-dev rustfmt

rustup install beta
rustup default beta
rustup component add clippy llvm-tools-preview rls rust-analysis rust-src rustc-dev rustfmt

rustup install nightly
rustup default nightly
rustup component add clippy llvm-tools-preview miri rls rust-analysis rust-analyzer-preview rustc-dev rust-src rustfmt
rustup target install i686-unknown-linux-gnu

# Install cargo packages
# https://github.com/rust-lang/cargo/wiki/Third-party-cargo-subcommands
cargo install cargo-audit
cargo install cargo-asm
cargo install cargo-benchcmp
cargo install cargo-bloat
cargo install cargo-binutils
cargo install cargo-check
cargo install cargo-clone
cargo install cargo-count
cargo install cargo-crev
cargo install cargo-deadlinks
cargo install cargo-edit
cargo install cargo-expand
cargo install cargo-graph
# cargo install cargo-info # didn't work
cargo install cargo-license
cargo install cargo-make
# cargo install cargo-modules # didn't work
cargo install cargo-open
cargo install cargo-outdated
cargo install cargo-profiler
cargo install cargo-release
cargo install cargo-script
cargo install cargo-sweep
cargo install cargo-tarpaulin
cargo install cargo-tree
cargo install cargo-udeps
cargo install cargo-update
cargo install cargo-urlcrate
cargo install cargo-vendor
cargo install cargo-watch
cargo install git-absorb
cargo install sccache

# Recover ssh keys
cp -a $BACKUP/.ssh ~/

# Install vinimum
git clone git@github.com:spastorino/vinimum.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
vim +PlugInstall +UpdateRemotePlugins +qa
