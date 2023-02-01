import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule, Title } from '@angular/platform-browser';
import { TableModule } from 'primeng/table';
import { AppComponent } from './app.component';
import { BooksService } from './books.service';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    TableModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [BooksService, Title],
  bootstrap: [AppComponent]
})
export class AppModule { }
