#rds subnet
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [var.private_subnet1_id, var.private_subnet2_id]
}
#RDS INSTANCE
resource "aws_db_instance" "rds_instance" {
  engine                    = "mysql"
  engine_version            = "8.0"
  skip_final_snapshot       = true
  final_snapshot_identifier = "my-final-snapshot"
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  identifier                = "my-rds-instance"
  db_name                   = var.db_name
  username                  = var.username
  password                  = var.password
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids    = [var.rds_sg_id]

  tags = {
    Name = "RDS Instance"
  }
}