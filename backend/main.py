import os
import json

BOOK_LIST = [
    {'id': 1, 'name': 'The Count of Monte Cristo',
        'genre': 'Adventure Fiction', 'author': 'Alexandre Dumas'},
    {'id': 2, 'name': 'Don Quixote', 'genre': 'Satire',
        'author': 'Miguel de Cervantes'},
    {'id': 3, 'name': 'The Exorcist',
        'genre': 'Horror', 'author': 'William Peter Blatty'},
    {'id': 4, 'name': 'The Lord of the Rings',
        'genre': 'Fantasy Fiction', 'author': 'J. R. R. Tolkien'},
    {'id': 5, 'name': 'Pet Sematary', 'genre': 'Horror', 'author': 'Stephen King'},
    {'id': 6, 'name': 'Carrie', 'genre': 'Horror', 'author': 'Stephen King'}
]

NEPTUNE_URL = os.getenv('NEPTUNE_URL')
NEPTUNE_PORT = os.getenv('NEPTUNE_PORT')
INITIAL_DATA_LOADED = os.getenv("INITIAL_DATA_LOADED", "False") == "True"


def lambda_handler(event, context):
    if not INITIAL_DATA_LOADED:
        print(NEPTUNE_URL)
        print(NEPTUNE_PORT)
        os.environ["INITIAL_DATA_LOADED"] = True

    return {
        'statusCode': 200,
        'body': json.dumps(BOOK_LIST)
    }
