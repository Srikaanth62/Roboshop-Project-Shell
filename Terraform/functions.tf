variable "sample" {
  default = "srikaanth"
}

output "name" {
  value = upper(var.sample)
}