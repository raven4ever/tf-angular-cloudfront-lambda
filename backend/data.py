vertices = [
    {'~id': 'book1', '~label': 'Book', 'name:String': 'The Count of Monte Cristo'},
    {'~id': 'book2', '~label': 'Book', 'name:String': 'Don Quixote'},
    {'~id': 'book3', '~label': 'Book', 'name:String': 'The Exorcist'},
    {'~id': 'book4', '~label': 'Book', 'name:String': 'The Lord of the Rings'},
    {'~id': 'book5', '~label': 'Book', 'name:String': 'Pet Sematary'},
    {'~id': 'book6', '~label': 'Book', 'name:String': 'Carrie'},

    {'~id': 'genre1', '~label': 'Genre', 'name:String': 'Adventure Fiction'},
    {'~id': 'genre2', '~label': 'Genre', 'name:String': 'Satire'},
    {'~id': 'genre3', '~label': 'Genre', 'name:String': 'Horror'},
    {'~id': 'genre4', '~label': 'Genre', 'name:String': 'Fantasy Fiction'},

    {'~id': 'author1', '~label': 'Author', 'name:String': 'Alexandre Dumas'},
    {'~id': 'author2', '~label': 'Author', 'name:String': 'Miguel de Cervantes'},
    {'~id': 'author3', '~label': 'Author', 'name:String': 'William Peter Blatty'},
    {'~id': 'author4', '~label': 'Author', 'name:String': 'J. R. R. Tolkien'},
    {'~id': 'author5', '~label': 'Author', 'name:String': 'Stephen King'}
]

edges = [
    {'~id': 'e-1', '~label': 'TYPE_OF', '~from': 'book1', '~to': 'genre1'},
    {'~id': 'e-2', '~label': 'TYPE_OF', '~from': 'book2', '~to': 'genre2'},
    {'~id': 'e-3', '~label': 'TYPE_OF', '~from': 'book3', '~to': 'genre3'},
    {'~id': 'e-4', '~label': 'TYPE_OF', '~from': 'book4', '~to': 'genre4'},
    {'~id': 'e-5', '~label': 'TYPE_OF', '~from': 'book5', '~to': 'genre3'},
    {'~id': 'e-6', '~label': 'TYPE_OF', '~from': 'book6', '~to': 'genre3'},

    {'~id': 'e-7', '~label': 'WRITTEN_BY', '~from': 'book1', '~to': 'author1'},
    {'~id': 'e-8', '~label': 'WRITTEN_BY', '~from': 'book2', '~to': 'author2'},
    {'~id': 'e-9', '~label': 'WRITTEN_BY', '~from': 'book3', '~to': 'author3'},
    {'~id': 'e-10', '~label': 'WRITTEN_BY', '~from': 'book4', '~to': 'author4'},
    {'~id': 'e-11', '~label': 'WRITTEN_BY', '~from': 'book5', '~to': 'author5'},
    {'~id': 'e-12', '~label': 'WRITTEN_BY', '~from': 'book6', '~to': 'author5'},
]
