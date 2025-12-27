output "alb_sg_id" {
    value = aws_security_group.ALB_SG.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_security_group.id
}

output "ec2_sg_id" {
  value = aws_security_group.EC2_SG.id
}