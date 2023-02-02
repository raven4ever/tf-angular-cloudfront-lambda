import json
import os

from neptune_python_utils.batch_utils import BatchUtils
from neptune_python_utils.endpoints import Endpoints
from neptune_python_utils.gremlin_utils import GremlinUtils

from data import edges, vertices

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

REGION_NAME = os.getenv('REGION_NAME')
NEPTUNE_URL = os.getenv('NEPTUNE_URL')
NEPTUNE_PORT = os.getenv('NEPTUNE_PORT')
REGION_NAME = os.getenv('REGION_NAME')

endpoints = Endpoints(neptune_endpoint=NEPTUNE_URL,
                      neptune_port=NEPTUNE_PORT,
                      region_name=REGION_NAME)

GremlinUtils.init_statics(globals())

gremlin_utils = GremlinUtils(endpoints)
batch = BatchUtils(endpoints)

conn = None

try:
    conn = gremlin_utils.remote_connection(ssl=False)
    g = gremlin_utils.traversal_source(connection=conn)

    # print to test connection
    print(g.V().limit(10).valueMap().toList())

    # batch insert vertices
    batch.upsert_vertices(batch_size=3, rows=vertices)

    # batch insert edges
    batch.upsert_edges(batch_size=3, rows=edges)

    # print to test upload
    print(g.V().limit(100).valueMap().toList())
finally:
    if conn:
        conn.close()


def lambda_handler(event, context):

    return {
        'statusCode': 200,
        'body': json.dumps(BOOK_LIST)
    }
