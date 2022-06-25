# Define the provider
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

#Fetch Amazon AMI
data "aws_ami" "ami-amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Get VPC id of default VPC
data "aws_vpc" "default" {
  default = true
}

resource "aws_default_subnet" "default" {
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnets"
  }
}

# Create Amazon Linux EC2 instances in a default VPC
resource "aws_instance" "deep_vm" {
  ami                    = data.aws_ami.ami-amzn2.id
  key_name               = aws_key_pair.web_key.key_name
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.linux_sg.id]
  iam_instance_profile   = "LabInstanceProfile"
  user_data              = file("Docker.sh")
  root_block_device {
    volume_size = 16
  }
  tags = {
    Name = "EC2"
  }
}

resource "aws_security_group" "linux_sg" {
  name        = "allow_http_conn"
  description = "Allow http inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Http"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Http"
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = "linux_key"
  public_key = file("linux_key.pub")
}

resource "aws_ecr_repository" "imagecat" {
  name                 = "cats"
  image_tag_mutability = "MUTABLE"
}
resource "aws_ecr_repository" "imagedog" {
  name                 = "dogs"
  image_tag_mutability = "MUTABLE"
}