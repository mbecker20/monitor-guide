#!/bin/bash

sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

echo "user given access to docker"