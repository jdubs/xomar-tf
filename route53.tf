data "aws_route53_zone" "domain" {
  name         = "${var.domain_name}." # Replace with your domain name (must end with a dot)
  private_zone = false                 # Set to true if it's a private hosted zone
}

# Create an ALIAS record for the root domain (xomar.com)
resource "aws_route53_record" "root_domain" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# Create ALIAS records for subdomains (www.xomar.com, api.xomar.com, etc.)
resource "aws_route53_record" "subdomains" {
  for_each = toset(var.subdomains)

  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${each.key}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
