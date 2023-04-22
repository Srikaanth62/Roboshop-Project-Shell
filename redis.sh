path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
print_head() {
  echo -e "\e[34m>>>>>>>>>>> $1 <<<<<<<<<<<<<<\e[0m"
}
print_head "Install redis repo file "
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
print_head "Enable Redis 6.2 from package streams "
dnf module enable redis:remi-6.2 -y
print_head "Install redis "
yum install redis -y
print_head "update listen address "
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf
## Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf & /etc/redis/redis.conf
print_head "Enable and restart the redis service"
systemctl enable redis
systemctl restart redis


