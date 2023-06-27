# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "issue_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.issue_vpc.id

  ingress {
    protocol  = "-1"
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}