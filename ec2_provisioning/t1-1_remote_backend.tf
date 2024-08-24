terraform {
  backend "s3" {
    bucket = "pgr-terraform-state-files"
    key = "ec2-provisioning/terraform.tfstate"
    encrypt = true
    #dynamodb_table = "terraform-lock-table"
    region = "us-east-1"
    
  }
}