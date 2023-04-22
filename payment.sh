path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
rabbitmq_user_pwd=$1
if [ -z "$rabbitmq_user_pwd" ]; then
  echo RabbitMQ password is missing
  exit
  fi
print_head() {
  echo -e "\e[34m>>>>>>>>>>> $1 <<<<<<<<<<<<<<\e[0m"
}
print_head "Install python 3.6 "
yum install python36 gcc python3-devel -y
print_head "add application user"
useradd ${add_user}
print_head "create app directory "
rm -rf /app
mkdir /app
print_head "download application code"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
print_head "unzip code file"
cd /app
unzip /tmp/payment.zip
print_head "Download and Install dependencies"
pip3.6 install -r requirements.txt
print_head "set rabbitmq pwd file"
sed -i -e "s|rabbitmq_user_pwd|${rabbitmq_user_pwd}|" ${script_path}/payment.service
print_head "copy payment service"
cp ${script_path}/payment.service /etc/systemd/system/payment.service
print_head "load, enable and restart the service"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment

