import { Component } from "@angular/core";
import { Http } from "@angular/http";
import { Router } from "@angular/router";

import template from "./template.html";

var ClientSearchComponent = Component({
  selector: "fidiyo-client-search",
  template: template
}).Class({
  constructor: [
    Http,
    Router,
    function(http, router) {
      this.clients = null;
      this.http = http;
      this.router = router;

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

  viewDetails: function(client) {
    this.router.navigate(["/", client.id]);
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

export { ClientSearchComponent };
