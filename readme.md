# Monitor Periphery Launch Guide

This is a guide to launch monitor-periphery, which is a client to enable communication between your instance and monitor-core, a centralized monitoring platform.

This guide assumes your instance is running Ubuntu or Red Hat. If it is not using one of these please contact me (Becker).

## **1. Clone script repo and install Node / Docker**

The first step is to install docker. There is a convenience script for this, which can be used by cloning the monitor guide repo:

- `git clone https://github.com/mbecker20/monitor-guide.git`

If your instance already has nodejs installed, please run:

- Ubuntu: `sh monitor-guide/dockerInstallUbuntu.sh`
- Debian: `sh monitor-guide/dockerInstallDebian.sh`
- Red Hat: `sh monitor-guide/dockerInstallRedHat.sh`

If nodejs is not installed, run the script that includes the nodejs install as well.

- Ubuntu: `sh monitor-guide/nodeDockerInstallUbuntu.sh`
- Debian: `sh monitor-guide/nodeDockerInstallDebian.sh`
- Red Hat: `sh monitor-guide/nodeDockerInstallRedHat.sh`

At this point, node and docker should be installed and running. please confirm this by running `node -v` and `docker -v` and ensure they give a version number.

## **2. Create secrets.json file**

The next step is the secrets file. This will contain the docker access token which enables the server to pull images from our private dockerhub registry. Create a directory at /home/ubuntu/secrets and run sudo nano secrets.json. The contents should look like this:

	{
		"GITHUB_ACCOUNTS": {}, 
		"DOCKER_ACCOUNTS": { 
			"<docker username>": "<docker access token>" 
		}, 
		"PASSKEY": "<monitor passkey>" 
	}

Please replace the docker username, docker access token, and monitor passkey with the values provided to you, then save this file and exit nano.

## **3. Start monitor-periphery using the CLI (or with start defaults script)**

The next step is to launch the monitor-periphery container. This is handled by the monitor-cli. To start the cli, ensure you are at your home directory by running `cd ~` and then run the following command:

- `npx @mbecker20/monitor-cli@0.0.31`

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
- for restart, choose the "unless stopped" option

When that is complete, press enter to go to the confirm step, and press enter again to launch monitor-periphery. After a couple seconds, the install should finish.

**Alternatively**, you can just run the restart command to start the periphery client with defaults (it also works even if it has not been set up yet). This does not require a working / compatible node installation.

- `sh monitor-guide/restartPeripheryDefaults.sh`

Congratulations, you have started the monitor-periphery client, and the instance can now be configured to connect to monitor-core.

# Restarting monitor-periphery

You can restart monitor-periphery using the cli by following the exact same procedure as above. It is already configured to delete the old monitor-periphery container, pull the new image, and restart it with the given configuration. If the monitor-cli is not accessible or you have started the periphery using all the defaults, there is also a one line convenience script for this:

- `sh monitor-guide/restartPeripheryDefaults.sh`

That should do it! Congratulations, you have restarted monitor-periphery.

# Starting the pm2 client

In order for monitor to communicate with pm2, an additional client is necessary to be running on the instance. There is a convenience script to start the client, which runs as a pm2 managed process.

- `sh monitor-guide/startMonitorPm2.sh`

Note that if you are restarting the pm2 client, you should delete the previous clone of monitor-pm2 repo (`sudo rm -r monitor-pm2`) before running this script.

That is it. You should now see monitor-pm2 running as a pm2 process.
