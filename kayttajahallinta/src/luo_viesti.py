#  KESKENERÄINEN

import boto3

ses = boto3.client('ses')

def send_ses(event, context):
    response = ses.create_custom_verification_email_template(
        TemplateName='MyStockApp-verification',
        FromEmailAddress='tsttestitesti@gmail.com',
        TemplateSubject='Confirm your registration to MyStock-app',
        TemplateContent='MOIKKELIS',
        SuccessRedirectionURL='string', #The URL that the recipient of the verification email is sent to if his or her address is successfully verified.
        FailureRedirectionURL='string' #The URL that the recipient of the verification email is sent to if his or her address is not successfully verified.
    )