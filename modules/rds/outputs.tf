output "rds_port" {
  value = aws_db_instance.rds_instance.port
}

output "rds_endpoint" {
  value = aws_db_instance.rds_instance.address
}