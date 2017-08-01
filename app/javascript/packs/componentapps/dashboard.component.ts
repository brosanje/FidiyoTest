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
 <ng-template #library>
 <div class = "container">
 <div class = "row">
 <button (click)="toHome()" class = "btn-sm btn-success center-block"><span class="glyphicon glyphicon-remove"></span> back</button></div>
 <div *ngIf = "reviewVideo" class = "jumbotron">
 <div class = "row">
 <button (click)="toggledisplay(activeVideo[0])" class = "btn btn-danger btn-block">Video: {{ activeVideo[0].resource_path }} </button><div  class="checkbox">
   <label ><input (click) = "toggleselectVideo(activeVideo[0])" type="checkbox" [checked] = "activeVideo[0].isSelect">Send Video</label>
 </div></div>
 <video  [src] = "resourcePath" class = "center-block" controls autoplay></video></div>
 <div *ngIf = "browse">
   <div class = "row" *ngFor="let video of videos"  >
     <button (click)="toggledisplay(video)" class = "btn btn-primary btn-block">Video: {{ video.resource_path }} </button><div  class="checkbox">
       <label ><input (click) = "toggleselectVideo(video)" type="checkbox" [checked] = "video.isSelect">Send Video</label>
     </div>
   </div>
 </div>
 <div class = "row">
 <button (click)="sendVideos()" class = "btn-sm btn-success center-block"><span class="glyphicon glyphicon-upload" ></span>  Send</button></div>
 </div>
 </ng-template>
 <!-- Home Screen Record Browse Admin -->
 <ng-template #home>
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
 </ng-template>

 <ng-template #send>
 </ng-template>
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
   browse: boolean;
   activeVideo: any;
   resourcePath: string;

   constructor( public http: Http, private vcRef: ViewContainerRef, private router: Router) {
     this.refresh_switch = true;
     this.reviewVideo = false;
     this.browse = true;
     this.videos = [];
     this.videostoSend = [];
     this.activeVideo = [];
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
     this.videostoSend.forEach(video => {alert(video.url);});
     this.videostoSend = [];
   }
    toggledisplay(video: any){
     //console.log(video);
    //   console.log(video);
      this.browse? this.browse = false: this.browse = true
      this.reviewVideo? this.reviewVideo = false: this.reviewVideo = true
      if(this.reviewVideo){this.activeVideo.push(video);   this.resourcePath = "../../videos/"+this.activeVideo[0].resource_path;console.log(this.resourcePath);}else { this.activeVideo = [];}


    //   console.log(video);
   }
   toggleselectVideo(video: any){ console.log("integer1");
     this.videos.forEach(shadow => {
       console.log("integer2");
       if(video.url === shadow.url ){
         console.log("integer3");
          shadow.isSelect = !shadow.isSelect;
       }
     });
   }

   browseLibrary(){
  this.vcRef.clear();
  this.vcRef.createEmbeddedView(this.displayLibrary);
  this.http.request('../../videos.json').subscribe((res: Response) => {this.videos = res.json().videos});
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

  toHome(){
    this.reviewVideo = false;
    this.browse = true;
    this.videos = [];
    this.videostoSend = [];
    this.activeVideo = [];
    this.status = "home";
    this.display();
    }
 }
