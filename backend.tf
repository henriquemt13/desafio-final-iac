terraform {
  backend "s3" {
    bucket = "terraform-state-henrique"
    key = "terraform.tfstate"
    region = "us-east-1"
    
  }
}