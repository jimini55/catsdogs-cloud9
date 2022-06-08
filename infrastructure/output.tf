# Default tags
output "default_tags" {
  value = {
    "Owner" = "Fahim"
    "App"   = "CatsDogs"
  }
}

output "eip" {
  value = aws_eip.static_eip.public_ip
}

