#!/bin/bash
add_user=roboshop
print_head () {
  echo -e "\e[32m>>>>>>> $1 <<<<<<<<<<<<<\e[0m"
}
func_nodejs() {
  Print_head "Setup nodejs repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  Print_head "Install nodejs"
  yum install nodejs -y
  Print_head "add application user"
  useradd ${add_user}
  Print_head "create app directory"
  rm -rf /app
  mkdir /app
  Print_head "Download the application code"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app
  Print_head "unzip code file "
  unzip /tmp/${component}.zip
  Print_head "Install dependencies "
  npm install
  Print_head "copy cart service file"
  cp $script_path/${component}.service /etc/systemd/system/${component}.service
  Print_head "load service "
  systemctl daemon-reload
  Print_head "Enable and start service"
  systemctl enable ${component}
  systemctl restart ${component}

}