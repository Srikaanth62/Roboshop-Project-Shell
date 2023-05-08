module "ec2" {
  source = "./ec2"
  sg_grp = module.sg.sggrp
}

module "sg" {
  source = "./sg"
}