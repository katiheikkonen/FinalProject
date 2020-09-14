import boto3
import json
import os
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')

#PUT metodi, jolla käyttäjä voi päivittää tietojaan. Koska Frontti puuttuu, pitää funktion tarkistaa annetaanko kaikki
#oleellinen data. Jos ei, se hakee puuttuvan datan asiakkaan tiedoista ja päivittää sen tauluun.
# {"body":{
#   "user_id":"b54cecce-667f-437a-9fef-b9a8aaa5f45a",
#   "username": "kpl",
#   "firstname": "nonnonnoo",
#   "surname": "uuf",
#   "email":"jou@jou.joujou",
#   "city": "kuopio",
#   "country": "juukelispuukelis"
# }}

def update_user(event, context):
    table = dynamodb.Table(os.environ["dynamo_table_userdata_name"])
    body = json.loads(event['body'])

    # Funktio saa "Bodyn"" mukana parometrejä, muttei välttämättä kaikkia niistä. Sen täytyy tarkistaa onko saatu päivitettävää arvoa vai ei,
    # jos ei, niin haetaan kyseinen data taulusta ja käytetään jo olemassa olevaa arvoa
    data = table.query(KeyConditionExpression=Key('user_id').eq(body['user_id']))
    if body['username'] is None:
        username = data['Items'][0]['username']
    if body['firstname'] is None:
        firstname = data['Items'][0]['firstname']
    if body['surname'] is None:
        surname = data['Items'][0]['surname']
    if body['email'] is None:
        email = data['Items'][0]['email']
    if body['city'] is None:
        city = data['Items'][0]['city']
    if body['country'] is None:
        country = data['Items'][0]['country']

    # päivitetään uudelleen määritetyillä arvoilla taulun rivi
    result = table.update_item(
        Key={'id': id},
        ExpressionAttributeValues={
            'username': username,
            'firstname': firstname,
            ':surname': surname,
            ':email': email,
            ':city': city,
            ':country': country
        },
        UpdateExpression='SET firstname = :firstname, '
        'username = :username, '
        'surname = :surname, '
        'email = :email ,'
        'city = :city ,'
        'country = :country',
        ReturnValues='UPDATED_NEW',
    )

    # palautetaan päivitetty rivi
    response = {
        "statusCode": 200,
        "body": json.dumps(result['Attributes'])
    }
    return response