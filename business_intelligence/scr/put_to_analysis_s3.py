#  DynamoDB Stream triggeröi Lambdan, kun taulukkoon päivittyy uusi tiedosto
#  Funktio tallentaa DynamoDB:n sentimenttianalyysitiedot s3-bucketiin
#  Bucketiin voidaan tehdä SQL-tiedusteluja Athenalla ja sieltä voi viedä dataa Quicksightiin visualisoitavaksi
#  Tarkoituksena on luoda itse sovelluksesta erotettu analyysimicroservice, jota on helppo tilanteen mukaan muokata

import boto3
import json

s3 = boto3.resource("s3")

def put_to_analysis_s3(event, context):
    #  Haetaan DynamoDB:stä eventinä tulleet tiedot
    data = event['Records'][0]
    #  Määritellään bucket, johon tiedot halutaan tallentaa
    bucket_name = 'analysis-loppuprojekti'

    # Haetaan tiedoston nimeksi tiedoston id ja lisätään pääte json
    tiedosto = data['dynamodb']['Keys']['id']['S']
    file_name = f"{tiedosto}.json"
    s3_path = file_name

    #  Parsitaan eventistä halutut tiedot analyysiä varten
    values = data['dynamodb]['NewImage']

    # Laitetaan DynamoDB:n taulun tiedot tiedosto S3 bucketiin:
    s3.Bucket(bucket_name).put_object(Key=s3_path, Body=json.dumps(data))

    # Palautetaan statuskoodi ja tiedoston nimi
    response = {
        'statusCode': 200,
        'body': json.dumps('file is created in: ' + bucket_name + "/" + s3_path)
    }
    return response