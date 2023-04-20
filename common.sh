#!/bin/bash
add_user=roboshop
func_nodejs() {
  echo -e "\e[35m>>>>>>> Setup nodejs repos <<<<<<<<<\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  echo -e "\e[35m>>>>>> Install nodejs <<<<<<<<<<<\e[0m"
  yum install nodejs -y
  echo -e "\e[35m>>>>>> add application user <<<<<<<<<<<\e[0m"
  useradd ${add_user}
  echo -e "\e[35m>>>>>> create app directory <<<<<<<<<<<\e[0m"
  rm -rf /app
  mkdir /app
  echo -e "\e[35m>>>>>> Download the application code <<<<<<<<<<<\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app
  echo -e "\e[35m>>>>>> unzip code file <<<<<<<<<<<\e[0m"
  unzip /tmp/${component}.zip
  echo -e "\e[35m>>>>>> Install dependencies <<<<<<<<<<<\e[0m"
  npm install
  echo -e "\e[35m>>>>>> copy cart service file <<<<<<<<<<<\e[0m"
  cp $script_path/${component}.service /etc/systemd/system/${component}.service
  echo -e "\e[35m>>>>>> load service <<<<<<<<<<<\e[0m"
  systemctl daemon-reload
  echo -e "\e[35m>>>>>> Enable and start service <<<<<<<<<<<\e[0m"
  systemctl enable ${component}
  systemctl restart ${component}

}