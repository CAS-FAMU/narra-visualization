/*
   Visualtisation of narra.eu project written by Krystof Pesek
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


int NUM = 20;
int ID = 0;

float RADIUS = 200;

ArrayList entries;

void setup(){
  size(800,600);
//  surface.setResizable(false);

  entries = new ArrayList();

  for(int i = 0 ; i<NUM;i++){
    entries.add(new Entry());
  }

  for(int i = 0 ; i<NUM;i++){
    Entry tmp= (Entry)entries.get(i);
    tmp.makeConnections(5);
  }
}


void draw(){
  background(255);

  strokeWeight(1);

  for(int i = 0 ; i<entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    if(tmp.ovr)
    tmp.drawConnections(); 
  }

  strokeWeight(2);

  pushMatrix();
  translate(width/2,height/2);
  for(int i = 0 ; i<entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    pushMatrix();
    rotate(map(i,0,entries.size(),0,TWO_PI));
    translate(0,RADIUS);
    tmp.draw();
    popMatrix();
  }

  popMatrix();
}




class Entry{

  int id;
  ArrayList connections;
  PVector pos;
  PVector absPos;
  PImage img;
  float len;
  String name;
  boolean ovr;

  Entry(){
    id = ID;
    ID++;
    name = "test_"+id;
    pos = new PVector(0,0);//random(10,width-10),random(10,height-10));
    absPos = new PVector(0,0);


    img = loadImage("img.jpg");
  }

  void makeConnections(int num){
    connections = new ArrayList();

    for(int i = 0 ; i < num;i++){
      Entry tmp = (Entry)entries.get((int)random(0,entries.size()));

      if(tmp!=this){
        connections.add(new Connection(this,tmp));
      }
    }
  }

  void draw(){
    rectMode(CENTER);
    fill(255);
    stroke(0);

    rect(pos.x,pos.y,10,10);

    absPos.x = screenX(pos.x,pos.y);
    absPos.y = screenY(pos.x,pos.y);

    ovr = over();
  }

  boolean over(){
    boolean answer = false;

    if(
        mouseX > absPos.x-15 && mouseX < absPos.x + 15 && 
        mouseY > absPos.y-15 && mouseY < absPos.y + 15 
      ) 
      answer = true;

    return answer;
  }

  void drawConnections(){
    imageMode(CENTER);
    image(img,absPos.x,absPos.y,64,32);
    for(int i = 0 ; i < connections.size();i++){
      Connection c = (Connection)connections.get(i);
      c.draw();
    }
  }
}


class Connection{
  int id;
  Entry A,B;

  Connection(Entry _a, Entry _b){
    A = _a;
    B = _b;
  }

  void draw(){
    noFill();
    stroke(0,120);
    bezier(A.absPos.x,A.absPos.y,width/2,height/2,width/2,height/2,B.absPos.x,B.absPos.y);
  }

}
