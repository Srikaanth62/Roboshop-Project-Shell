resource "aws_instance" "Test" {
  ami = "ami-0bb6af715826253bf"
  instance_type = "t3.micro"
  tags = {
    Name = "Terraform"
  }
}