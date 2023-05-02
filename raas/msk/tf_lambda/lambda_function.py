import boto3
import string
import random
import json

def generate_password(length):
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(characters) for i in range(length))
    return password

def update_secret(secret_id, secret_value):
    client = boto3.client("secretsmanager")
    response = client.update_secret(
        SecretId=secret_id,
        SecretString=secret_value
    )
    return response

def lambda_handler(event, context):
    secret_id = "AmazonMSK_czr-raas-secret-usw2-dev-msk"
    password_length = 20
    new_password = generate_password(password_length)

    client = boto3.client("secretsmanager")
    secret = client.get_secret_value(SecretId=secret_id)
    secret_string = secret["SecretString"]
    secret_dict = json.loads(secret_string)
    secret_dict["password"] = new_password
    new_secret_string = json.dumps(secret_dict)
    
    update_response = update_secret(secret_id, new_secret_string)
    return update_response
