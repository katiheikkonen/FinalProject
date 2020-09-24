import json
import uuid

import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table("sentiment_data_analysis_global_table")  # Nimi kovakoodattuna


def post_to_dynamo(event, context):
    data = json.loads(event[1]['body'])  # poimitaan comprehend funktiosta tuleva data
    analysis_data = data['analysis'] #poimitaan analyysi kyseisestä datasta
    message = data['message'] #pomitaan viesti talteen


    # Luodaan item/ Rivi, johon poimitaan data sentimentistä tulleesta datasta ja joka tallennetaan Dynamoon:
    item = {
        "id": data['id'],
        "sentiment": analysis_data['Sentiment'],
        "positive": str(analysis_data['SentimentScore']['Positive']),
        "negative": str(analysis_data['SentimentScore']['Negative']),
        "neutral": str(analysis_data['SentimentScore']['Neutral']),
        "mixed": str(analysis_data['SentimentScore']['Mixed']),
        "time": str(analysis_data['ResponseMetadata']['HTTPHeaders']['date'])
    }


    # # Tallennus:
    table.put_item(Item=item)


    #kootaan viestistä ja negatiivisesta sentimentistä palautus, joka lähetetään seuraavaan lambdaan:
    jatkoon = {'message': message,
               'negative_sentiment': analysis_data['SentimentScore']['Negative']}

    # Luodaan Response, jonka lambda näyttää suorituksen jälkeen:
    response = {
        "statusCode": 200,
        "body": json.dumps(jatkoon)}
    return response