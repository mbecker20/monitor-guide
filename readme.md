## Monitor Periphery Launch Guide

This is a guide to launch monitor-periphery, which is a client to enable communication between your instance and monitor-core, a centralized monitoring platform.

This guide assumes your instance is running Ubuntu. if it is not using Ubuntu please contact me (Becker).

To start, ensure you have a working nodejs installation. If nodejs is not installed, follow the instructions [here](https://github.com/nodesource/distributions/blob/master/README.md).

The first step is to install docker. please run the following commands one-by-one, in the order listed. the official docker reference for install is found [here](https://docs.docker.com/engine/install/ubuntu/) and [here](https://docs.docker.com/engine/install/linux-postinstall/)

1. `sudo apt-get remove docker docker-engine docker.io containerd runc`

2. `sudo apt-get update`

3. `sudo apt-get install ca-certificates curl gnupg lsb-release`

4. `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`

5. `echo \ "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`

6. `sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin`

7. `sudo groupadd docker`

8. `sudo usermod -aG docker $USER`

9. `newgrp docker`

10. `sudo systemctl enable docker.service`

11. `sudo systemctl enable containerd.service`

At this point, docker should be installed and running. please confirm this by running `docker ps`.

The next step is the secrets file. This will contain the docker access token which enables the server to pull images from our private dockerhub registry. Create a directory at /home/ubuntu/secrets and run sudo nano secrets.json. The contents should look like this:

`{
	"GITHUB_ACCOUNTS": {},
	"DOCKER_ACCOUNTS: {
		"<docker username>": "<docker access token>"
	},
	"PASSKEY": "<monitor passkey>"
}`

Save this file and exit nano.

The next step is to launch the monitor-periphery container. This is handled by the monitor-cli. To start the cli, run the following command:

- `npx @mbecker20/monitor-cli@0.0.28`

this will prompt you to install this package, choose yes. In a few seconds, it will finish and you will be greeted with the monitor-cli.

Once it starts, press enter to continue to the next stage. To select an option, use the arrow keys and press enter. You can also press escape to go back a step.

- choose "deploy monitor core or periphery"
- choose "periphery"
- configure the name of the container (keep the default monitor-core)
- configure the location of the secrets folder (should be the default entry, /home/ubuntu/secrets)
- configure the location of the system mount point (should be the default, /home/ubuntu/monitor/)
- configure the port (the default 8000 should work but can be changed if this port is already in use)
- for restart, choose the default "don't restart" option

When that is complete, press enter to go to the confirm step, and press enter again to launch monitor-periphery. After a couple seconds, the install should finish.

Congratulations, you have started the monitor-periphery client, and the instance can now be configured to connect to monitor-core.