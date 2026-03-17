# dns.tf
resource "aws_route53_record" "livekit" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "livekit.yourdomain.com"
  type    = "A"

  alias {
    name                   = module.eks.cluster_endpoint
    zone_id                = data.aws_lb.livekit_nlb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "turn" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "turn.yourdomain.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.turn.public_ip]
}
