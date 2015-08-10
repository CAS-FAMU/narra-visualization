
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

  this.x = 100;
  this.y = Y;

  Y+=20;

  //this.video = createVideo(this.video_lq);
/*
  if(debug){
    println('adding item'+this.name);
  }
*/
  this.update = function(){
//    this.x = this.x + random(-1,1);
//    this.y = this.y + random(-1,1);
  }

  this.draw = function(){
    image(this.imag,this.x,this.y,180,120);
    rect(this.x,this.y,10,10);
    //textFont(font,9,false);
    text(""+this.name,this.x,this.y);
  }

}

//////////////////////////////////////////////////////////////////////////////////
