#---------------------------------------------------------------------------------------
# Note: This record expects that the hosted zone already existed.
#---------------------------------------------------------------------------------------
data "aws_route53_zone" "hosted-zone" {
  name         = var.hosted-zone-name
  private_zone = false
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain
  validation_method         = "DNS"
  subject_alternative_names = var.alternative-names

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  records = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert-verification" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}


