import boto3

dynamodb = boto3.resource("dynamodb")

#  Funktiolla poistetaan käyttäjä sovellukseen DELETE-toiminnolla annetun id:n perusteella.
#  Body = {"user_id": " "}

def delete_user(event, context):
    itemid = event['pathParameters']['user_id']
    table = dynamodb.Table('userdata')

    table.delete_item(Key={
        'user_id': itemid
    })

    return {
        'statusCode': 200
    }