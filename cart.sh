echo -e "\e[35m>>>>>>> Setup nodejs repos <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>> Install nodejs <<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[35m>>>>>> add application user <<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>> create app directory <<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>> Download the application code <<<<<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[35m>>>>>> unzip code file <<<<<<<<<<<\e[0m"
unzip /tmp/cart.zip
echo -e "\e[35m>>>>>> Install dependencies <<<<<<<<<<<\e[0m"
npm install
echo -e "\e[35m>>>>>> copy cart service file <<<<<<<<<<<\e[0m"
cp /root/Roboshop-Project-Shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[35m>>>>>> load service <<<<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[35m>>>>>> Enable and start service <<<<<<<<<<<\e[0m"
systemctl enable cart
systemctl start cart
echo -e "\e[35m>>>>>> copy mongodb repo file <<<<<<<<<<<\e[0m"
cp /root/Roboshop-Project-Shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>> Install mongodb client <<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[35m>>>>>> load mongodb schema <<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.srikaanth62.online </app/schema/user.js
echo -e "\e[35m>>>>>> restart the service <<<<<<<<<<<\e[0m"
systemctl restart cart



