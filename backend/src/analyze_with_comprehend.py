import json
import uuid

#  S3 laukaisee tämän Lambdan
#  Lambda lähettää saadun palautteen Amazon Comprehendille analysoitavaksi Sentimental Analysis-työkalun kautta
import boto3

#s3 = boto3.client("s3")
comprehend = boto3.client("comprehend")
dynamodb = boto3.resource('dynamodb')

def sentimental_analysis(event, context):
    message = "The end of the cord broke off in my phone after the 4th use." \
    "Thought it might be a just a defective plug, but I looked at recent reviews and others are having same issues."\
     "I am sending the cords back and buy different brand."

    # paragraph-kohtaan vielä muutos, että haetaan asiakaspalaute s3:sta, alla yksi esimerkki

    # bucket = "bucket-name"
    # key = "filename.txt"
    # file = s3.get_object(Bucket=bucket, Key=key)
    # paragraph = str(file['Body'].read())

    # Extracting sentiments using comprehend
    reply = comprehend.detect_sentiment(Text=message, LanguageCode="en")

    #Poimitaan Comprehendista tulleesta datasta halutut datakentät:
    sentiment = reply['Sentiment']
    positive = str(reply['SentimentScore']['Positive'])
    negative = str(reply['SentimentScore']['Negative'])
    neutral = str(reply['SentimentScore']['Neutral'])
    mixed = str(reply['SentimentScore']['Mixed'])
    time = str(reply['ResponseMetadata']['HTTPHeaders']['date'])

    # + potentiaalista debugausta varten retry-attemps kenttä:
    retry_attemps = reply['ResponseMetadata']['RetryAttempts']


    #Tallennetaan sortattu Comprehend data DynamoDB tauluun:
    table = dynamodb.Table("sentiment_data_analysis") #Nimi kovakoodattuna

    #Luodaan item/ Rivi joka tallennetaan Dynamoon:
    item = {
        "id":uuid.uuid4(),
        "sentiment":sentiment,
        "positive": positive,
        "negative": negative,
        "neutral": neutral,
        "mixed":mixed,
        "time":time
    }
    #Tallennus:
    table.put_item(Item=item)

    #Luodaan Response, jonka lambda näyttää suorituksen jälkeen:
    response = {
        "statusCode": 200,
        "body":json.dumps(item)}
    return response