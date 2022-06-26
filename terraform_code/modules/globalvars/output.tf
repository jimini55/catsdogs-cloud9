# Default tags
output "default_tags" {
  value = {
    "Owner" = "kajal"
    "App"   = "Web"
    "assignment" = "CLO835-asssignment1"
  }
}

# Prefix to identify resources
output "prefix" {
  value     = "assignment1"
}