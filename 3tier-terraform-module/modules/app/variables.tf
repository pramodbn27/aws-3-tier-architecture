variable "application" {
  type    = string
  default = "dpt-web"
}

variable "keypair" {
  type    = string
}

variable "dns_name" {
  default    = "app"
}

variable "enable_monitor" {
  type    = string
  default = "true"
}

variable "enable_ebs_optimization" {
  type    = string
  default = "false"
}

variable "notifications_arn" {
  type = string
  default = "arn:aws:sns:us-east-1:576341600583:ed-web-alerts"
}

variable "instance_type" {
  type = string
}

variable "instance_profile" {
  type    = string
}

variable "root_ebs_type" {
  type    = string
  default = "gp2"
}

variable "root_ebs_size" {
  type    = string
  default = "30"
}

variable "root_ebs_del_on_term" {
  type    = string
  default = "true"
}

variable "associate_public_ip_address" {
  type    = string
  default = "false"
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

variable "asg_health_check_grace_period" {
  type = string

  default     = "2"
  description = "AWS Autoscaling Group health check grace period (default: '')"
}

variable "asg_health_check_type" {
  type = string

  default     = "EC2"
  description = "AWS Autoscaling Group health check type (default: 'ELB')"
}

variable "asg_force_delete" {
  default     = true
  description = "AWS Autoscaling Group force delete"
}

variable "asg_termination_policies" {
  type = list(string)

  default     = ["Default"]
  description = "AWS Autoscaling Group termination policies (default: ['Default'])"
}

variable "asg_suspended_processes" {
  type = list(string)

  default     = []
  description = "AWS Autoscaling Group restricted actions (default: [])"
}

variable "asg_min_elb_cap" {
  default     = 0
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes (default: '0')"
}

variable "asg_wait_for_cap" {
  default     = false
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
}

variable "asg_wait_cap_timeout" {
  default     = "0"
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
}

variable "asg_default_cooldown" {
  default     = 60
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
}

variable "asg_enabled_metrics" {
  default = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]

  type        = list(string)
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
}

variable "asg_metrics_granularity" {
  default     = "1Minute"
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
}

variable "asg_protect_from_scale_in" {
  default     = false
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
}