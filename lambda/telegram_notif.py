
import json
import os
import logging
import requests

# Initializing a logger and setting it to INFO
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Reading env variables and generating a Telegram Bot API URL
TOKEN = os.environ['TOKEN']
CHAT_ID = os.environ['CHAT_ID']
TELEGRAM_URL = "https://api.telegram.org/bot{}/sendMessage".format(TOKEN)

# FIXME: I do not receive the new version of the message from prettify_message()
def prettify_message(message):
    prettified_message = f"""**Message**: `{message}`\n\n\
✅Your Ansible playbook has finished execution.\n\
🚀For more details, check the logs or the monitoring system.
"""
    return prettified_message

# Helper function to prettify the message if it's in JSON
def process_message(input):
    try:
        # Loading JSON into a string
        raw_json = json.loads(input)
        # Outputing as JSON with indents
        output = json.dumps(raw_json, indent=4)
    except:
        output = input
    return output

# Main lambda handler
def lambda_handler(event, context):
    # Logging the event for debugging
    logger.info("event=")
    logger.info(json.dumps(event))

    # Basic exception handling. If anything goes wrong, logging the exception
    try:
        message = process_message(event['Records'][0]['Sns']['Message'])

        prettified_message = prettify_message(message)

        # Payload to be set via POST method to Telegram Bot API
        payload = {
            "chat_id": CHAT_ID,
            "text": prettified_message,
            "parse_mode": "Markdown"
        }

        # Posting the payload to Telegram Bot API
        response = requests.post(TELEGRAM_URL, payload)
        # Raise an error for bad status codes
        response.raise_for_status()
        
        logger.info(json.dumps(response))

    except Exception as e:
        raise e