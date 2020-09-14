#  KESKENERÄINEN

import boto3

ses = boto3.client('ses')


def send_ses(event, context):
    email = event[0]['email']
    response = ses.send_custom_verification_email(
        EmailAddress='tsttestitesti@gmail.com',
        TemplateName='MyStockApp-verification',
        ConfigurationSetName='string'
    )
    return response


