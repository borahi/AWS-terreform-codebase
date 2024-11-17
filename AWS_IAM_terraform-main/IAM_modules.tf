terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "users-group" {
  source = "./user_n_group"

}

module "name" {
  source = "./add_users_2_group"
  users-list = module.users-group.ITOC_users
  group_name = module.users-group.ITOC_group

}


output "group_name" {
    value = module.users-group.ITOC_group
  
}

output "user_list" {
  value = module.users-group.ITOC_users
}
