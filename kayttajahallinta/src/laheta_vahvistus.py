#  KESKENERÄINEN

import boto3

ses = boto3.client('ses', region_name='eu-central-1')

def send_message():
    response = ses.send_custom_verification_email(
        EmailAddress='kati.m.heikkonen@gmail.com', #  vahvistettu email, josta viesti lähetetään
        TemplateName='MyStocksApp-verification',
    )
    return response

send_message()


