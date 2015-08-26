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


int LEN = 30;

ArrayList branch;

void setup(){
  size(800,600);
  surface.setResizable(false);

  branch = new ArrayList();
  branch.add(new Branch());

  for(int i = 0 ; i<5;i++){
    Branch tmp = (Branch)branch.get(i);
    branch.add(new Branch(tmp));

  }
}


void draw(){
  background(255);

  strokeWeight(3);

  pushMatrix();
  translate(width/2,height/2);
  for(int i = 0 ; i<branch.size();i++){
    Branch tmp = (Branch)branch.get(i);
    tmp.draw();
  }
  popMatrix();
}




class Branch{
  float rot;
  float len;

  Branch parent;

  Branch(Branch _parent){
    parent = _parent;
    rot = random(-PI,PI)/10.0;
    len = LEN;
  }

  Branch(){
    parent = this;
    rot = 0;
    len = LEN;
  }

  void draw(){
    rotate(rot);
    translate(len,0);
    line(-len,0,0,0);
  }


}
