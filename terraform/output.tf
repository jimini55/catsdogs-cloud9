
output "vpc_id" {
  value = data.aws_vpc.default.id
}

# Add output variable
output "public_ip" {
<<<<<<< HEAD
  value = aws_instance.deep_vm.public_ip
=======
  value = aws_instance.linux_vm.public_ip
>>>>>>> 08689758ca831dd0a0e3cc84bec8480d3d7d4b2d
}