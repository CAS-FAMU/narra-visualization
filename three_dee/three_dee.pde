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

ArrayList entries;

float SPREAD = 250;
PVector rot;

PImage back;
PFont font;


String projectName = "kofs_archive";

JSONObject project;
JSONArray items; 

void setup(){

  size(1024,768,OPENGL);

  rot = new PVector(0,0);

  back = loadImage("background.png");

  font = createFont("Monospaced",9,false);
  textFont(font);

  project = loadJSONObject("http://api.narra.eu/v1/projects/"+projectName+"/items?token=Njc5OTMw");
  items = project.getJSONArray("items");

  println(items.size());

  entries = new ArrayList();

  for(int i= 0;i<items.size();i++){
    try{
      project = items.getJSONObject(i);
      String nm = project.getString("name")+"";
      JSONArray thumbs = project.getJSONArray("thumbnails");
      String filename = thumbs.getString(0)+"";
      println(nm);
      entries.add(new Entry(nm+"",filename+""));
    }catch(Exception e){
      println(e);
    }
  }

  for(int i= 0;i<entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.mkCn();
  }

}

//////////////////////////////////////////////


void draw(){

  //background(255);
  noTint();
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

  PImage thumb;
  PVector pos;
  PVector tpos;
  PVector pos2D;

  ArrayList connections;
  float numC = 5;

  Entry(String _name, String _filename){

    name = _name+"";//entries.size()+" test";
    filename = _filename;


    thumb = loadImage(filename);

    if(name==null)
      name="error";

   pos = tpos = new PVector(random(-SPREAD,SPREAD),random(-SPREAD,SPREAD),random(-SPREAD,SPREAD));
    //pos = new PVector(0,0,0);

    connections = new ArrayList();
  }

  void mkCn(){
    for(int i = 0 ; i < numC;i++)
      connections.add(new Connection(this));
  }

  void draw(){
    //pos = new PVector( (tpos.x-pos.x)/100.0, (tpos.y-pos.y)/100.0, (tpos.z-pos.z)/100.0 );
   
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
    if(over())
      text(name,10,0);

    noFill();
    stroke(0);
    //rect(10,10,64,32);
    tint(255, pow(map(dist(pos2D.x,pos2D.y,mouseX,mouseY),0,width,1,0),1.5)*255 );
    image(thumb,10,10,64,32);
    popMatrix();

    for(int i = 0 ; i < connections.size();i++){
      Connection c = (Connection)connections.get(i);
      c.update();
      stroke(0,c.weight*127);
      Entry tmp = (Entry)c.b;
      if(tmp!=this)
        line(pos2D.x,pos2D.y,tmp.pos2D.x,tmp.pos2D.y);
    }
  }

  boolean over(){
    boolean answer = false;
    if(abs(mouseX-screenX(0,0,0)) < 20 && abs(mouseY-screenY(0,0,0)) < 20)
      answer = true;
    return answer;
  }
}

//////////////////////////////////////////////
