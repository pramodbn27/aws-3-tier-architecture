variable "application" {
  type = string
}

variable "rds_instance_type" {}
variable "latest_snapshot_id" {}
variable "env" {}
variable "database_name" {}
variable "database_identifier" {}
variable "keypair" {
  type = string
}



variable "instance_type" {
  type = string
}

variable "instance_profile" {
  type = string
}

variable "asg_max_cap" {
  type        = string
  description = "AWS Autoscaling Group Max Capacity for Dispatcher Nodes"
}

variable "asg_min_cap" {
  type        = string
  description = "AWS Autoscaling Group Min Capacity for Dispatcher Nodes"
}

variable "asg_desired_cap" {
  type        = string
  description = "AWS Autoscaling Group Desired Capacity for Dispatcher Nodes"
}


