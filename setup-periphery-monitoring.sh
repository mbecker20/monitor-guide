#!/bin/bash

sudo apt install build-essential libssl-dev -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source "$HOME/.cargo/env"

cargo install monitor_cli

monitor periphery gen-config

monitor periphery start systemd