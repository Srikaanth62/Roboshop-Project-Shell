path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
mysql_root_pwd=$1
if [ -z "$mysql_root_pwd" ]; then
  echo mysql password missing
  exit
fi
print_head() {
  echo -e "\e[34m>>>>>>>>>>> $1 <<<<<<<<<<<<<<\e[0m"
}
print_head "Install java packaging software"
yum install maven -y
print_head "create application user"
useradd ${add_user}
print_head "craete app directory"
rm -rf /app
mkdir /app
print_head "Download application code"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
print_head "unzip code file"
unzip /tmp/shipping.zip
print_head "download dependencies and build the application"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
print_head "copy shipping service"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
print_head "Load service"
systemctl daemon-reload
print_head "Enable and start the service"
systemctl enable shipping
systemctl start shipping
print_head "Install sql client"
yum install mysql -y
print_head "Load the sql schema"
mysql -h mysql-dev.srikaanth62.online -uroot -p${mysql_root_pwd} < /app/schema/shipping.sql
print_head "Restart the service"
systemctl restart shipping