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

@Component({
 selector: 'dashboard',
 template: `
<template #library>

<button (click)="toHome()"> back </button>
<div *ngIf = "reviewVideo" class = "jumbotron">
<video  src = "activeVideo.url"></video>
<button (click)="toggleselect(activeVideo)" class = "btn btn-primary btn-block"><td >Video: {{ video.url }}</td> <td> {{ video.path }} </td> <td> {{video.time}}</td></button>
</div>
<table *ngIf = "browseLibrary">
  <tr *ngFor="let video of videos"  >
    <button (click)="toggleselect(video)" class = "btn btn-primary btn-block"><td >Video: {{ video.url }}</td> <td> {{ video.path }} </td> <td> {{video.time}}</td></button>
  </tr>
</table>
<button (click)="sendVideos()">send</button>
</template>
<!-- Home Screen Record Browse Admin -->
<template #home>
<img [src] = "profilepic" height = "190" width = "250" class = "center-block img-rounded">
<p class = "  text-center"><span class="glyphicon glyphicon-envelope"></span> Send an existing file. </p>
<p class = " text-center"><span class=" 	glyphicon glyphicon-camera"></span> Take a video/picture</p>
<div class = "fluid-container" style = " position: absolute; bottom:0px; width: 100%;">
<div class = "nav navbar-inverse container">
<ul class = "nav navbar-nav"><li><a id = "Browse" (click) = "browseLibrary()" style="cursor: pointer;">
<span class="glyphicon glyphicon-envelope"></span> Send Video</a></li></ul> <!--Browse Video Library -->
<ul class = "nav navbar-nav pull-right"><li><a id = "Record" (click) = "startRecording()" style="cursor: pointer;"> <span class=" 	glyphicon glyphicon-camera"></span> Record</a></li>
</ul>
</div>
</div>
</template>

<template #send>
</template>
 `
 })
 export class dashboard {
   @ViewChild('home') displayHome: TemplateRef<any>;
   @ViewChild('send') displayRecord: TemplateRef<any>;
   @ViewChild('library') displayLibrary: TemplateRef<any>;
   status: string;
   hassubmitted: boolean = false;
   stringResponse: string;
   videos: Array<any>;
   videostoSend: Array<any>;
   refresh_switch: boolean;
   profilepic: string;
   playsrc: string;
   reviewVideo: boolean;
   browseLibrary: boolean;
   activeVideo: any;

   constructor( public http: Http, private vcRef: ViewContainerRef, private router: Router) {
     this.refresh_switch = true;
     this.reviewVideo = false;
     this.browseLibrary = true;
     this.videos = [];
     this.videostoSend = [];
     this.profilepic = document.querySelector('view').getAttribute('profilepic'); //will not take information from the templated page unless forced.
   }
   ngOnInit(){
    this.vcRef.clear();
    this.vcRef.createEmbeddedView(this.displayHome);

   }
   startRecording(){
     this.router.navigate(['/record']);
   }
   sendVideos(){
     this.videos.forEach(video => {
       if(video.isSelect){console.log(video);  this.videostoSend.push(video);}
     });
     //httprequest with json, that sends the video_toSend array of videos to a dynamic page that can handle the information and
     alert(this.videostoSend[0].path);
   }
    toggleselect(video: any){
     //console.log(video);
     video.isSelect = !video.isSelect;
    //   console.log(video);

    if(video.classList.contains('btn-primary')){
      video.classList.remove('btn-primary');
      video.classList.add('btn-danger');
    }
    else if(video.classList.contains('btn-danger')){
      video.classList.remove('btn-danger');
      video.classList.add('btn-primary');
    }

    if(video.isSelect) {
      this.browseLibrary = false;
       this.reviewVideo = true;
       this.activeVideo = video;
       video.isSelect = !video.isSelect;
     } else {
      this.reviewVideo = false;
       this.browseLibrary = true;
      }

    //   console.log(video);
   }

browseLibrary(){
  this.vcRef.clear();
  this.vcRef.createEmbeddedView(this.displayLibrary);
  this.http.request('server/videolibrary.json').subscribe((res: Response) => {this.videos = res.json().videos});
}

display() {
    if (this.status === "home" ){console.log(this.status);
       this.vcRef.clear();
       this.vcRef.createEmbeddedView(this.displayHome);
       this.hassubmitted = false;
     }
     else if (this.status === "send"){
     }
     else if (this.status === "library"){
       this.vcRef.clear();
       this.vcRef.createEmbeddedView(this.displayLibrary);
     }
   }
   logout() { //PLUG:: resets session information
     console.log('logging out');
     this.http.get('server/reset.php').map((res: Response) => res.text()).subscribe(data => {
       console.log(data)
       window.location.href = "login.html";
     });
   }
  toHome(){
    this.status = "home";
    this.display();
    }
 }
