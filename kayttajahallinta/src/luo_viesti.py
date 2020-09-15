#  KESKENERÄINEN

import boto3

ses = boto3.client('ses', region_name='eu-central-1')

def create_message():
    response = ses.create_custom_verification_email_template(
        TemplateName='MyStocksApp-verification',
        FromEmailAddress='tsttestitesti@gmail.com',
        TemplateSubject='Confirm your registration to MyStock-app',
        TemplateContent='Moikkelis',
        SuccessRedirectionURL='http://nomnomproductions.com', #The URL that the recipient of the verification email is sent to if his or her address is successfully verified.
        FailureRedirectionURL='http://nomnomproductions.com' #The URL that the recipient of the verification email is sent to if his or her address is not successfully verified.
    )

create_message()

