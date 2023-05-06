data "aws_ami" "centos" {
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

/*
output "ami" {
  value = data.aws_ami.centos.image_id
} */
