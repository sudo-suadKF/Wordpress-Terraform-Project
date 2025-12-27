output "cert_arn" {
  value = aws_acm_certificate_validation.HTTPS_validation_cert.certificate_arn
}