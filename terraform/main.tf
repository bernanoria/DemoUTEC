
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
  version = "~> 2.21"
}

resource "aws_eip" "utecA" {
  tags = {
    Name = "AppA_IP"
  }
}

resource "aws_eip" "utecB" {
  tags = {
    Name = "AppB_IP"
  }
}

resource "aws_eip_association" "ip_asociacionA" {
  instance_id   = "${aws_instance.AppA.id}"
  allocation_id = "${aws_eip.utecA.id}"
}

resource "aws_eip_association" "ip_asociacionB" {
  instance_id   = "${aws_instance.AppB.id}"
  allocation_id = "${aws_eip.utecB.id}"
}



resource "aws_default_vpc" "default" {}


resource "aws_security_group" "UTEC" {
  name        = "UTEC"
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
  ami           = "ami-02eac2c0129f6376b"
  instance_type = "t2.micro"
  key_name = "utec"
  vpc_security_group_ids = ["${aws_security_group.UTEC.id}"]
  tags = {
    Name = "AppA"
  }
}

resource "aws_instance" "AppB" {
  ami           = "ami-02eac2c0129f6376b"
  instance_type = "t2.micro"
  key_name = "utec"
  vpc_security_group_ids = ["${aws_security_group.UTEC.id}"]
  tags = {
    Name = "AppB"
  }

}