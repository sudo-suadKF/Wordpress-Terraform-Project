#Security group for EC2 instances
resource "aws_security_group" "EC2_SG" {
  name        = "EC2_SG"
  description = "Allows ALB inbound traffic and all outbound traffic"
  vpc_id = var.vpc_id

  tags = {
    Name = "EC2_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "EC2_SG_inbound_HTTP_ALB" {
  description = "Allows inbound traffic from ALB"
  security_group_id = aws_security_group.EC2_SG.id
  referenced_security_group_id = aws_security_group.ALB_SG.id
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "EC2_SG_inbound_HTTPS_ALB" {
  description = "Allows inbound traffic from ALB"
  security_group_id = aws_security_group.EC2_SG.id
  referenced_security_group_id = aws_security_group.ALB_SG.id
  ip_protocol = "tcp"
  from_port = 443
  to_port = 443
}

resource "aws_vpc_security_group_ingress_rule" "EC2_SG_inbound_SSH" {
  description = "Allows SSH from my IP"
  security_group_id = aws_security_group.EC2_SG.id
  cidr_ipv4         = var.my_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "EC2_SG_outbound" {
  description = "Allows all traffic as outbound"
  security_group_id = aws_security_group.EC2_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


# RDS security group
resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "RDS Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "RDS_SG_inbound" {
  description = "Allows inbound traffic from EC2 instances"
  security_group_id = aws_security_group.rds_security_group.id
  referenced_security_group_id = aws_security_group.EC2_SG.id
  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "RDS_SG_outbound" {
  description = "Allows all traffic as outbound"
  security_group_id = aws_security_group.rds_security_group.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = "-1"
}

resource "aws_security_group" "ALB_SG" {
  name        = "ALB_SG"
  description = "Allow internet traffic to ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ALB_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ALB_SG_HTTPS" {
  description = "Allows HTTPS traffic from Internet"
  security_group_id = aws_security_group.ALB_SG.id
  cidr_ipv4         = var.internet_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "ALB_SG_HTTP" {
  description = "Allows HTTP traffic from Internet"
  security_group_id = aws_security_group.ALB_SG.id
  cidr_ipv4         = var.internet_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "ALB_SG_Outbound_All_Traffic" {
  description = "Allows all outbound traffic from ALB"
  security_group_id = aws_security_group.ALB_SG.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = "-1"
}