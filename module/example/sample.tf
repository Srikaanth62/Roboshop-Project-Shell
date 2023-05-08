resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "echo name is ${var.input}"
  }
}

variable "input" {}