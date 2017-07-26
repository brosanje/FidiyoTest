import "polyfills";

import { Component, NgModule } from "@angular/core";
import { BrowserModule } from "@angular/platform-browser";
import { FormsModule } from "@angular/forms";
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { HttpModule } from "@angular/http";
import { RouterModule } from "@angular/router";

import { ClientSearchComponent } from "ClientSearchComponent";
import { ClientDetailsComponent } from "ClientDetailsComponent";

var AppComponent = Component({
  selector: 'fidiyo-clients-app',
  template: '<router-outlet></router-outlet>'
}).Class({
  constructor: [
    function() { }
  ]
});

var routing = RouterModule.forRoot(
[
  {
    path: "",
    component: ClientSearchComponent
  },
  {
    path: ":id",
    component: ClientDetailsComponent
  }
]);

var ClientAppModule = NgModule({
  imports: [ BrowserModule, FormsModule, HttpModule, routing ],
  declarations: [ ClientSearchComponent, ClientDetailsComponent, AppComponent ],
  bootstrap: [ AppComponent ]
})
.Class({
  constructor: function() {}
});

platformBrowserDynamic().bootstrapModule(ClientAppModule);
