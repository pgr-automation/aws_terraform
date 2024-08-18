import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError
import json

def create_policy(policy_name, policy_document):
    """
    Create an IAM policy.

    Parameters:
    policy_name (str): The name of the IAM policy.
    policy_document (str): The JSON policy document defining permissions.

    Returns:
    dict: The response containing information about the created policy.
    """
    try:
        # Create an IAM client
        iam = boto3.client('iam')

        # Create the IAM policy
        response = iam.create_policy(
            PolicyName=policy_name,
            PolicyDocument=policy_document
        )

        print(f"IAM policy '{policy_name}' created successfully.")
        return response

    except iam.exceptions.EntityAlreadyExistsException:
        print(f"IAM policy '{policy_name}' already exists.")
    except (NoCredentialsError, PartialCredentialsError):
        print("Credentials not available.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    # Replace 'your-policy-name' with the desired IAM policy name
    policy_name = 'your-policy-name'

    # Define the policy document in JSON format
    policy_document = {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "s3:Get*",
                "Resource": "*"
            }
        ]
    }

    # Convert policy document to JSON string
    policy_document_json = json.dumps(policy_document)

    # Create IAM policy
    create_policy(policy_name, policy_document_json)
