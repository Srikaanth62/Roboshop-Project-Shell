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

variable "sample2" {
  default = {
    xyz = 100
    abc = 200
  }
}

output "sample2" {
  value = lookup(var.sample2, "name", "SRIDEVI" )
}