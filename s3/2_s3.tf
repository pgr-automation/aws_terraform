#Create bucket
resource "aws_s3_bucket" "demo_bucket" {
    bucket = "pgr-automation-143"
    
    tags = {
      Name = "pgr-automation-143"
      Environment = "Dev"
    }
}

#Enable Version of Bucket
resource "aws_s3_bucket_versioning" "demo_bucket-v" {
  bucket = aws_s3_bucket.demo_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  
}



