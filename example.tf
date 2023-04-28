/* resource "aws_instance" "web" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "Srikaanth"
  }
}*/


data "aws_security_group" "allow-all" {
  Name = "allow-all"
}

output "SG" {
  value = [ data.aws_security_group.allow-all.id ]
}