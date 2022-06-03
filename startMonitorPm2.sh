echo "starting monitor pm2 client"

cd ~

sudo npm i -g pm2

pm2 delete monitor-pm2

git clone https://github.com/mbecker20/monitor-pm2.git

cd monitor-pm2 && npm i && npm run start

echo "monitor pm2 client started"