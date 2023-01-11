sudo apt install build-essential libssl-dev -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source "$HOME/.cargo/env"

cargo install monitor_cli

monitor periphery gen-config

cargo install monitor_periphery

UNIT_FILE="[Unit]%s\nDescription=agent to connect with monitor core%s\nAfter=network.target%s\n%s\n[Service]%s\nType=simple%s\nUser=$USER%s\nWorkingDirectory=$HOME%s\nExecStart=/bin/bash --login -c 'source $HOME/.bashrc; $HOME/.cargo/bin/periphery --config-path ~/.monitor/periphery.config.toml --home-dir $HOME'%s\nTimeoutStartSec=0%s\n%s\n[Install]%s\nWantedBy=default.target"

sudo printf $UNIT_FILE > /etc/systemd/system/periphery.service

sudo systemctl daemon-reload

sudo systemctl enable periphery.service

sudo systemctl start periphery.service