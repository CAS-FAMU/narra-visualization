
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

var url;
var data;
var items;
var font;

var project;

function preload(){
  url = 'http://api.narra.eu/v1/projects/faif/?token=Njc5OTMw';
  data = loadJSON(url);
  url = 'http://api.narra.eu/v1/projects/faif/items?token=Njc5OTMw';
  items = loadJSON(url);
  font = loadFont('assets/ProFontWindows.ttf');
}

function setup() {
  createCanvas(800,600);

  textFont(font,9,false);
  project = Project();
}

function draw() {
  project.draw();
}

function Project(){
  this.title = data.project.title;
  this.desc = data.project.description;

  this.draw = function(){
    background(255);
    fill(0);
    text(this.title,100,100);
    text(this.desc,100,120,400,400);
  }
}




function Item(id,name,type,prepared,thumbnails,video_hq,video_lq){
  this.id = id;
  this.name = name;
  this.type = type;
  this.prepared = prepared;
  this.thumbnails = thumbnails;
  this.video_proxy_hq = video_hq;
  this.video_proxy_lq = video_lq;

}

