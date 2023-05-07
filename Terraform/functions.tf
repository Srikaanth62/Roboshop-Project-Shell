variable "sample" {
  default = "srikaanth"
}

output "name" {
  value = upper(var.sample)
}

variable "sample1" {
  default = [ "sri", "kanth" ]
}

output "sample1" {
  value = element (var.sample1,0)
}