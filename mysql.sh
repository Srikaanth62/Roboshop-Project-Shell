path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
mysql_root_pwd=$1
if [ -z "$mysql_root_pwd" ]; then
  echo MySql password is missing
  exit
  fi
print_head() {
  echo -e "\e[36m>>>>>>>> $1 <<<<<<<<<\e[0m"
}
print_head "Disable sql 8 ver"
dnf module disable mysql -y
print_head "Setup mysql repo file"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
print_head "Install sql server "
yum install mysql-community-server -y
print_head "Enable and start service "
systemctl enable mysqld
systemctl start mysqld
print_head "add application user and pwd "
mysql_secure_installation --set-root-pass ${mysql_root_pwd}
print_head "Restart mysql"
systemctl restart mysqld

