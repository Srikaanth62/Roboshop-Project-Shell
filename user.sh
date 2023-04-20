path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
component=user
func_nodejs
echo -e "\e[34m>>>>>>> copy mongodb repo file <<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[34m>>>>>>> Install mongodb client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>>> load mongodb schema <<<<<<<<\e[0m"
mongo --host mongodb-dev.srikaanth62.online </app/schema/${component}.js
echo -e "\e[34m>>>>>>> restart user service <<<<<<<<\e[0m"
systemctl restart ${component}



