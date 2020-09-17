import boto3
import uuid
import json

s3 = boto3.resource("s3")

#Funktio siirtää ottaa APIn kautta tulleen asiakaspalautteen, poimii siitä viestikentän ja tallentaa sen .json tiedostona S3 ämpäriin:

def from_api_to_s3(event, context):
    #otetaan data eventistä:
    data = json.loads(event['body'])

    #S3 ämpärin nimi kovakoodattuna:
    bucket_name = "customer-review-loppuprojekti-123"

    #rakennetaan S3 ämpäriin ladattavan tiedoston sisältö ja nimetään tiedosto
    sisalto = data['message']
    tiedosto = str(uuid.uuid1())
    file_name = f"{tiedosto}.json"
    # lambda_path = "/tmp/" + file_name
    s3_path = file_name

    #tallennetaan luotu tiedosto S3 ämpäriin:
    s3.Bucket(bucket_name).put_object(Key=s3_path, Body=json.dumps(sisalto))

    #palautetaan tiedoston polku
    response = {
        'statusCode': 200,
        'body': json.dumps('file is created in: ' + bucket_name + "/" + s3_path)
    }

    return response