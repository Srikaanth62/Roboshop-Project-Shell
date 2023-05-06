data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-7-DevOps-Practice"
}
/*
resource "aws_instance" "Test" {
  ami = "ami-0bb6af715826253bf"
  instance_type = "t3.micro"
  tags = {
    Name = "Terraform"
  }
} */

output "ami" {
  value = data.aws_ami.centos.image_id
}