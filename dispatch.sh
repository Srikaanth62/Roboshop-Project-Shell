path=$(realpath "$0")
script_path+$(dirname "$path")
source $script_path/common.sh
print_head() {
  print_head>> $1 <<<<<<<<<<<\e[0m"
}
print_head "Install golang"
yum install golang -y
print_head "Add application user"
useradd ${add-user}
print_head "create app directory "
rm -rf /app
mkdir /app
print_head "download application code"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
print_head unzip code file <<<<<<<<<<\e[0m"
cd /app
unzip /tmp/dispatch.zip
print_head Install dependencies and build the applications <<<<<<<<<<\e[0m"
go mod init dispatch
go get
go build
print_head 'copy dispatch service '
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service
print_head "load service "
systemctl daemon-reload
print_head "Enable and restart the service"
systemctl enable dispatch
systemctl restart dispatch

