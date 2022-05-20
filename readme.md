## Monitor Periphery Launch Guide

This is a guide to launch monitor-periphery, which is a client to enable communication between your instance and monitor-core, a centralized monitoring platform.

This guide assumes your instance is running Ubuntu or Red Hat. If it is not using one of these please contact me (Becker).

The first step is to install docker. There is a convenience script for this, which can be used by cloning the monitor guide repo:

- `git clone https://github.com/mbecker20/monitor-guide.git`

If your instance already has nodejs installed, please run:

- Ubuntu: `sh monitor-guide/dockerInstallUbuntu.sh`
- Red Hat: `sh monitor-guide/dockerInstallRedHat.sh`

If nodejs is not installed, run the script that includes the nodejs install as well.

- Ubuntu: `sh monitor-guide/nodeDockerInstallUbuntu.sh`
- Red Hat: `sh monitor-guide/nodeDockerInstallRedHat.sh`

At this point, node and docker should be installed and running. please confirm this by running `node -v` and `docker -v` and ensure they give a version number.

The next step is the secrets file. This will contain the docker access token which enables the server to pull images from our private dockerhub registry. Create a directory at /home/ubuntu/secrets and run sudo nano secrets.json. The contents should look like this:

`{ "GITHUB_ACCOUNTS": {}, "DOCKER_ACCOUNTS": { "<docker username>": "<docker access token>" }, "PASSKEY": "<monitor passkey>" }`

Please replace the docker username, docker access token, and monitor passkey with the values provided to you, then save this file and exit nano.

The next step is to launch the monitor-periphery container. This is handled by the monitor-cli. To start the cli, ensure you are at your home directory by running `cd ~` and then run the following command:

- `npx @mbecker20/monitor-cli@0.0.29`

this will prompt you to install this package, choose yes. In a few seconds, it will finish and you will be greeted with the monitor-cli.

If the cli fails to recognize your docker installation, you probably just need to correct the permissions. Run the fix permissions script with:

- `sh monitor-guide/fixDockerPermissions.sh`

Once monitor-cli starts, press enter to continue to the next stage. To select an option, use the arrow keys and press enter. You can also press escape to go back a step.

- choose "deploy monitor core or periphery"
- choose "periphery"
- configure the name of the container (keep the default name, monitor-periphery)
- configure the location of the secrets folder (should be the default entry, /home/ubuntu/secrets)
- configure the location of the system mount point (should be the default, /home/ubuntu/monitor/)
- configure the port (the default 8000 should work but can be changed if this port is already in use)
- for restart, choose the default "don't restart" option

When that is complete, press enter to go to the confirm step, and press enter again to launch monitor-periphery. After a couple seconds, the install should finish.

Congratulations, you have started the monitor-periphery client, and the instance can now be configured to connect to monitor-core.

## Restarting Monitor-Periphery
