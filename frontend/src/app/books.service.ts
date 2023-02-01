import { Injectable } from '@angular/core';
import { Book } from './utils';

const ELEMENT_DATA: Book[] = [
  { id: 1, name: 'The Count of Monte Cristo', genre: 'Adventure fiction', author: 'Alexandre Dumas' },
  { id: 2, name: 'Don Quixote', genre: 'Adventure fiction', author: 'Miguel de Cervantes' },
  { id: 3, name: 'The Great Gatsby', genre: 'Adventure fiction', author: 'F. Scott Fitzgerald' },
];

@Injectable({
  providedIn: 'root'
})
export class BooksService {

  constructor() { }

  getElements() {
    return ELEMENT_DATA;
  }
}
