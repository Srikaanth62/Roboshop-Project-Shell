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
} */

variable "test" {
  default = "This is DevOps"
}

output "result" {
  value = "Which course is this. ${var.test}"
}