
# Add output variables
#vpc output
output "vpc_id" {
  value = data.aws_vpc.default.id
}

# Add output variables
output "public_ip" {
  value = aws_instance.linux_vm.public_ip
}