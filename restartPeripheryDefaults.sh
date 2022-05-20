docker pull mbecker2020/monitor-periphery

docker stop monitor-periphery && docker container rm monitor-periphery

docker run -d --name monitor-periphery -v /home/ubuntu/secrets:/secrets -v /var/run/docker.sock:/var/run/docker.sock -v /home/ubuntu/monitor/:/monitor-root -v /home/ubuntu/.pm2:/.pm2 -p 8000:8000 -e SYSROOT=/home/ubuntu/monitor/ --restart no mbecker2020/monitor-periphery