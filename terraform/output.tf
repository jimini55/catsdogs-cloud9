
output "vpc_id" {
  value = data.aws_vpc.default.id
}

# Add output variable
output "public_ip" {
  value = aws_instance.linux_vm.public_ip
}