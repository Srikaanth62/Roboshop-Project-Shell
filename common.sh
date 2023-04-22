#!/bin/bash
add_user=roboshop
log_file=/tmp/roboshop.log
print_head() {
  echo -e "\e[32m>>>>>>> $1 <<<<<<<<<<<<<\e[0m"
  echo -e "\e[32m>>>>>>> $1 <<<<<<<<<<<<<\e[0m" &>>$log_file
}

func_exit_code() {
  if [ $1 -eq 0 ]; then
      echo -e "\e[32mSUCCESS\e[0m"
    else
      echo -e "\e[31mFAILURE\e[0m"
      echo "Please refer following path to check failures : /tmp/roboshop.log"
      exit
    fi
}

func_app_user() {
    print_head "create application user"
    if [ $? -ne 0 ]; then
    useradd ${add_user}
    fi
    print_head "create app directory"
    rm -rf /app
    mkdir /app
    print_head "Download application code"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
    func_exit_code $?
    cd /app
    print_head "unzip code file"
    unzip /tmp/${component}.zip
    func_exit_code $?
}

func_setup_schema() {
  if [ "$setup_schema" == "mongo" ]; then
  print_head "copy and Setup mongodb repo "
  cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo  &>>$log_file
  func_exit_code $?
  print_head  "Install mongodb client"
  yum install mongodb-org-shell -y
  func_exit_code $?
  print_head "load mongodb schema "
  mongo --host mongodb-dev.srikaanth62.online </app/schema/${component}.js  &>>$log_file
  func_exit_code $?
  print_head "Restart the catalogue service "
  systemctl restart ${component}
fi
  if [ "$setup_schema" == "mysql" ]; then
     print_head "Install sql client"
     yum install mysql -y
     func_exit_code $?
     print_head "Load the sql schema"
     mysql -h mysql-dev.srikaanth62.online -uroot -p${mysql_root_pwd} < /app/schema/${component}.sql  &>>$log_file
     func_exit_code $?
  fi
 }

 func_systemd_setup() {
   print_head "copy systemd service"
   cp ${script_path}/${component}.service /etc/systemd/system/${component}.service  &>>$log_file
   func_exit_code $?
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
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  func_exit_code $?
  print_head "Install nodejs"
  yum install nodejs -y
  func_exit_code $?
  func_app_user
  print_head "Install dependencies "
  npm install
  func_exit_code $?
  func_setup_schema
  func_systemd_setup
}

func_java() {
  print_head "Install java packaging software"
  yum install maven -y
  func_exit_code $?
  func_app_user
  print_head "download dependencies and build the application"
  mvn clean package
  func_exit_code $?
  mv target/${component}-1.0.jar ${component}.jar &>>$log_file
  func_exit_code $?
  func_setup_schema
  func_systemd_setup
}
