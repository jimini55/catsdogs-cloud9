
output "public_ip" {
  value = aws_instance.deep_vm.public_ip
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}
