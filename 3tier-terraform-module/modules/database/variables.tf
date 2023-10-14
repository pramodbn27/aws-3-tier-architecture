variable "project" {
  default = "eos"
}

variable "latest_snapshot_id" {
}
variable "env" {
  type = string
  description = "EOS Environment"
}

variable "allocated_storage" {
  default = "50"
}

variable "engine_version" {
  default = "5.7.37"
}

variable "rds_instance_type" {
  description = "RDS Instance Type"
}

variable "storage_type" {
  default = "gp2"
}

variable "insufficient_data_actions" {
  default = "[]"
  
}

variable "iops" {
  default = "0"
}

variable "vpc_id" {}

variable "database_identifier" {}

variable "database_name" {}

variable "database_admin_user" {

}

variable "database_admin_password" {
  
}

variable "database_port" {
  default = "3306"
}

variable "backup_retention_period" {
  default = "30"
}

variable "backup_window" {
  # 12:00AM-12:30AM ET
  default = "04:00-04:30"
}

variable "maintenance_window" {
  # SUN 12:30AM-01:30AM ET
  default = "sun:04:30-sun:05:30"
}

variable "auto_minor_version_upgrade" {
  default = true
}

variable "snapshot_identifier" {
  default = "eos-rds-snapshot"
}

variable "final_snapshot_identifier" {
  default = "eos-rds-snapshot"
}

variable "skip_final_snapshot" {
  default = true
}

variable "copy_tags_to_snapshot" {
  default = false
}

variable "multi_availability_zone" {
  default = false
}

variable "storage_encrypted" {
  default = true
}

variable "monitoring_interval" {
  default = "0"
}

variable "parameter_group" {
  default = "default.mysql5.7"
}

variable "alarm_cpu_threshold" {
  default = "75"
}

variable "alarm_disk_queue_threshold" {
  default = "10"
}

variable "alarm_free_disk_threshold" {
  # 5GB
  default = "5000000000"
}

variable "alarm_free_memory_threshold" {
  # 128MB
  default = "128000000"
}

variable "alarm_cpu_credit_balance_threshold" {
  default = "30"
}