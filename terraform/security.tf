resource "aws_security_group" "allow_internal" {
  name        = "allow_internal"
  description = "Allow interla inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "internal from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "allow_external" {
  name        = "allow_external"
  description = "Allow external inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "traffic from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
