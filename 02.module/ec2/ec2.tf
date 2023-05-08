resource "aws_instance" "Instance" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = "var.sg_grp"
  tags = {
    Name = "Srikaanth"
  }
}

data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

variable "sg_grp" {}
