path=$(realpath "$0")
script_path=$(dirname "$path")
source $script_path/common.sh
component=catalogue
func_nodejs
echo -e "\e[32m>>>>>> copy and Setup mongodb repo <<<<<<<\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
print_head> Install mongodb client <<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
print_head>> load schema <<<<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.srikaanth62.online </app/schema/${component}.js
print_head>> Restart the catalogue service <<<<<<<<<\e[0m"
systemctl restart ${component}
