

output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "public_ip" {
  value = aws_instance.my_ami.public_ip
} 