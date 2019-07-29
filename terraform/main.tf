provider "aws" {
  access_key = "AKIAJIX3VBPKATQE3YFA"
  secret_key = "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"
  region     = "us-east-1"
}

resource "aws_key_pair" "admin" {
  key_name   = "admin-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGesdyk7w8VIBtL+pkDS/poTiuez7QfVc/GJ/7LWByPBFwIGxNMKckOb6jmk9nPAI+1o2aFM042+PS+yBX7pWX5CUJfee6fMjkOlobX1oVDEmKSlfxRbEeEkyqzzDHa8L72gerS9TD9jOl78PDjK/rb05sAWiOwV2Vs71dUh5A5IZ7K7xMsvkMscb+AOhsvlhiqbd6Eqf3NRduQ5WoC+3Kmn0RqXvX6a8KSv/MRCeOEfPvaOCYB3LP2c0M4RwJGzqzkNW9zDEnvsWrPhKjqUjenM6kwJzi7t+xjIMLZk8KTN/KwOQUDQ26VNFyDn0mykqyVGNTZdGUq0e3OOkcaAFp bernardo@localhost.localdomain"
}

resource "aws_eip" "Loysa_elastic_ip" {
  tags = {
    Name = "Loysa_IP"
  }
}

resource "aws_eip_association" "ip_asociacion" {
  instance_id   = "${aws_instance.Loysa_EC2.id}"
  allocation_id = "${aws_eip.Loysa_elastic_ip.id}"
}


resource "aws_default_vpc" "default" {}


resource "aws_security_group" "Loysa-RDS" {
  name        = "Loysa-RDS"
  description = "Reglas de seguridad para instancia rds"
  vpc_id      = "${aws_default_vpc.default.id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
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

resource "aws_security_group" "Loysa-EC2" {
  name        = "Loysa-EC2"
  description = "Reglas de seguridad para instancia ec2"
  vpc_id      = "${aws_default_vpc.default.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
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



resource "aws_db_instance" "Loysa-DB" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.6"
  instance_class       = "db.t2.micro"
  name                 = "webgr"
  username             = "webgr"
  password             = ".buitres!"
  vpc_security_group_ids = ["${aws_security_group.Loysa-RDS.id}"]
}

resource "aws_instance" "Loysa_EC2" {
  ami           = "ami-01d5b8c6e4958a724"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.Loysa-EC2.id}"]
  tags = {
    Name = "Loysa_server"
  }

}