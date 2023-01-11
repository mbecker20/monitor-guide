sudo apt install build-essential libssl-dev -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source "$HOME/.cargo/env"

cargo install monitor_cli

monitor periphery gen-config

cargo install monitor_periphery

UNIT_FILE="[Unit]\nDescription=agent to connect with monitor core\nAfter=network.target\n\n[Service]\nType=simple\nUser=$USER\nWorkingDirectory=$HOME\nExecStart=/bin/bash --login -c 'source $HOME/.bashrc; $HOME/.cargo/bin/periphery --config-path ~/.monitor/periphery.config.toml --home-dir $HOME'\nTimeoutStartSec=0\n\n[Install]\nWantedBy=default.target"

sudo echo $UNIT_FILE > /etc/systemd/system/periphery.service

sudo systemctl daemon-reload

sudo systemctl enable periphery.service

sudo systemctl start periphery.service