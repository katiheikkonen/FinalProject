#  Funktiolla tarkastetaan onko palaute selvästi negatiivinen
#  Jos selkeästi negatiivinen palaute lähetetään omaan SNS topiciin asiakaspalvelun nopean reagoinnin varmistamiseksi

import json
import boto3
sns = boto3.client('sns')

def check_negativity(event, context):
    #  tällä hetkellä hakee palautteen lambdan testieventistä, tämän muokkaus StepFunctioniin niin, että hakee oikean tiedon inputista
    negativity_percent = float(event['negative'])
    #  startwith tarkoitus, että karsii pois vaihtoehdot, joissa monta nollaan edessä, muuten palaute aina käytännössä 0,jotain
    #  muutetaan negatiivisuus murtoluvuksi
    #  katsotaan onko palaute yli 90% eli selkeästi negatiivista
    if negativity_percent > 0.9:
        message = "This is message from customer" #  StepFunctionissa tälle funktiolle viesti, lähettäjä ja lähettäjän osoite inputtina
        response = sns.publish(
            #  Topic nyt testissä kovakoodattuna, muutetaan env variableksi tai muuten viittaus?
            TopicArn='arn:aws:sns:eu-central-1:821383200340:customer-service-negative-review',
            Message=message,
            Subject='Information on negative customer review',
        )
        return {
            "statusCode": 200,
            "body": json.dumps(response)
        }

