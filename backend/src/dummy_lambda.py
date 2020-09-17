import boto3
import json
import uuid
s3 = boto3.resource("s3")


def dummy(event, context):
    bucket_name = "mikko-cloudtrail-logs"

    sisalto = "moi"
    tiedosto = str(uuid.uuid1())
    file_name = f"{tiedosto}.txt"
    s3_path = file_name

    s3.Bucket(bucket_name).put_object(Key=s3_path, Body=json.dumps(sisalto))

    response = {
        'statusCode': 200,
        'body': json.dumps('file is created in: ' + bucket_name + "/" + s3_path)
    }

    return response