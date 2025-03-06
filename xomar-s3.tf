# S3 Bucket
resource "aws_s3_bucket" "website" {
  bucket = var.domain_name

  tags = {
    Name = var.domain_name
  }
}

# Enable Static Website Hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "xomar_public_read" {
  bucket = aws_s3_bucket.website.id  # Ensure this matches your S3 bucket resource

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${var.domain_name}/*"
      }
    ]
  })
}

