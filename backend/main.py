import json

BOOK_LIST = [
    {'id': 1, 'name': 'The Count of Monte Cristo',
        'genre': 'Adventure Fiction', 'author': 'Alexandre Dumas'},
    {'id': 2, 'name': 'Don Quixote', 'genre': 'Satire',
        'author': 'Miguel de Cervantes'},
    {'id': 3, 'name': 'The Great Gatsby',
        'genre': 'Tragedy', 'author': 'F. Scott Fitzgerald'},
    {'id': 4, 'name': 'The Lord of the Rings',
        'genre': 'Fantasy Fiction', 'author': 'J. R. R. Tolkien'},
    {'id': 5, 'name': 'Pet Sematary', 'genre': 'Horror', 'author': 'Stephen King'}
]


def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps(BOOK_LIST)
    }
