# Define the provider
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

#AMI amazon
data "aws_ami" "ami-amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# default Vpc
data "aws_vpc" "default" {
  default = true
}

#default subnets
resource "aws_default_subnet" "default" {
  availability_zone = "us-east-1a"
  tags = {
    Name = "Subnets"
  }
}

# Create ec2 instance
resource "aws_instance" "deep_vm" {
  ami                    = data.aws_ami.ami-amzn2.id
  key_name               = aws_key_pair.web_key.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.deep_sg.id]
  tags = {
    Name = "LinuxServer-EC2"
    }
} 

#create security_group
resource "aws_security_group" "deep_sg" {
  name        = "allow_http_connectionss"
  description = "Allow http inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
   ingress {
    description      = "Http"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
   ingress {
    description      = "Http"
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = "deep1_key"
  public_key = file("deep1_key.pub")
}

#create ECR
resource "aws_ecr_repository" "assignment1" {
  name                 = "assignment1"
  image_tag_mutability = "MUTABLE"
} 
