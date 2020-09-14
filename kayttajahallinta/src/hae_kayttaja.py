import boto3
import json

dynamodb = boto3.resource('dynamodb')

#  Funtiolla haetaan käyttäjän tiedot sovelluksesta GET-toiminnolla.
#  Body = {"id": " "}

def get_user(event, context):
    itemid = event['id']

    table = dynamodb.Table('userdata')
    response = table.get_item(
        Key={
            'id': itemid
        })

    return {
        "statusCode": 200,
        "body": json.dumps(response)
    }