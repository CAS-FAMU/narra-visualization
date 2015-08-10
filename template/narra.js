
/**
  Copyright (C) 2015 Krystof Pesek

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, see <http://www.gnu.org/licenses/>.

*/

//////////////////////////////////////////////////////////////////////////////////

var project_name = 'faif';
var debug = false;

var url;
var data;
var items;
var font;

var project;
var token;
var itms = [];
var loaded = false;

var Y = 0;

var sel = 0;

//////////////////////////////////////////////////////////////////////////////////

function preload(){
  //token = loadStrings('assets/token.txt');
  // url = 'http://api.narra.eu/v1/projects/'+project_name+'/?token='+token;
  //data = loadJSON(url);
  font = loadFont('assets/ProFontWindows.ttf');
  url = 'http://api.narra.eu/v1/projects/'+project_name+'/items?token='+token;
  items = loadJSON(url);


}




function setup() {

  createCanvas(windowWidth,windowHeight); 


  textFont(font,9,false);
  /*
     project = Project(
     data.project.name,
     data.project.title,
     data.project.description,
     data.project.author,
     data.project.synthetizers,
     data.project.visualizations,
     data.project.public,
     data.project.thumbnails,
     data.project.contributors,
     data.project.libraries
     );
     */
  if(!loaded){

    for(var i = 0 ; i < items.items.length;i++){
      itms[i] = new Item(
        items.items[i].id,
        items.items[i].name,
        items.items[i].type,
        items.items[i].prepared,
        items.items[i].thumbnails,
        items.items[i].video_proxy_hq,
        items.items[i].video_proxy_lq 
      );
    }
    loaded = true;
  }


}

//////////////////////////////////////////////////////////////////////////////////
function draw() {
  background(255);
  
  for( var q = 0 ; q < itms.length ; q++ ){
    itms[q].update();
    itms[q].draw();
  }
  if(frameCount%100==0){
  for( var q = 0 ; q < itms.length ; q++ ){
    itms[q].stop();
  }
  }
/*
  if(frameCount%100==0){
    itms[sel].stop();
    sel++;
    sel = sel % itms.length;
    itms[sel].play();
  }
  */
}

function Project(name,title,desc,author,synths,vis,pub,thumbnails,contrib,libs){
  this.name = name;
  this.title = title;
  this.desc = desc;
  this.desc = desc;
  this.author = author;
  this.synths = synths;
  this.vis = vis;
  this.pub = pub;
  this.thumbnails = thumbnails;
  this.contrib = contrib;
  this.libs = libs;

  this.images = [];

  for(var i = 0 ; i < this.thumbnails.size;i++){
    this.images[i] = loadImage(this.thumbnails[i]);
  } 

  this.draw = function(){
    background(255);
    fill(0);
    text(this.title,100,100);
    text(this.desc,100,120,400,400);
    image(images[0],10,10);

  }
}

//////////////////////////////////////////////////////////////////////////////////
function Library(){
}

//////////////////////////////////////////////////////////////////////////////////
function Item(id,name,type,prepared,thumbnails,video_hq,video_lq){
  this.id = id;
  this.name = name;
  this.type = type;
  this.prepared = prepared;
  this.thumbnails = thumbnails;
  this.video_hq = video_hq;
  this.video_lq = video_lq;

  this.imag = loadImage(this.thumbnails[0]+'');

  this.x = random(width);
  this.y = random(height);
  this.w = 160;
  this.h = 90;

  this.over = false;
  this.playing = false;


  Y+=20;

  this.video = createVideo(this.video_lq);
  this.video.hide();
/*
  if(debug){
    println('adding item'+this.name);
  }
*/
  this.update = function(){
//    this.x = this.x + random(-1,1);
//    this.y = this.y + random(-1,1);
    this.isOver();
    if(this.over && !this.playing){
      this.play();
      this.playing = true;
    }
  }

  this.draw = function(){
    tint(255,100);
    image(this.video,this.x,this.y,this.w,this.h);
    rect(this.x,this.y,10,10);
    //textFont(font,9,false);
    text(""+this.name,this.x,this.y);
  }

  this.play = function(){
    this.video.loop();
  }

  this.stop = function(){
    this.video.stop();
  }

  this.isOver = function(){
    if(mouseX > this.x && mouseX < this.x+this.w &&
      mouseY > this.y && mouseY < this.y+this.h){
      this.over = true;
    }else{
      this.over = false;
    }
  }

}

//////////////////////////////////////////////////////////////////////////////////
