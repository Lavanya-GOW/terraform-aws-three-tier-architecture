terraform {
  backend "s3" {
    bucket         = "my-first-3-tier-architecture-s3-backend-bucket"
    key            = "production/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "3-tier-architecture-table"

  }
}