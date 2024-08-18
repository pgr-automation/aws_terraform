import boto3


def attach_sg():
  try:
      
    ec2 = boto3.client('ec2', region_name=region)

    response = ec2.describe_instances(
      Filters =[
        {
          'Name': 'tag:Name',
          'Vaule': [Instance_name]
        }
      ]
    )
    
    instance =  response['Reservations'][0]['Instances']
    print(instance)
  except Exception as e:
    print(e)

if __name__ == "__main__":
  Instance_name = 'webserv-1'
  region= 'us-east-1'
  attach_sg()
  