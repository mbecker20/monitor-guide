sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

echo "permissions should be fixed"