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

float RADIUS = 100;

ArrayList entries;

void setup(){
  size(800,600);
  surface.setResizable(false);

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

  strokeWeight(3);

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
  PImage img;
  float len;
  String name;

  Entry(){
    id = ID;
    ID++;
    name = "test_"+id;
    pos = new PVector(0,0);//random(10,width-10),random(10,height-10));

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
  }
}


class Connection{
  int id;
  Entry A,B;

  Connection(Entry _a, Entry _b){
    A = _a;
    B = _b;
  }

}
