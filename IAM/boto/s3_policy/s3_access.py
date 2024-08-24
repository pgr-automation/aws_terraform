import boto3
import json

# Client setup
iam = boto3.client('iam')

user_name = input("Please enter User name: ")

print(user_name)

bucket_names = input("Enter the S3 bucket names separated by a comma: ").split(',')

print(bucket_names)
policy_statements = []
for bucket_name in bucket_names:
    bucket_name = bucket_name.strip()
    print(bucket_name) 
    policy_statements.append(
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                f"arn:aws:s3:::{bucket_name}"
            ]
        }
    )
    policy_statements.append(
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                f"arn:aws:s3:::{bucket_name}/*"
            ]
        }
    )
policy_document = {
    "Version": "2012-10-17",
    "Statement": policy_statements
}
