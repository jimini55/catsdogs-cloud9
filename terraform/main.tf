# Define the provider
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

<<<<<<< HEAD
#AMI amazon
=======
#Fetch Amazon AMI
>>>>>>> 08689758ca831dd0a0e3cc84bec8480d3d7d4b2d
data "aws_ami" "ami-amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

<<<<<<< HEAD
# default Vpc
=======
# Get VPC id of default VPC
>>>>>>> 08689758ca831dd0a0e3cc84bec8480d3d7d4b2d
data "aws_vpc" "default" {
  default = true
}

<<<<<<< HEAD
#default subnets
=======
>>>>>>> 08689758ca831dd0a0e3cc84bec8480d3d7d4b2d
resource "aws_default_subnet" "default" {
  availability_zone = "us-east-1a"
  tags = {
    Name = "Subnets"
  }
}

<<<<<<< HEAD
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
  name        = "allow_http_connections"
=======
# Create Amazon Linux EC2 instances in a default VPC
resource "aws_instance" "linux_vm" {
  ami                    = data.aws_ami.ami-amzn2.id
  key_name               = aws_key_pair.web_key.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.linux_sg.id]
  tags = {
    Name = "LinuxServer-EC2"
    }
}

resource "aws_security_group" "linux_sg" {
  name        = "allow_http_conn"
>>>>>>> 08689758ca831dd0a0e3cc84bec8480d3d7d4b2d
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
<<<<<<< HEAD
  key_name   = "deep1_key"
  public_key = file("deep1_key.pub")
}

#create ECR
resource "aws_ecr_repository" "assignment1" {
  name                 = "assignment1"
=======
  key_name   = "linux_key"
  public_key = file("linux_key.pub")
}


resource "aws_ecr_repository" "clo835-assignment1" {
  name                 = "clo835-assignment1"
>>>>>>> 08689758ca831dd0a0e3cc84bec8480d3d7d4b2d
  image_tag_mutability = "MUTABLE"
} 
