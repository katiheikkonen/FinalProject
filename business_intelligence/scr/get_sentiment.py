import json
import boto3
import os

db = boto3.resource('dynamodb')


def get_sentiment(event, context):
    # kohteena oleva taulu kovakoodattuna:
    table = db.Table(os.getenv("table"))

    # Yritetään skannata taulu. Jos ei onnistu, palautetaan virhe ilmoitus
    try:
        table_content = table.scan()
    except Exception:
        return {
            "statusCode": 502,
            "headers": {},
            "body": "Error scanning table"}

    result = table_content['Items']

    # Lasketaan montako erilaista palautetta on saatu:
    positiivinen_palaute = 0
    negativiinen_palaute = 0
    mixed_palaute = 0
    neutraali_palaute = 0

    # For loop käy läpi kaikkien tulosten sentimentit ja lisää sentimentin ylläolevaan laskentaan:
    for palaute in result:
        if palaute['sentiment'] == "POSITIVE":
            positiivinen_palaute += 1
        elif palaute['sentiment'] == "NEGATIVE":
            negativiinen_palaute += 1
        elif palaute['sentiment'] == "NEGATIVE":
            mixed_palaute += 1
        else:
            neutraali_palaute += 1

    # Tarkistetaan paljonko palautteita on yht saatu:
    palautteita_yht = positiivinen_palaute + negativiinen_palaute + neutraali_palaute + mixed_palaute

    #For loop joka laskee yhteensä paljonko saadun asiakaspalautteen sisällöstä on ollut negatiivista ja positiivista:
    positiiviset_arvot = 0
    negatiiviset_arvot = 0
    for score in result:
        positiiviset_arvot += float(score['positive'])
        negatiiviset_arvot += float(score['negative'])

    # Rakennetaan tulos lista jossa mm. annetaan suhteelliset osuudet eri luvuille
    tulokset = {"Palautteita yhteensa: ": palautteita_yht,
                "Positiivista palautetta: ": round(positiivinen_palaute / palautteita_yht, 2),
                "Negatiivista palautetta: ": round(negativiinen_palaute / palautteita_yht, 2),
                "Neutraalia palautetta: ": round(neutraali_palaute / palautteita_yht, 2),
                "Mixed palautetta: ": round(mixed_palaute / palautteita_yht, 2),
                "Keskimaarainen positiivisuus arvo oli: ": round(positiiviset_arvot / palautteita_yht, 2),
                "Keskimaarainen negatiivisuus arvo oli: ": round(negatiiviset_arvot / palautteita_yht, 2)
                }

    # Palautetaan kyselyn tulokset
    response = {"statusCode": 200, "body": json.dumps(tulokset)}
    return response