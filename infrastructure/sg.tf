resource "aws_security_group" "neptune_sg" {
  name        = "neptune-sg"
  description = "Allow Neptune traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 8182
    to_port   = 8182
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
