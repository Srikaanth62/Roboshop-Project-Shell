#!/bin/bash
add_user=roboshop
print_head() {
  echo -e "\e[32m>>>>>>> $1 <<<<<<<<<<<<<\e[0m"
}

func_app_user() {
    print_head "create application user"
    useradd ${add_user}
    print_head "create app directory"
    rm -rf /app
    mkdir /app
    print_head "Download application code"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app
    print_head "unzip code file"
    unzip /tmp/${component}.zip
}

func_setup_schema() {
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
  if [ "$setup_schema" == "mysql" ]; then
     print_head "Install sql client"
     yum install mysql -y
     print_head "Load the sql schema"
     mysql -h mysql-dev.srikaanth62.online -uroot -p${mysql_root_pwd} < /app/schema/${component}.sql
  fi
 }

 func_systemd_setup() {
   print_head "copy systemd service"
   cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
   print_head "Load service"
   systemctl daemon-reload
   print_head "Enable and start the service"
   systemctl enable ${component}
   systemctl start ${component}
   print_head "Restart the service"
   systemctl restart ${component}
 }

func_nodejs() {
  print_head "Setup nodejs repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  print_head "Install nodejs"
  yum install nodejs -y
  func_app_user
  print_head "Install dependencies "
  npm install
  func_setup_schema
  func_systemd_setup
}

func_java() {
  print_head "Install java packaging software"
  yum install maven -y
  func_app_user
  print_head "download dependencies and build the application"
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar
  func_setup_schema
  func_systemd_setup
}
