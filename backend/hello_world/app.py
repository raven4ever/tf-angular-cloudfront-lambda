import json


def lambda_handler(event, context):
    if event['httpMethod'] == 'GET':
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "hello world",
            }),
        }

