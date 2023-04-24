path=$(realpath "$0")
script_path=$(dirname "$path")
source ${script_path}/common.sh
component=payment
rabbitmq_user_pwd=$1
if [ -z "$rabbitmq_user_pwd" ]; then
  echo RabbitMQ password is missing
  exit
  fi
