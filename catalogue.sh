#!/bin/bash

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cp catalogue.service /etc/systemd/system/catalogue.service
cd /app
unzip /tmp/catalogue.zip
npm install
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.srikaanth62.online </app/schema/catalogue.js
systemctl restart catalogue







