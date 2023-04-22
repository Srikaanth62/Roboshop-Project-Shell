path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
print_head() {
  echo -e "\e[34m>>>>>>>>>>> $1 <<<<<<<<<<<<<<\e[0m"
}
component=user
func_nodejs
print_head "copy mongodb repo file "
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
print_head "Install mongodb client"
yum install mongodb-org-shell -y
print_head "load mongodb schema "
mongo --host mongodb-dev.srikaanth62.online </app/schema/${component}.js
print_head "restart user service "
systemctl restart ${component}



