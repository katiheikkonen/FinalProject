import json
import uuid

#  S3 laukaisee tämän Lambdan
#  Lambda lähettää saadun palautteen Amazon Comprehendille analysoitavaksi Sentimental Analysis-työkalun kautta
import boto3

# s3 = boto3.client("s3")
comprehend = boto3.client("comprehend")
#dynamodb = boto3.resource('dynamodb')
#s3 = boto3.resource('s3')


def sentimental_analysis(event, context):
    # sisällön message kenttä:
    data = json.loads(event['body'])

    # Extracting sentiments using comprehend
    reply = comprehend.detect_sentiment(Text=data, LanguageCode="en")

    # + potentiaalista debugausta varten retry-attemps kenttä:
    retry_attemps = reply['ResponseMetadata']['RetryAttempts']

    koottu_vastaus = {"message":data,
                      "analysis": reply}


    # Luodaan Response, jonka lambda näyttää suorituksen jälkeen:
    response = {
        "statusCode": 200,
        "body": json.dumps(koottu_vastaus)}
    return response