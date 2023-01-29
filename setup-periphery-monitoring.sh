#!/bin/bash

BIN_PATH=$HOME/.monitor/bin
mkdir -p $BIN_PATH

echo "\ndownloading monitor cli...\n"
curl -L https://github.com/mbecker20/monitor/releases/download/v0.1.11/monitor > $BIN_PATH/monitor
chmod +x $BIN_PATH/monitor

echo "\ndownloading monitor periphery...\n"
systemctl --user stop periphery # in case its currently in use
curl -L https://github.com/mbecker20/monitor/releases/download/v0.1.11/periphery > $BIN_PATH/periphery
chmod +x $BIN_PATH/periphery

# this adds $HOME/.monitor/bin to path
if ! grep ".monitor/bin" $HOME/.bashrc > /dev/null; then
	echo "" >> $HOME/.bashrc
	echo "export PATH=$HOME/.monitor/bin:\$PATH" >> ~/.bashrc
fi

export PATH="$HOME/.monitor/bin:$PATH"

if ! test -f "$HOME/.monitor/periphery.config.toml"; then
	monitor periphery gen-config
fi

if pgrep periphery > /dev/null; then
	systemctl --user restart periphery
else
	monitor periphery start systemd --yes
fi
