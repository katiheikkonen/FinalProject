#  S3 laukaisee tämän Lambdan ja se lähettää asiakaspalautteen Amazon Comprehendille analysoitavaksi Sentimental Analysis-tyäkalun kautta
import boto3

#s3 = boto3.client("s3")
comprehend = boto3.client("comprehend")

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
    sentiment = comprehend.detect_sentiment(Text=message, LanguageCode="en")

    return sentiment