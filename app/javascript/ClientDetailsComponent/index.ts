import { Component } from "@angular/core";
import { ActivatedRoute } from "@angular/router";
import { Http } from "@angular/http";
import template from "./template.html";

var ClientDetailsComponent = Component({
  selector: 'fidiyo-client-details',
  template: template
}).Class(
  {
    constructor: [
      ActivatedRoute,
      Http,
      function(activatedRoute, http) {
        this.activatedRoute = activatedRoute;
        this.http = http;
        this.id = null;
        this.client = null;
      }
    ],

    ngOnInit: function() {
      var self = this;

      var observableFailed = function(response) {
        alert(response);
      };

      var clientGetSuccess = function(response) {
        self.client = response.json().client;
      };

      var routeSuccess = function(params) {
        self.http.get(
          "/clients/" + params["id"] + ".json"
        ).subscribe(
          clientGetSuccess,
          observableFailed
        );
      };

      self.activatedRoute.params.subscribe(routeSuccess, observableFailed);
    }
  }
);

export { ClientDetailsComponent };
