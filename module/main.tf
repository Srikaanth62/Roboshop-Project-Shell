module "sample" {
  source = "./example"
  input = module.person.names
}

module "person" {
  source = "./output"
}
