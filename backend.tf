terraform {
  backend "s3" {
    bucket         = "tf-state-xomar"  # Match the bucket name
    key            = "terraform.tfstate"  # State file path inside S3
    region         = "us-east-1"  # Change if needed
    encrypt        = true
  }
}
