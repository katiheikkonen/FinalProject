import json
import boto3

stepfunctions = boto3.client('stepfunctions')

def invoke_stepfunction(event, context):
    print(event)
    response = stepfunctions.start_execution(
        stateMachineArn='arn:aws:states:eu-central-1:821383200340:stateMachine:sentimental-analysis-state-machine',#HUOM
        input=json.dumps(event)
    )
    return {
        'status_code': 200,
        'body': event
    }