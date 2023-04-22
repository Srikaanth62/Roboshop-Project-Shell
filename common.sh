#!/bin/bash
add_user=roboshop
print_head() {
  echo -e "\e[32m>>>>>>> $1 <<<<<<<<<<<<<\e[0m"
}

setup_schema() {
  if [ "$setup_schema" == "mongo" ]; then
  print_head "copy and Setup mongodb repo "
  cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
  print_head  "Install mongodb client"
  yum install mongodb-org-shell -y
  print_head "load mongodb schema "
  mongo --host mongodb-dev.srikaanth62.online </app/schema/${component}.js
  print_head "Restart the catalogue service "
  systemctl restart ${component}
fi
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
setup_schema()