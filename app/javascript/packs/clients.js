import "hello_angular/polyfills";

import { Component, NgModule } from "@angular/core";
import { BrowserModule } from "@angular/platform-browser";
import { FormsModule } from "@angular/forms";
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { Http, HttpModule } from "@angular/http";

var ClientSearchComponent = Component({
selector: "fidiyo-client-search",
template: '\
<header> \
  <h1 class="h2">Client Search</h1> \
</header> \
<section class="search-form"> \
  <form> \
    <label for="keywords" class="sr-only">Keywords></label> \
    <input type="text" id="keywords" name="keywords" \
      placeholder="Name, Contact, or Email Address"\
      bind-ngModel="keywords" \
      on-ngModelChange="search($event)" \
      class="form-control input-lg"> \
  </form> \
</section> \
<section class="search-results"> \
  <header> \
    <h1 class="h3">Results</h1> \
  </header> \
  <nav> \
    <ul class="pager"> \
      <li *ngIf="page > 0" class="previous"> \
        <a (click)="decrement_page()">&larr; Previous</a> \
      </li> \
      <li *ngIf="clients != null && clients.length >= page_size" class="next"> \
        <a (click)="increment_page()">Next &rarr;</a> \
      </li> \
    </ul> \
  </nav> \
  <ol class="list-group"> \
    <li *ngFor="let client of clients" class="list-group-item clearfix"> \
      <h3 class="pull-right"><small class="text-uppercase">Joined</small> {{client.created_at}} {{ client.status }}</h3> \
      <h2> \
        {{client.name}} \
        <small>{{client.username}}</small> \
      </h2> \
      <h4 class="pull-right">{{client.email}} {{client.phone}}</h4> \
      <h3>Contact {{client.main_contact}}</h3> \
      <h5>{{client.logo}}</h5> \
    </li> \
  </ol> \
  <nav> \
    <ul class="pager"> \
      <li *ngIf="page > 0" class="previous"> \
        <a (click)="decrement_page()">&larr; Previous</a> \
      </li> \
      <li *ngIf="clients != null && clients.length >= page_size" class="next"> \
        <a (click)="increment_page()">Next &rarr;</a> \
      </li> \
    </ul> \
  </nav> \
</section> \
'
}).Class({
  constructor: [
    Http,
    function(http) {
      this.clients = null;
      this.http = http;
      this.keywords = "";
      this.page = 0;
      this.page_size = 10;
    }
  ],

  decrement_page: function() {
    if (this.page > 0 && this.clients != null && this.clients.length > 0) {
      this.page = this.page - 1;
      this.search(this.keywords);
    }
    return false;
  },

  increment_page: function() {
    if (this.clients != null && this.clients.length > 0) {
      this.page = this.page + 1;
      this.search(this.keywords);
    }
    return false;
  },

  search: function($event) {
    var self = this;
    self.keywords = $event;
    if (self.keywords.length < 3) {
      return;
    }
    self.http.get('/clients.json?keywords=' + self.keywords + '&page=' + self.page + '&page_size=' + self.page_size).subscribe(
      function(response) {
        self.clients = response.json().clients;
      },
      function(response) {
        window.alert(response);
      }
    );
  }
});

var ClientAppModule = NgModule({
  imports: [ BrowserModule, FormsModule, HttpModule ],
  declarations: [ ClientSearchComponent ],
  bootstrap: [ ClientSearchComponent ]
})
.Class({
  constructor: function() {}
});

platformBrowserDynamic().bootstrapModule(ClientAppModule);
