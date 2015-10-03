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


String projectName = "faif";

JSONObject project;
JSONArray items; 


ArrayList buttons;


String token;


float ZOOM = 1.0;

void setup(){

  size(1024,768,OPENGL);

  rot = new PVector(0,0);

  back = loadImage("background.png");

  token = loadStrings("token.txt")[0];

  font = createFont("Tahoma",11,false);
  textFont(font);

  project = loadJSONObject("http://api.narra.eu/v1/projects/"+projectName+"/items?token=Njc5OTMw");
  items = project.getJSONArray("items");

  buttons = new ArrayList();

  buttons.add(new Button("Authors",10,50));
  buttons.add(new Button("Sequences",10,70));
  buttons.add(new Button("Consequrences",10,90));

  println(items.size());

  entries = new ArrayList();

  for(int i= 0;i<items.size();i++){
    try{
      project = items.getJSONObject(i);
      String nm = project.getString("name")+"";
      JSONArray thumbs = project.getJSONArray("thumbnails");
      String filename = thumbs.getString(0)+"";
      println(nm);


      Runnable runnable = new Entry(nm+"",filename+"");
      Thread thread = new Thread(runnable);
      thread.start();

      entries.add(runnable);
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


void keyPressed(){
  if(keyCode==UP)
  ZOOM += 0.01;
  
  if(keyCode==DOWN)
  ZOOM -= 0.01;

}

void draw(){

  background(255);
  tint(255,190);
  image(back,0,0,width,height);

  pushMatrix();
  translate(width/2,height/2);
  scale(ZOOM);
  translate(-width/2,-height/2);


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

  for(int i = 0 ;i < buttons.size();i++){
    Button butt = (Button)buttons.get(i);
    butt.draw();
  }

  popMatrix();


}

//////////////////////////////////////////////

void mouseDragged(){
  rot.add(new PVector((mouseX-pmouseX)/100.0,(mouseY-pmouseY)/1000.0));
}

void mousePressed(){
  for(int i = 0 ;i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.reset();
  }


}

class Entry implements Runnable{
  String name;
  String filename;

  boolean loaded = false;

  PImage thumb;
  PGraphics thumb_bw;
  PVector pos;
  PVector tpos;
  PVector pos2D;

  ArrayList connections;
  float numC = 2;

  Entry(String _name, String _filename){

    name = _name+"";//entries.size()+" test";
    filename = _filename;

    if(name==null)
      name="error";

    tpos = new PVector(random(-SPREAD,SPREAD),random(-SPREAD,SPREAD),random(-SPREAD,SPREAD));
    pos = new PVector(0,0,0);

    connections = new ArrayList();
  }

  void reset(){
    tpos = new PVector(random(-SPREAD,SPREAD),random(-SPREAD,SPREAD),random(-SPREAD,SPREAD));
  }

  void mkCn(){
    for(int i = 0 ; i < numC;i++)
      connections.add(new Connection(this));


    Connection first = (Connection)connections.get(0);
    first.selected = true;
  }

  void run(){
    try{
      thumb = loadImage(filename);
      thumb_bw = createGraphics(thumb.width,thumb.height);

      thumb_bw.beginDraw();
      thumb_bw.image(thumb,0,0);
      thumb_bw.filter(GRAY);
      thumb_bw.endDraw();

    }catch(Exception e){
      ;
    };

    loaded = true;
  }

  void draw(){
    pos.add( (tpos.x-pos.x)/10.0, (tpos.y-pos.y)/10.0, (tpos.z-pos.z)/10.0 );
    rot = new PVector(-frameCount/400.0,0);

    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    noFill();
    if(over())
      fill(0);
    stroke(0,60);

    if(loaded)
      box(3);

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
    if(loaded && thumb!=null){
      float dist = map(dist(pos2D.x,pos2D.y,mouseX,mouseY),0,width,1,0);
      float ddist = 4.0/(pow(dist,12.0)+1);

      tint( 255 , pow(dist,10.0)*255 );

      imageMode(CENTER);
      
      if(!over())
        image(thumb_bw,0,0,thumb.width/ddist,thumb.height/ddist);
      else
        image(thumb,0,0,thumb.width/ddist,thumb.height/ddist);

      imageMode(CORNER);

    }
    popMatrix();

    for(int i = 0 ; i < connections.size();i++){
      Connection c = (Connection)connections.get(i);
      c.update();
      strokeWeight(2);
      
      stroke((c.selected && over()) ? color(255,0,0) : color(0) , c.weight*90);
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
