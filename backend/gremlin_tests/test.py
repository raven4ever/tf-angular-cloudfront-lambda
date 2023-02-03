import logging

from gremlin_python.driver.driver_remote_connection import \
    DriverRemoteConnection
from gremlin_python.process.anonymous_traversal import traversal
from gremlin_python.process.graph_traversal import __
from gremlin_python.process.traversal import T
from gremlin_python.structure.graph import Graph

if __name__ == '__main__':

    logging.basicConfig(level=logging.INFO)

    logging.info('Testing queries and stuff')

    server_url = 'ws://server:8182/gremlin'  # when running in container
    # server_url = 'ws://localhost:8182/gremlin'  # when running on local machine

    conn = None

    try:
        logging.info('Creating the connection')

        graph = Graph()
        conn = DriverRemoteConnection(server_url, 'g')
        g = graph.traversal().withRemote(conn)

        logging.info('Delete everything in the DB')
        g.V().drop().iterate()

        logging.info('Adding the Books')
        b1 = g.addV('book').property(
            'name', 'The Count of Monte Cristo').next()
        b2 = g.addV('book').property(
            'name', 'Don Quixote').next()
        b3 = g.addV('book').property(
            'name', 'The Exorcist').next()
        b4 = g.addV('book').property(
            'name', 'The Lord of the Rings').next()
        b5 = g.addV('book').property(
            'name', 'Pet Sematary').next()
        b6 = g.addV('book').property(
            'book_id', '1').property('name', 'Carrie').next()

        logging.info('Adding the Authors')
        a1 = g.addV('author').property('name', 'Alexandre Dumas').next()
        a2 = g.addV('author').property('name', 'Miguel de Cervantes').next()
        a3 = g.addV('author').property('name', 'William Peter Blatty').next()
        a4 = g.addV('author').property('name', 'J. R. R. Tolkien').next()
        a5 = g.addV('author').property('name', 'Stephen King').next()

        logging.info('Adding the genres')
        g1 = g.addV('genre').property('name', 'Adventure Fiction').next()
        g2 = g.addV('genre').property('name', 'Satire').next()
        g3 = g.addV('genre').property('name', 'Horror').next()
        g4 = g.addV('genre').property('name', 'Fantasy Fiction').next()

        logging.info('Adding relations')
        g.V(b1).addE('written_by').to(__.V(a1)).outV().addE(
            'belongs_to').to(__.V(g1)).next()
        g.V(b2).addE('written_by').to(__.V(a2)).outV().addE(
            'belongs_to').to(__.V(g2)).next()
        g.V(b3).addE('written_by').to(__.V(a3)).outV().addE(
            'belongs_to').to(__.V(g3)).next()
        g.V(b4).addE('written_by').to(__.V(a4)).outV().addE(
            'belongs_to').to(__.V(g4)).next()
        g.V(b5).addE('written_by').to(__.V(a5)).outV().addE(
            'belongs_to').to(__.V(g3)).next()
        g.V(b6).addE('written_by').to(__.V(a5)).outV().addE(
            'belongs_to').to(__.V(g3)).next()

        logging.info('Show all authors')
        print(
            g.V().hasLabel('author')
            .values('name')
            .toList()
        )

        logging.info('Show all vertex names grouped by the label')
        print(
            g.V().group()
            .by(T.label)
            .by('name')
            .toList()
        )

        logging.info('Show all books with their coresponding Author and Genre')
        print(
            g.V().hasLabel('author').as_('author')
            .in_('written_by').as_('book')
            .out('belongs_to').as_('genre')
            .select('book',  'author', 'genre').by('name').toList()
        )

        logging.info(
            'Show all books with their coresponding ID, Author and Genre')
        print(
            g.V().hasLabel('book')
            .project('book', 'book_id', 'genre', 'author')
            .by('name')
            .by(T.id)
            .by(__.out('belongs_to').values('name'))
            .by(__.out('written_by').values('name'))
            .toList()
        )
    finally:
        if conn:
            conn.close()
