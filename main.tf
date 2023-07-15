provider "aws" {}

resource "aws_security_group" "sg" {
  name_prefix = "${var.project_name}-${var.project_env}-"
  description = "Allow ssh,http"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name"    = "${var.project_name}-${var.project_env}",
    "project" = var.project_name,
    "env"     = var.project_env
  }

}

resource "aws_instance" "dbserver" {
  ami                    = "ami-0d13e3e640877b0b9"
  instance_type          = "t2.micro"
  key_name               = "mumbai-new"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    "Name"    = "${var.project_name}-${var.project_env}-dbserver",
    "project" = var.project_name,
    "env"     = var.project_env
  }
}


