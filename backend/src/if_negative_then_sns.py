import json
import boto3
import os
client = boto3.client('sns')
arn = os.getenv("sns_topic")

def check_negativity(event, context):
    # poimitaan comprehend funktiosta tuleva data
    data = json.loads(event['body'])
    # poimitaan comprehend funktiosta tuleva data
    negatiivinen_sentimentti = data['negative_sentiment']

    #Jos palautteen sentimentti on yli 90% negatiivinen
    if negatiivinen_sentimentti > 0.9:

        #lähetetään palaute asiakaspalvelulle heti käsiteltäväksi:
        response = client.publish(
            TopicArn=arn,
            Message=data['message'],
            Subject="RED ALERT, THIS IS NOT A DRILL")

    #Palautetaan viesti ja statuscode:
    return {
        'statusCode': 200,
        'body': json.dumps(data['message'])
    }