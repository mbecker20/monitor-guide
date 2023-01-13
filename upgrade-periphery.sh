#!/bin/bash

# will install the latest binary
cargo install monitor_periphery

systemctl --user restart periphery

