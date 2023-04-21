path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
print_head() {
  echo -e "\e[33m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}
print_head "Install Nginx "
yum install nginx -y
print_head "Download frontend source code "
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
print_head "Remove html folder"
rm -rf /usr/share/nginx/html/*
print_head "change path to html "
cd /usr/share/nginx/html
print_head "unzip frontend folder "
unzip /tmp/frontend.zip
print_head "copy roboshop conf file"
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf
print_head "enable and start nginx "
systemctl enable nginx
systemctl restart nginx

