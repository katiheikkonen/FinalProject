import json
import uuid

import boto3


s3 = boto3.resource('s3')

def get_object_from_s3(event, context):
    message = "What a wonderful product. I'm super happy!"
    return {"body": json.dumps(message)}


#Poimitaan S3sta tulevasta eventistä..
#     s3_trigger = event['Records']
#     # Uuden tiedoston nimi, sekä
#     s3_filename = s3_trigger[0]['s3']['object']['key']
#     # bucketin nimi
#     s3_bucket_name = s3_trigger[0]['s3']['bucket']['name']
#
#     # haettu objekti:
#     obj = s3.Object(s3_bucket_name, s3_filename)
#     # tiedoston sisältä
#     m_body = obj.get()['Body']._raw_stream.readline()
#     viesti = json.loads(m_body)
#
#     return {"body":json.dumps(viesti)}