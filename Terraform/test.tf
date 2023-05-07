/* data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

resource "aws_instance" "Test" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  tags = {
    Name = "Terraform"
  }
}

resource "aws_route53_record" "hostedzone" {
  zone_id = "Z088180210HCZBPL2XI2M"
  name    = "test-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.Test.private_ip]
}


output "ami" {
  value = data.aws_ami.centos.image_id
}

variable "test" {
  default = "This is DevOps"
}

output "result" {
  value = "Which course is this. ${var.test}"
}

variable "list" {
  default = [
  "hello",
   9676166557,
    true
  ]
}

output "list" {
  value = var.list[1]
}

variable "sample_map" {
  default = {
    number = 9676166557
    name = "srikaanth"
    boolean = true
  }
}

output "sample_map" {
  value = var.sample_map["name"]
}

variable "env" {}

variable "auto_boolean" {}
variable "sample1" {}

output "envi" {
  value = var.env
}

output "auto_boolean" {
  value = var.auto_boolean
}
output "sample" {
  value = var.sample1
}

data "aws_security_group" "allow-all" {
  name = "allow-all"
}

output "security_group" {
  value = data.aws_security_group.allow-all.id
} *//*


#resource "null_resource" "fruits" {
#  count = length(var.fruits)
#}
#
# provisioner "local-exec" {
#  command = "echo fruits name ${var.fruits[count.index]}"
#}
#
#
#variable "fruits" {
#  default = [ "apple", "banana", "orange" ]
#}

*/
/*resource "null_resource" "test" {
  for_each = var.names
  provisioner "local-exec" {
    command = "echo names is ${each.key} = ${each.value}"
  }
}

variable "names" {
  default = {
    Srikaanth = 10

    Sridevi = 20
    }
}*//*


variable "cloths" {
  default = {
    srikaanth = {
      Shirts = 10
      Jeans = 15
    }
    sridevi = {
      tops = 20
      leggins = 30
    }
  }
}

resource "null_resource" "cloths" {
  for_each = var.cloths
  provisioner "local-exec" {
    command = "echo details ${each.key} and ${each.value["tops"]}"
  }
}
*/
