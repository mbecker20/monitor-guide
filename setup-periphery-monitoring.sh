#!/bin/bash

sudo apt install build-essential libssl-dev -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source "$HOME/.cargo/env"

cargo install monitor_cli

monitor periphery gen-config

cargo install monitor_periphery

sudo echo "[Unit]" > /etc/systemd/system/periphery.service
sudo echo "Description=agent to connect with monitor core" >> /etc/systemd/system/periphery.service
sudo echo "After=network.target" >> /etc/systemd/system/periphery.service
sudo echo "" >> /etc/systemd/system/periphery.service
sudo echo "[Service]" >> /etc/systemd/system/periphery.service
sudo echo "Type=simple" >> /etc/systemd/system/periphery.service
sudo echo "User=$USER" >> /etc/systemd/system/periphery.service
sudo echo "WorkingDirectory=$HOME" >> /etc/systemd/system/periphery.service
sudo echo "ExecStart=/bin/bash --login -c 'source $HOME/.bashrc; $HOME/.cargo/bin/periphery --config-path ~/.monitor/periphery.config.toml --home-dir $HOME'" >> /etc/systemd/system/periphery.service
sudo echo "TimeoutStartSec=0" >> /etc/systemd/system/periphery.service
sudo echo "" >> /etc/systemd/system/periphery.service
sudo echo "[Install]" >> /etc/systemd/system/periphery.service
sudo echo "WantedBy=default.target" >> /etc/systemd/system/periphery.service

sudo systemctl daemon-reload

sudo systemctl enable periphery.service

sudo systemctl start periphery.service