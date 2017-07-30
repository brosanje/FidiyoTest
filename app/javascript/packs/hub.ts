import "polyfills";

import {
Component, NgModule,TemplateRef, ViewChild, ViewContainerRef
} from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators, AbstractControl }   from '@angular/forms';
import { Response, Http, HttpModule, URLSearchParams, Headers, RequestOptions} from '@angular/http';
import 'rxjs/add/operator/map';
import {Injectable} from "@angular/core";
import { RouterModule, Routes, Router } from '@angular/router';

import { dashboard } from './componentapps/dashboard.component';
import { record, document, Scripts, ScriptStore} from './componentapps/record.component';


 @Component({

   template: '<h2>Page not found</h2>'
 })
 export class PageNotFoundComponent {}


 const appRoutes: Routes = [
   { path: '', component: dashboard },
   { path: 'dashboard', component: dashboard },
   { path: 'record', component: record },
   { path: '**', component: PageNotFoundComponent }
 ];

@Component({
 selector: 'view',
 template: `<!--<dashboard></dashboard>
 <record></record>-->
 <router-outlet></router-outlet>
 `

 })
 export class hub {
   constructor(){

   }
 }


  @NgModule({
  declarations: [ hub, dashboard, record, PageNotFoundComponent,
   // add this
  ],
  imports: [ BrowserModule,ReactiveFormsModule, HttpModule, RouterModule.forRoot(appRoutes,  { enableTracing: true } // <-- debugging purposes only
  )],
  bootstrap: [ hub,],
  })
  class ViewAppModule {}

  platformBrowserDynamic().bootstrapModule(ViewAppModule);
