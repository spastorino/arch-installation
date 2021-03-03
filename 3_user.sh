#!/bin/sh

# Install Rust stable, beta and nightly versions
rustup install stable
rustup default stable
rustup component add llvm-tools-preview rls rust-analysis rust-src rustc-dev rustc-docs

rustup install beta
rustup default beta
rustup component add llvm-tools-preview rls rust-analysis rust-src rustc-dev rustc-docs

rustup install nightly
rustup default nightly
rustup component add llvm-tools-preview miri rls rust-analysis rust-analyzer-preview rust-src rustc-dev rustc-docs
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
# cargo install cargo-count # clap didn't work
cargo install cargo-crev
cargo install cargo-deadlinks
cargo install cargo-edit
cargo install cargo-expand
# cargo install cargo-graph # clap didn't work
# cargo install cargo-info # openssl didn't work
cargo install cargo-license
cargo install cargo-make
# cargo install cargo-modules # a feature didn't work
cargo install cargo-open
cargo install cargo-outdated
# cargo install cargo-profiler # rustc_version didn't work
cargo install cargo-release
# cargo install cargo-script # rustc_version didn't work
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
