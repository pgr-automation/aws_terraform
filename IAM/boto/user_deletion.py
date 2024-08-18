import boto3

def delete_iam_user(user_name):
    # Create an IAM client
    iam = boto3.client('iam')
    
    try:
        # Detach all managed policies
        attached_policies = iam.list_attached_user_policies(UserName=user_name)['AttachedPolicies']
        for policy in attached_policies:
            iam.detach_user_policy(UserName=user_name, PolicyArn=policy['PolicyArn'])
            print(f"Detached policy {policy['PolicyArn']} from user {user_name}.")

        # Delete all inline policies
        inline_policies = iam.list_user_policies(UserName=user_name)['PolicyNames']
        for policy_name in inline_policies:
            iam.delete_user_policy(UserName=user_name, PolicyName=policy_name)
            print(f"Deleted inline policy {policy_name} from user {user_name}.")

        # Delete the login profile
        try:
            iam.delete_login_profile(UserName=user_name)
            print(f"Deleted login profile for user {user_name}.")
        except iam.exceptions.NoSuchEntityException:
            print(f"No login profile found for user {user_name}.")

        # Delete access keys
        access_keys = iam.list_access_keys(UserName=user_name)['AccessKeyMetadata']
        for access_key in access_keys:
            iam.delete_access_key(UserName=user_name, AccessKeyId=access_key['AccessKeyId'])
            print(f"Deleted access key {access_key['AccessKeyId']} for user {user_name}.")

        # Finally, delete the user
        iam.delete_user(UserName=user_name)
        print(f"User {user_name} deleted successfully.")
        
    except Exception as e:
        print(f"Error deleting user {user_name}: {e}")

def delete_multiple_iam_users(user_names):
    for user_name in user_names:
        delete_iam_user(user_name)

if __name__ == "__main__":
    #user_names = ['test', 'test1', 'test2']  # Replace with the list of usernames you want to delete
    user_names = ['pavi','pasru','rebel','rebel_test','rebel_test2','test','test2']
    delete_multiple_iam_users(user_names)
