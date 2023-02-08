# Monitor Periphery Setup Guide

This is a guide to setup monitor-periphery, which is a client to enable communication between your instance and monitor-core.

This guide assumes your instance is running Ubuntu.

## **1. Clone this repo**

```
git clone https://github.com/mbecker20/monitor-guide.git
```
## **2. Run setup script**

if you want to use this server to build and deploy docker containers, run:

```
sh monitor-guide/setup-periphery-docker.sh && sh monitor-guide/setup-periphery-monitoring.sh
```

if you don't need docker installed, just run:

```
sh monitor-guide/setup-periphery-monitoring.sh
```

This will start monitor periphery as a user managed systemd service.

To view the status of the periphery agent, check with systemctl:

```
systemctl --user status periphery
```

## **3. Edit config file (optional)**

You can now edit the config file at ~/.monitor/periphery.config.toml and add any required docker or github accounts needed for access to private github / docker repos, for example you can add:

```
[github_accounts]
username1 = "github-access-token-1"
username2 = "github-access-token-2"

[docker_accounts]
username1 = "docker-access-token-1"
username2 = "docker-access-token-2"
```

Note that only the usernames are ever returned to monitor core, the secret access tokens stay private on your server.

To increase security, you can whitelist the IP address of monitor core:

```
allowed_ips = ["12.34.56.78"]
```

## **3. Restart periphery (optional)**

If you edit the periphery config, just restart periphery for the changes to take effect, using this command:

```
systemctl --user restart periphery
```
