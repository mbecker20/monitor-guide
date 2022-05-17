echo "installing node"

curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -

echo "installing docker"

sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine podman runc

sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo systemctl start docker

sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

sudo systemctl enable docker.service

sudo systemctl enable containerd.service

echo "install complete"