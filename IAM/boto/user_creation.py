import boto3
import random
import string

def generate_password(length=12):
    """Generate a random password."""
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for i in range(length))
  
def get_account_id_from_arn(arn):
    """Extract the account ID from the ARN."""
    return arn.split(":")[4]

def create_iam_user_with_policy_and_console_login(user_name, policy_arn, password=None, description=''):
    # Create an IAM client
    iam = boto3.client('iam')
    
    if not password:
        password = generate_password()

    try:
        # Create the user
        create_user_response = iam.create_user(UserName=user_name)
        print(f"User {user_name} created successfully.")
        
        # Attach the policy to the user
        attach_policy_response = iam.attach_user_policy(
            UserName=user_name,
            PolicyArn=policy_arn
        )
        print(f"Policy {policy_arn} attached to user {user_name} successfully.")
        
        # Enable console login by creating a login profile
        create_login_profile_response = iam.create_login_profile(
            UserName=user_name,
            Password=password,
            PasswordResetRequired=False  # Set to True if you want the user to reset the password on first login
        )
        print(f"Login profile created for user {user_name} with the password: {password}")
        
        #Create access keys to user
        create_access_response =  iam.create_access_key(
          UserName=user_name
          )
        access_key_id = create_access_response['AccessKey']['AccessKeyId']
        secret_access_key = create_access_response['AccessKey']['SecretAccessKey']
        print(f"access_key_id is : {access_key_id} \nsecret_access_key is: {secret_access_key} ")
        
        iam.tag_user(
          UserName=user_name,
          Tags=[
            {
              'Key': 'AccessKeyDescription',
              'Value': description
            }
          ]
        )

        
        return create_user_response, attach_policy_response, create_login_profile_response, access_key_id, secret_access_key
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    user_name = 'rebel_test2'
    policy_arn = 'arn:aws:iam::aws:policy/ReadOnlyAccess'  # Replace with desired policy ARN
    password = generate_password()  # Optional: you can specify a custom password here
    description = "user_key"
    create_iam_user_with_policy_and_console_login(user_name, policy_arn, password, description)
