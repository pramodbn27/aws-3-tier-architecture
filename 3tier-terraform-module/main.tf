#configure provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

data "aws_secretsmanager_secret" "rds" {
  name = "ed-rds-01"
}
data "aws_secretsmanager_secret_version" "db" {
  secret_id = "${data.aws_secretsmanager_secret.rds.id}"
}

locals {
  database_admin_secret = jsondecode(
    data.aws_secretsmanager_secret_version.db.secret_string
  )
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  workspace = "default"
  config = {
    bucket         = "ed-eos-terraform-state"
    key            = "eos/vpc/terraform.tfstate"
    region         = "us-east-1"
  }
}

module "web" {
  source              = "./modules/webserver"
  instance_type = var.instance_type
  instance_profile = var.instance_profile
  keypair = var.keypair
  asg_min_cap = var.asg_min_cap
  asg_max_cap = var.asg_max_cap
  asg_desired_cap = var.asg_desired_cap   
}

module "app" {
  source              = "./modules/app"
  instance_type = var.instance_type
  instance_profile = var.instance_profile
  keypair = var.keypair
  asg_min_cap = var.asg_min_cap
  asg_max_cap = var.asg_max_cap
  asg_desired_cap = var.asg_desired_cap   
}


module "database" {
  source              = "./modules/database"
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  database_identifier = var.database_identifier
  database_name       = var.database_name
  database_admin_user  = local.database_admin_secret.username
  database_admin_password  = local.database_admin_secret.password
  env                 = var.env
  latest_snapshot_id  = var.latest_snapshot_id
  rds_instance_type    = var.rds_instance_type
}