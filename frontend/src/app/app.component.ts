import { Component, OnInit } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { environment } from 'src/environments/environment';
import { BooksService } from './books.service';

@Component({
  selector: 'app-root',
  styleUrls: ['app.component.css'],
  templateUrl: 'app.component.html'
})
export class AppComponent implements OnInit {

  constructor(private booksService: BooksService, private title: Title) { }

  ngOnInit() {
    this.title.setTitle(environment.title);
  }

  dataSource = this.booksService.getElements();
}
