import boto3
import uuid
import json
s3 = boto3.resource("s3")

def from_api_to_s3(event, context):
    data = json.loads(event['body'])

    bucket_name = "customer-review-loppuprojekti-12345"

    sisalto = data
    tiedosto = str(uuid.uuid1())
    file_name = f"{tiedosto}.json"
    s3_path = file_name

    s3.Bucket(bucket_name).put_object(Key=s3_path, Body=json.dumps(sisalto))

    response = {
        'statusCode': 200,
        'body': json.dumps('file is created in: ' + bucket_name + "/" + s3_path)
    }

    return response