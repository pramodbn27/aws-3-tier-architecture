output "id" {
  value = "${aws_db_instance.mysql.id}"
}

output "database_security_group_id" {
  value = "${aws_security_group.mysql.id}"
}

output "hosted_zone_id" {
  value = "${aws_db_instance.mysql.hosted_zone_id}"
}

output "hostname" {
  value = "${aws_db_instance.mysql.address}"
}

output "port" {
  value = "${aws_db_instance.mysql.port}"
}

output "endpoint" {
  value = "${aws_db_instance.mysql.endpoint}"
}
