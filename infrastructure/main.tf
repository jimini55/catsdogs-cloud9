
#----------------------------------------------------------
# EC2 instance creation for docker implementation 
# Build EC2 Instances
#----------------------------------------------------------

#  Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Data block to retrieve the default VPC id
data "aws_vpc" "default" {
  default = true
}

# Retrieve global variables from the Terraform module
module "globalvars" {
  source = "./modules/globalvars"
}

# Define tags locally
locals {
  default_tags = merge(module.globalvars.default_tags, { "env" = var.env })
  prefix       = module.globalvars.prefix
  name_prefix  = "${local.prefix}-${var.env}"
}

# Reference subnet provisioned by 01-Networking 
resource "aws_instance" "my_ec2" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.asg1.key_name
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  associate_public_ip_address = false
  user_data                   = file("docker.sh")

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-EC2"
    }
  )
}


# Adding SSH key to Amazon EC2
resource "aws_key_pair" "asg1" {
  key_name   = local.name_prefix
  public_key = file("asg1.pub")
}

# Security Group
resource "aws_security_group" "my_sg" {
  name        = "allow_ports"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "8080 from everywhere"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "8081 from everywhere"
    from_port        = 8081
    to_port          = 8081
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

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-sg"
    }
  )
}

# Elastic IP
resource "aws_eip" "static_eip" {
  instance = aws_instance.my_ec2.id
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-eip"
    }
  )
}
