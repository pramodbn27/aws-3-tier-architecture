data "terraform_remote_state" "vpc" {
  backend = "s3"
  workspace = "default"
  config = {
    bucket         = "ed-eos-terraform-state"
    key            = "eos/vpc/terraform.tfstate"
    region         = "us-east-1"
  }
}

# Security group resources

resource "aws_security_group" "mysql" {
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port           = 3306
    to_port               = 3306
    protocol              = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }

  egress {
      from_port         = 0
      to_port           = 0
      protocol          = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "eos-${var.env}-rds-sg"
    Project     = "${var.project}"
    Environment = "${var.env}"
  }
}


data "aws_sns_topic" "sns" {
name = "ed-web-alerts"
}

# RDS resources
resource "aws_db_subnet_group" "db" {
  description = "subnet group"
  name        = "eos-database-group"
  subnet_ids  = [data.terraform_remote_state.vpc.outputs.priv_subnet1, data.terraform_remote_state.vpc.outputs.priv_subnet2]
}

resource "aws_db_instance" "mysql" {
  snapshot_identifier        = "${var.latest_snapshot_id}"
  allocated_storage          = "${var.allocated_storage}"
  engine                     = "mysql"
  engine_version             = "${var.engine_version}"
  identifier                 = "${var.database_identifier}"
  instance_class             = "${var.rds_instance_type}"
  storage_type               = "${var.storage_type}"
  iops                       = "${var.iops}"
  db_name                    = "${var.database_name}"
  password                   = "${var.database_admin_password}"
  username                   = "${var.database_admin_user}"
  backup_retention_period    = "${var.backup_retention_period}"
  backup_window              = "${var.backup_window}"
  maintenance_window         = "${var.maintenance_window}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  final_snapshot_identifier  = "${var.final_snapshot_identifier}"
  skip_final_snapshot        = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot      = "${var.copy_tags_to_snapshot}"
  multi_az                   = "${var.multi_availability_zone}"
  port                       = "${var.database_port}"
  vpc_security_group_ids     = ["${aws_security_group.mysql.id}"]
  db_subnet_group_name       = "${aws_db_subnet_group.db.name}"
  parameter_group_name       = "${var.parameter_group}"
  storage_encrypted          = "${var.storage_encrypted}"
  monitoring_interval        = "${var.monitoring_interval}"
  ca_cert_identifier         = "rds-ca-2019"

  tags = {
    Name        = "is-${var.env}-kong-rds"
    Project     = "${var.project}"
    Environment = "${var.env}"
  }
}

# CloudWatch resources
#
resource "aws_cloudwatch_metric_alarm" "database_cpu" {
  alarm_name          = "alarm${var.env}-DatabaseServerCPUUtilization-${var.database_identifier}"
  alarm_description   = "Database server CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_threshold}"

  dimensions = {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions             = ["${data.aws_sns_topic.sns.arn}"]
  ok_actions                = ["${data.aws_sns_topic.sns.arn}"]
  insufficient_data_actions = ["${data.aws_sns_topic.sns.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "database_disk_queue" {
  alarm_name          = "alarm${var.env}-DatabaseServerDiskQueueDepth-${var.database_identifier}"
  alarm_description   = "Database server disk queue depth"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_disk_queue_threshold}"

  dimensions = {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions             = ["${data.aws_sns_topic.sns.arn}"]
  ok_actions                = ["${data.aws_sns_topic.sns.arn}"]
  insufficient_data_actions = ["${data.aws_sns_topic.sns.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "database_disk_free" {
  alarm_name          = "alarm${var.env}-DatabaseServerFreeStorageSpace-${var.database_identifier}"
  alarm_description   = "Database server free storage space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_free_disk_threshold}"

  dimensions = {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions             = ["${data.aws_sns_topic.sns.arn}"]
  ok_actions                = ["${data.aws_sns_topic.sns.arn}"]
  insufficient_data_actions = ["${data.aws_sns_topic.sns.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "database_memory_free" {
  alarm_name          = "alarm${var.env}-DatabaseServerFreeableMemory-${var.database_identifier}"
  alarm_description   = "Database server freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_free_memory_threshold}"

  dimensions = {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions             = ["${data.aws_sns_topic.sns.arn}"]
  ok_actions                = ["${data.aws_sns_topic.sns.arn}"]
  insufficient_data_actions = ["${data.aws_sns_topic.sns.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "database_cpu_credits" {
  count               = "${substr(var.rds_instance_type, 0, 3) == "db.t" ? 1 : 0}"
  alarm_name          = "alarm${var.env}-DatabaseCPUCreditBalance-${var.database_identifier}"
  alarm_description   = "Database CPU credit balance"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUCreditBalance"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_credit_balance_threshold}"

  dimensions = {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions             = ["${data.aws_sns_topic.sns.arn}"]
  ok_actions                = ["${data.aws_sns_topic.sns.arn}"]
  insufficient_data_actions = ["${data.aws_sns_topic.sns.arn}"]
}
