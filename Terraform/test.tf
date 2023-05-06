data "aws_ami" "centos" {
  most_recent      = true
  name_regex       = "Devops-Practice"
  owners           = ["973714476881"]
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