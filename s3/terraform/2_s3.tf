#Create bucket
resource "aws_s3_bucket" "demo_bucket" {
  count = 10
    bucket = "pgr-automation-143-${count.index}"
    
    tags = {
      Name = "pgr-automation-143-${count.index}"
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
resource "aws_s3_bucket_lifecycle_configuration" "demo_bucket-lc" {
  bucket = aws_s3_bucket.demo_bucket.id
  rule {
    id = "rule-demo_bucket"
    status = "Enabled"
    ## Transition to Standard-IA after 30 days
    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }
    # Transition to One Zone-IA after 60 days
    #transition {
    #  days          = 60
    #  storage_class = "ONEZONE_IA"
    #}
    # Transition to Glacier Instant Retrieval after 90 days
    transition {
      days          = 90
      storage_class = "GLACIER_IR"
    }
    # Transition to Glacier Flexible Retrieval after 120 days
    transition {
      days = 180
      storage_class = "GLACIER"
    }
    # Transition to Glacier Deep Archive after 180 days |
    transition {
      days          = 280
      storage_class = "DEEP_ARCHIVE"
    }
    # Optionally, you can set an expiration for these objects
    expiration {
      days = 365
    }
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class = "STANDARD_IA"

    }
    #noncurrent_version_transition {
    #  noncurrent_days = 60
    #  storage_class = "ONEZONE_IA"
    #}
     noncurrent_version_transition {
      noncurrent_days = 90
      storage_class = "GLACIER_IR"
    }
    noncurrent_version_transition {
      noncurrent_days = 180
      storage_class = "GLACIER"
    }
    noncurrent_version_transition {
      noncurrent_days = 280
      storage_class = "DEEP_ARCHIVE"
    }
    noncurrent_version_expiration {
      noncurrent_days = 365
    }


  }
  
}
resource "aws_s3_bucket_metric" "demo_bucket_metrics" {
  bucket = aws_s3_bucket.demo_bucket.id
  name = "demo_bucket_metrics"
  
}


