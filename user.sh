curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cp user.service /etc/systemd/system/user.service
cd /app
unzip /tmp/user.zip
npm install
systemctl daemon-reload
systemctl enable user
systemctl start user
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb.srikaanth62.online </app/schema/user.js



