import { Component, OnInit } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { environment } from 'src/environments/environment';
import { BooksService } from './books.service';
import { Book } from './utils';

@Component({
  selector: 'app-root',
  styleUrls: ['app.component.css'],
  templateUrl: 'app.component.html'
})
export class AppComponent implements OnInit {
  dataSource: Book[] = [];

  constructor(private booksService: BooksService, private title: Title) { }

  ngOnInit() {
    this.title.setTitle(environment.title);

    this.booksService.getElements().subscribe((data) => {
      this.dataSource = data;
    })
  }
}
