/* variable "devops" {
  default = "devops engineer"
}

output "result" {
  value = var.devops
}

output "who" {
  value = "The Role is ${var.devops} "
}

variable "list" {
  default = [
    100,
    "hello",
    10.6,
    true
  ]
}

output "All" {
  value = var.list[2]
}

variable "boolean" {
  default = false
}

output "boolean" {
  value = var.boolean
}

variable "num" {
  default = 1995
}

output "num" {
  value = var.num
}

variable "dict" {
  default = {
    year = 1995
    Name = "Sridevi"
    Boolean = true
    date = 1303
  }
}

output "details" {
  value = var.dict["Name"]
}
