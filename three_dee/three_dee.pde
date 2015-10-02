/**
  Narra Project Visualization
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

//////////////////////////////////////////////
//////////////////////////////////////////////

int NUM = 20;
ArrayList entries;

float SPREAD = 250;
PVector rot;

PImage back;
PFont font;


String projectName = "mista";

JSONObject project;

void setup(){

  size(1024,768,OPENGL);

  rot = new PVector(0,0);

  back = loadImage("background.png");
  
  font = createFont("Monospaced",9,false);
  textFont(font);


  project = loadJSONObject("http://api.narra.eu/v1/projects/"+projectName+"/items?token=Njc5OTMw");
  println(project);

  entries = new ArrayList();
  for(int i= 0;i<NUM;i++){
    entries.add(new Entry());
  }

  for(int i= 0;i<NUM;i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.mkCn();
  }


}

//////////////////////////////////////////////


void draw(){

  image(back,0,0,width,height);

  pushMatrix();
  translate(width/2,height/2,0);
  rotateY(rot.x);
  rotateX(rot.y);

  for(int i = 0 ;i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.draw();
  }

  popMatrix();

  for(int i = 0 ;i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.draw2D();
  }



}

//////////////////////////////////////////////

void mouseDragged(){
  rot.add(new PVector((mouseX-pmouseX)/100.0,(mouseY-pmouseY)/1000.0));
}

class Entry{
  String name;
  String filename;

  PVector pos;
  PVector pos2D;

  ArrayList connections;
  float numC = 5;

  Entry(){
    name = entries.size()+" test";



    pos = new PVector(random(-SPREAD,SPREAD),random(-SPREAD,SPREAD),random(-SPREAD,SPREAD));
  }

  void mkCn(){
    connections = new ArrayList();
    for(int i = 0 ; i < numC;i++)
      connections.add(new Connection(this));
  }

  void draw(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    noFill();
    if(over())
      fill(0);
    stroke(0,120);
    box(10);
    pos2D = new PVector(screenX(0,0,0),screenY(0,0,0),0);
    popMatrix();
  }

  void draw2D(){
    pushMatrix();
    translate(pos2D.x,pos2D.y,0);
    fill(0);
    text(name,10,0);
    noFill();
    stroke(0);
    rect(10,10,64,32);
    popMatrix();

    for(int i = 0 ; i < connections.size();i++){
      Connection c = (Connection)connections.get(i);
      stroke(0,c.weight*127);
      Entry tmp = (Entry)c.b;
      if(tmp!=this)
        line(pos2D.x,pos2D.y,tmp.pos2D.x,tmp.pos2D.y);
    }
  }

  boolean over(){
    boolean answer = false;
    if(abs(mouseX-screenX(0,0,0)) < 100 && abs(mouseY-screenY(0,0,0)) < 100)
      answer = true;
    return answer;
  }
}

//////////////////////////////////////////////
