import json
import os

from gremlin_python.process.graph_traversal import __
from gremlin_python.process.traversal import T
from neptune_python_utils.batch_utils import BatchUtils
from neptune_python_utils.endpoints import Endpoints
from neptune_python_utils.gremlin_utils import GremlinUtils

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
g = None

############################################################################
####### This section is here to optimize the Lambda cold start time. #######
############################################################################
try:
    conn = gremlin_utils.remote_connection(ssl=False)
    g = gremlin_utils.traversal_source(connection=conn)

    print('Delete everything in the DB')
    g.V().drop().iterate()

    print('Adding the Books')
    b1 = g.addV('book').property('name', 'The Count of Monte Cristo').next()
    b2 = g.addV('book').property('name', 'Don Quixote').next()
    b3 = g.addV('book').property('name', 'The Exorcist').next()
    b4 = g.addV('book').property('name', 'The Lord of the Rings').next()
    b5 = g.addV('book').property('name', 'Pet Sematary').next()
    b6 = g.addV('book').property('name', 'Carrie').next()

    print('Adding the Authors')
    a1 = g.addV('author').property('name', 'Alexandre Dumas').next()
    a2 = g.addV('author').property('name', 'Miguel de Cervantes').next()
    a3 = g.addV('author').property('name', 'William Peter Blatty').next()
    a4 = g.addV('author').property('name', 'J. R. R. Tolkien').next()
    a5 = g.addV('author').property('name', 'Stephen King').next()

    print('Adding the genres')
    g1 = g.addV('genre').property('name', 'Adventure Fiction').next()
    g2 = g.addV('genre').property('name', 'Satire').next()
    g3 = g.addV('genre').property('name', 'Horror').next()
    g4 = g.addV('genre').property('name', 'Fantasy Fiction').next()

    print('Adding relations')
    g.V(b1).addE('written_by').to(__.V(a1)).outV() \
        .addE('belongs_to').to(__.V(g1)).next()
    g.V(b2).addE('written_by').to(__.V(a2)).outV() \
        .addE('belongs_to').to(__.V(g2)).next()
    g.V(b3).addE('written_by').to(__.V(a3)).outV() \
        .addE('belongs_to').to(__.V(g3)).next()
    g.V(b4).addE('written_by').to(__.V(a4)).outV() \
        .addE('belongs_to').to(__.V(g4)).next()
    g.V(b5).addE('written_by').to(__.V(a5)).outV() \
        .addE('belongs_to').to(__.V(g3)).next()
    g.V(b6).addE('written_by').to(__.V(a5)).outV() \
        .addE('belongs_to').to(__.V(g3)).next()
except Exception as e:
    print(e)
    if conn:
        conn.close()


def get_books_with_author_and_genre():
    print('Show all books with their coresponding ID, Author and Genre')
    result = {}

    try:
        q_result = g.V().hasLabel('book') \
            .project('name', 'id', 'genre', 'author') \
            .by('name') \
            .by(T.id) \
            .by(__.out('belongs_to').values('name')) \
            .by(__.out('written_by').values('name')) \
            .toList()
        result = {
            'statusCode': 200,
            'body': json.dumps(q_result)
        }
    except Exception as e:
        result = {
            'statusCode': 500,
            'body': json.dumps({
                'error': 666,
                'message': 'Something went wrong with your query!',
                'exception': str(e)
            })
        }
        if conn:
            conn.close()

    return result


def lambda_handler(event, context):
    return get_books_with_author_and_genre()
