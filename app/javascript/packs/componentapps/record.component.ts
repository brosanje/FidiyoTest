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
/*
import { dashboard } from './dashboard'
import { record, document, Scripts, ScriptStore, ScriptS} from './record'*/

var primalelmer = document.querySelector('script#jsmain').src;

export declare var document;
export interface Scripts {
   name: string;
   src: string;
}
export const ScriptStore: Scripts[] = [
   {name: 'webrtcadapter', src: 'https://webrtc.github.io/adapter/adapter-latest.js'},
   {name: 'mediarecorder', src: primalelmer}
];

@Injectable()
export class ScriptService {

public scripts: any = {};

constructor() {
    ScriptStore.forEach((script: any) => {
        this.scripts[script.name] = {
            loaded: false,
            src: script.src
        };
    });
}

 load(...scripts: string[]) {
    var index = 0;
    var promises: any[] = [];
    scripts.forEach((script) => {index++,promises.push(this.loadScript(script,true,index))});
    return Promise.all(promises);
}

loadScript(name: string, attempt: boolean, index: number) {

    return new Promise((resolve, reject) => {
        //resolve if already loaded
        if (this.scripts[name].loaded) {
            resolve({script: name, loaded: true, status: 'Already Loaded'});
            var scriptelement = document.getElementById('mainjs'+index);
            scriptelement.parentNode.removeChild(scriptelement);
            console.log('script removed for ' + index);
            var attempt = false;
        }
            //load script
            console.log('adding script for ' + index);
            let script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = this.scripts[name].src;
            script.id = "mainjs"+index;
            if (script.readyState) {  //IE
                script.onreadystatechange = () => {
                    if (script.readyState === "loaded" || script.readyState === "complete") {
                        script.onreadystatechange = null;
                        this.scripts[name].loaded = true;
                        resolve({script: name, loaded: true, status: 'Loaded'});
                        attempt = false;
                    }
                };
            } else {  //Others
                script.onload = () => {
                    this.scripts[name].loaded = true;
                    resolve({script: name, loaded: true, status: 'Loaded'});
                };
            }
            script.onerror = (error: any) => resolve({script: name, loaded: false, status: 'Loaded'});
            document.getElementsByTagName('head')[0].appendChild(script);

    });
}

}

@Component({
  providers: [ScriptService],
 selector: 'record',
 template: `
 <template #record>
  <div class = "container" id='container'>
 <button class = "btn btn-primary" id='exit' (click)="toHome()" >Exit</button>
    <h1 class = "text-center">powered by fidiyo</h1>
    <video class = "center-block"   id='gum' autoplay ></video>
    <video class = "center-block" style="display:none;" id='recorded'   ></video>
    <canvas class = "center-block"  style="display:none;" id='canvas'></canvas>
    <img class = "center-block"  style="display:none;" id = 'captured' src ='' >

    <progress class = "center-block" style="background-color:grey;display:none;" id="videostream" ></progress><div class = "text-center" id = "duration"></div>
<div style="margin-top:1%; min-margin-top:10px;">
<div class = "nav navbar-inverse" style="border-radius:3px; postion: relative;">

  <div class="btn-group " style="max-margin-left:5px; margin-left:1em;">
      <button #recordButton (click) = "toggleselect(recordButton)" class = "btn btn-primary navbar-btn" id='record' disabled><span class="glyphicon glyphicon-facetime-video"></span> Start Recording</button>
      <button class = "btn btn-primary navbar-btn" id='capture' disabled><span class="glyphicon glyphicon-camera"></span> Take a Picture</button>
  </div>
  <div class="btn-group mx-auto" style="position:absolute;
    left: 50%;
    transform: translateX(-50%);">
  <button #playButton class = "btn btn-primary navbar-btn" id='play' disabled><span class="glyphicon glyphicon-play-circle"></span> Play</button>
  <button #flipButton class = "btn btn-primary navbar-btn" id='flip'> <span class="glyphicon glyphicon-refresh"></span> </button>
  <button #pauseButton class = "btn btn-primary navbar-btn" id='pause' disabled><span class="glyphicon glyphicon-pause"></span> Pause</button>
</div>
      <div class = "btn-group pull-right"  style="max-margin-right:5px; margin-right:1em;">
      <button  class = "btn btn-primary navbar-btn" id='download' disabled><span class="glyphicon glyphicon-download-alt"></span> Save Video</button>
      <button  class = "btn btn-primary navbar-btn " id='saveimg' disabled><span class="glyphicon glyphicon-download-alt"></span> Save Image</button>
      <button  class = "btn btn-primary navbar-btn" id='send' disabled><span class="glyphicon glyphicon-upload"></span> Send file</button>
      </div>
      </div>
    </div>
    </div>
 </template>

 <template #send>
 </template>
`
})
export class record {
  @ViewChild('record') displayRecord: TemplateRef<any>;
  @ViewChild('send') displaySend: TemplateRef<any>;
  refresh_switch: boolean;
  status: string;
  constructor( public http: Http, public script: ScriptService, private vcRef: ViewContainerRef, private router: Router) {
    this.refresh_switch = true;
    this.status = 'record';

  }
  ngOnInit(){
   this.vcRef.clear();
   this.vcRef.createEmbeddedView(this.displayRecord);
   this.script.load('mediarecorder', 'webrtcadapter').then(data => {console.log('script loaded ', data);}).catch(error => console.log(error));
  }
  display() {
    if (this.status === "record"){
      this.vcRef.clear();
      this.vcRef.createEmbeddedView(this.displayRecord);
      this.refresh_switch = false;
      console.log(this.refresh_switch);
      this.refresh_switch = true;
      console.log(this.refresh_switch);
    }
    else if (this.status === "send"){
      this.vcRef.clear();
      this.vcRef.createEmbeddedView(this.displaySend);
    }
  }
  toRecord(){
    this.status = "record";
    this.display();
    this.script.load('mediarecorder', 'webrtcadapter').then(data => {console.log('script loaded ', data);}).catch(error => console.log(error));
  }
  logout() { //PLUG:: resets session information
    console.log('logging out');
    this.http.get('server/reset.php').map((res: Response) => res.text()).subscribe(data => {
      console.log(data)
      window.location.href = "login.html";
    });
  }
  toHome(){
    this.router.navigate(['/dashboard']);
  }
  toggleselect(domElement: any){
    if(domElement.classList.contains('btn-primary')){
      domElement.classList.remove('btn-primary');
      domElement.classList.add('btn-danger');
    }
    else if(domElement.classList.contains('btn-danger')){
      domElement.classList.remove('btn-danger');
      domElement.classList.add('btn-primary');
    }

  }
}
