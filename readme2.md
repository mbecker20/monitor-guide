## Monitor Periphery Launch Guide

This is a guide to launch monitor-periphery, which is a client to enable communication between your instance and monitor-core, a centralized monitoring platform.

This guide assumes your instance is running Ubuntu. if it is not using Ubuntu please contact me (Becker).

To start, ensure you have a working nodejs installation. If nodejs is not installed, follow the instructions [here](https://github.com/nodesource/distributions/blob/master/README.md).

The first step is to install docker. There is a convenience script for this, which can be used by cloning the monitor guide repo:

- `git clone https://github.com/mbecker20/monitor-guide.git`

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