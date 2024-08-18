import boto3
import os 
from boto3.s3.transfer import TransferConfig

# Initialize client
s3_client = boto3.client('s3')

#Files vars
bucket_name = 'pgr-automation-143'
file_path = "/home/prashanthg/"
file_name = "awscliv2.zip"
object_name = file_name

#set theshold limit
multipart_upload_theshold = 500

def upload_file(file_path, bucket_name, object_name):
    file_size = os.path.getsize(file_path/file_name) / (1024 * 1024)

    print (f"File size MB:", file_size)

    if file_size >  multipart_upload_theshold:
        print(f"file is bigger then:",multipart_upload_theshold,"MB", "using multipart upload method")
        multipart_upload(file_path, bucket_name, object_name)
    else:
        print(f"file size is smaller then:", multipart_upload_theshold, "using direct upload")
        direct_upload(file_path, bucket_name, object_name)

def direct_upload(file_path, bucket_name, object_name):
    try:
        #s3_client.upload_file(file_path, bucket_name, object_name, ExtraArgs={'ACL': 'public-read'})
        s3_client.upload_file(file_path, bucket_name, object_name)
        print(f"Direct upload completed successfully for {object_name}.")
    except Exception as e:
        print(f"Direct upload failed: {e}")
def multipart_upload(file_path, bucket_name, object_name):
    config = TransferConfig(multipart_threshold=MULTIPART_THRESHOLD, max_concurrency=10, multipart_chunksize=MULTIPART_THRESHOLD, use_threads=True)
    
    try:
        #s3_client.upload_file(file_path, bucket_name, object_name, Config=config, ExtraArgs={'ACL': 'public-read'})
        s3_client.upload_file(file_path, bucket_name, object_name, Config=config)
        print(f"Multipart upload completed successfully for {object_name}.")
    except Exception as e:
        print(f"Multipart upload failed: {e}")




upload_file(file_path, bucket_name, object_name)