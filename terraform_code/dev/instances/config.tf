terraform {
  backend "s3" {
    bucket = "kajalsodhi-assignment1" // Bucket where to SAVE Terraform State
    key    = "dev/terraform.tfstate"  // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"              // Region where bucket is created
  }
}