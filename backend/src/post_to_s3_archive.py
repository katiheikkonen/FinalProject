import boto3
import uuid
import json

s3 = boto3.resource("s3")

#Funktion tarkoitus on arkistoida asiakaspalautteet S3 ämpäriin myöhempää käyttöä varten
def archive_to_s3_bucket(event, context):
    data = json.loads(event['body'])

    bucket_name = "testi-archival" #MUUUTA MINUT; OLEN VÄÄRÄ S3

    #Nimentään .json tiedosto randomoidulla uu ID.llä
    tiedosto = str(uuid.uuid1())
    file_name = f"{tiedosto}.json"
    s3_path = file_name

    #Dumpataan tiedosto S3 ämpäriin:
    s3.Bucket(bucket_name).put_object(Key=s3_path, Body=json.dumps(data))

    #Palautetaan statuskoodi ja tiedoston nimi
    response = {
        'statusCode': 200,
        #'body': json.dumps('file is created in: ' + bucket_name + "/" + s3_path)
    }

    return response