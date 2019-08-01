
provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

resource "aws_eip_association" "ip_asociacionA" {
  instance_id   = "${aws_instance.AppA.id}"
  allocation_id = "eipalloc-0ed34586c8d5921e3"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "UTEC" {
  name        = "UTECA"
  description = "Reglas de seguridad para instancia ec2"
  vpc_id      = "${aws_default_vpc.default.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }
}


resource "aws_instance" "AppA" {
  ami           = "ami-0f2b4fc905b0bd1f1"
  instance_type = "t2.micro"
  key_name = "utec"
  vpc_security_group_ids = ["${aws_security_group.UTEC.id}"]
  tags = {
    Name = "AppA"
  }
}