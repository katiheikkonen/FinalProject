import boto3
import json
import uuid

dynamodb = boto3.resource('dynamodb')

#  Funktiolla luodaan käyttäjä sovellukseen POST-toiminnolla. Body =
# {"body":{
#     "username": "kpl",
#   "firstname": "nonnonnoo",
#   "surname": "uuf",
#   "email":"jou@jou.joujou",
#   "city": "kuopio",
#   "country": "juukelispuukelis"
# }}
#  Funktio rakentaa itse uniikin id:n

def create_user(event, context):
    json_data = json.loads(event['body'])
    table = dynamodb.Table("userdata")

    item = {
        'user_id': str(uuid.uuid4()),
        'username': json_data['username'],
        'firstname': json_data['firstname'],
        'surname': json_data['surname'],
        'email': json_data['email'],
        'city': json_data['city'],
        'country': json_data['country']
    }
    table.put_item(Item=item)

    response = {
        "statusCode": 200,
        "body": json.dumps(item)
    }

    return response