#---------------------------------------------------------------------------------------
# Note: This record expects that the hosted zone already existed.
#---------------------------------------------------------------------------------------
data "aws_route53_zone" "hosted-zone" {
  name         = "${var.hosted-zone-name}"
  private_zone = false
}

resource "aws_route53_record" "dns-record" {
  zone_id = "${data.aws_route53_zone.hosted-zone.zone_id}"
  name    = "${var.subdomain}.${var.hosted-zone-name}"
  type    = "A"

  alias {
    name                   = "${var.lb-dns}"
    zone_id                = "${var.lb-zone-id}"
    evaluate_target_health = false
  }
}

