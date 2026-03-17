# security_groups.tf
resource "aws_security_group" "livekit_media" {
  name_prefix = "livekit-media-"
  vpc_id      = module.vpc.vpc_id

  # WebSocket signaling (via NLB)
  ingress {
    from_port   = 7880
    to_port     = 7880
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "LiveKit HTTP/WebSocket signaling"
  }

  # LiveKit API (internal)
  ingress {
    from_port   = 7881
    to_port     = 7881
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "LiveKit internal RPC"
  }

  # WebRTC UDP media range
  ingress {
    from_port   = 50000
    to_port     = 60000
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "WebRTC UDP media (ICE, DTLS-SRTP)"
  }

  # TURN TCP fallback
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "TURN over TLS (TCP fallback)"
  }

  # STUN
  ingress {
    from_port   = 3478
    to_port     = 3478
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "STUN binding requests"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "livekit-media-sg"
  }
}
