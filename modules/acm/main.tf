resource "aws_acm_certificate" "cert_HTTPS" {
  domain_name       = var.alb_domain_name
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "HTTPS_validation_cert" {
  certificate_arn         = aws_acm_certificate.cert_HTTPS.arn
  validation_record_fqdns = [for record in aws_route53_record.Validation : record.fqdn]
}

data "aws_route53_zone" "MyHostedZone" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "Validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert_HTTPS.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.MyHostedZone.zone_id
}