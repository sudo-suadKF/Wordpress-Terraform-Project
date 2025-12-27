output "alb_dns_name" {
  value = aws_lb.ALB.dns_name
}

output "alb_zone_id" {
  value = aws_lb.ALB.zone_id
}