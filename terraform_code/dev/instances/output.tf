# Step 10 - Add output variables
output "eip" {
  value = aws_eip.static_eip.public_ip
}