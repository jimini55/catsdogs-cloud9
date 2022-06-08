# Default tags
output "default_tags" {
  value = {
    "Owner" = "Bari"
    "App"   = "Web"
    "Project" = "CLO835"
  }
}

# Prefix to identify resources
output "prefix" {
  value     = "ari-asg-1"
}