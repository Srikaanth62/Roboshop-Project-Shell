curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cp cart.service /etc/systemd/system/cart.service
cd /app
unzip /tmp/cart.zip
npm install
systemctl daemon-reload
systemctl enable cart
systemctl start cart
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb.srikaanth62.online </app/schema/user.js



