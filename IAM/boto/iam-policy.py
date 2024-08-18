import boto3
import json

print("test start")

def policy_create_iam(policy_name, policy_doc):
  
  try:
    policy_create = boto3.client('iam')
    
    response = policy_create.create_policy(
      PolicyName=policy_name,
      PolicyDocument=policy_doc
      
    )
    print(f"IAM policy : {policy_name} -  is created successfully")
    return response
    
  except Exception as e:
    print(f"An error occurred : {e}")
    
if __name__ == "__main__":
  policy_name = "test_access"
    
  policy_doc = {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:Get*",
        "Resource": "*"
      }
    ]
      
  }

    
  policy_document_json = json.dumps(policy_doc)
  policy_create_iam(policy_name, policy_document_json)
print("test end")
