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


// direct narra api is accessible through 'narra' object
//
// narra.width: window width
// narra.height: window height
//
// narra.getProject(): current project
// narra.getItems(): return all project's items
// narra.getItems(synthesizer, item): return project's items in concrete synthesizer scope
// narra.getItem(item): return concrete item
// narra.getJunctions(synthesizer): return junctions in scope of synthesizer
// narra.getJunctions(synthesizer, item): return junctions in scope of synthesizer for concrete item


boolean debug = false;

int canvasWidth = narra.width;
int canvasHeight = narra.height;

float SPREAD = 250;

ArrayList entries;
PVector rot;
PImage back;
PFont font;
ArrayList buttons;
String token;

int MODE = 0;
float ZOOM = 1.0;

float XX = -100;

Object items[] = narra.getItems();
junctions = narra.getJunctions("sequence");

boolena drawI = true;
 int mode = 0;
 
 eCnt = 1;


//////////////////////////////////////////////

void mouseDragged(){
  rot.add(new PVector((mouseX-pmouseX)/100.0,(mouseY-pmouseY)/1000.0));
};

void mouseReleased(){
  for(int i = 0 ;i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.reset();
  };
  
};

///////////////////////


void setup() {
  size(canvasWidth, canvasHeight);
  
  rot = new PVector(0,0);
  //String[] fontList = PFont.list();
  font = createFont("Verdana",11);
  textFont(font);

  
  
  
  buttons = new ArrayList();

  buttons.add(new Button("mesh",10,150,0));
  buttons.add(new Button("line",10,170,1));
  buttons.add(new Button("circle",10,190,2));

  
  entries = new ArrayList();

  XX = -canvasWidth/2.0+200;
  for(int i= 0;i<items.length;i++){
    try{
      entries.add(new Entry(items[i].name,items[i],items[i].thumbnails[0]));
    }catch(Exception e){
      println(e);
    };
  };

  for(int i= 0;i<entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.mkCn();
  };
  
}

////////////////////////////////////////////


void draw() {
   background(255);
  //tint(255,190);
  //image(back,0,0,width,height);

  pushMatrix();
  translate(width/2,height/2);
  scale(ZOOM);
  translate(-width/2,-height/2);


  pushMatrix();
  translate(width/2,height/2,0);
  //rotateY(rot.x);
  rotate(rot.y);

  for(int i = 0 ;i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.draw();
  };

  popMatrix();

if(drawI)
  for(int i = 0 ;i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.drawImages();
  };

  for(int i = 0 ;i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.draw2D();
  };
  
  

  for(int i = 0 ;i < buttons.size();i++){
    Button butt = (Button)buttons.get(i);
    butt.draw();
  };

  popMatrix();
}


/// classes 

class Entry{
  String name;
  String filename;
  color colors[] = {color(#ffcc00),color(255,0,0),color(0,127,255)};
  boolean loaded = false;
  Object [] jx;
  
  Object parent;
  int id;
  
  PImage thumb;
  PGraphics thumb_bw;
  
  PVector align;
  PVector circ;
  
  PVector pos;
  PVector tpos;
  PVector pos2D;
  boolean over = false;

  ArrayList connections;
  float numC = 3;
  
  int iid;
  
  float dist,ddist;



  Entry(String _name, Object _parent, String _filename){
    parent = _parent;
    
    name = _name+"";
    id = parent.id;
    
    filename = _filename+"";

    if(name==null)
      name="error";
      
      align = new PVector(XX,canvasHeight/2-300);
      XX += (canvasWidth-400) / (items.length()+0.0);;

    tpos = new PVector(random(-SPREAD,SPREAD),random(-SPREAD,SPREAD),random(-SPREAD,SPREAD));
    pos = new PVector(0,0,0);
    
    float an = eCnt / (items.length()+0.0);
    eCnt++;
    circ = new PVector(cos(an*TWO_PI)*300,sin(an*TWO_PI)*300);
    
    connections = new ArrayList();
    
    run();
  };



  void isOver(){
    over = false;
    if(abs(mouseX-screenX(0,0,0)) < 20 && abs(mouseY-screenY(0,0,0)) < 20){
      over = true;
    };
  };
  
  void reset(){
    
    if(mode==0)
    tpos = new PVector(random(-SPREAD,SPREAD),random(-SPREAD,SPREAD),random(-SPREAD,SPREAD));
    
    if(mode==1)
    tpos = new PVector(align.x,align.y);
    
    if(mode==2)
    tpos = new PVector(circ.x,circ.y);
    
      
  };

  void mkCn(){
      ArrayList myConn = new ArrayList();
      int cnt = 0;
      
      for(int i = 0 ; i < junctions.length;i++){
        if(junctions[i].items[0].id==id){
          cnt++;
          myConn.add(i);
      }
    }
    
    if(debug)
    println("debug " + cnt);
    
    for(int i = 0 ; i < myConn.size();i++){
        int sel = (int)myConn.get(i);
        connections.add(new Connection(this,sel));
    }


    //Connection first = (Connection)connections.get(0);
    //first.selected = true;
  };

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
  };

  void draw(){
    
    pos.add( (tpos.x-pos.x)/10.0, (tpos.y-pos.y)/10.0, (tpos.z-pos.z)/10.0 );
    
    rot = new PVector(-frameCount/800.0,0);

    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    
    
    
    //text(name,0,0);
    
    noFill();
    stroke(0,90);

    if(loaded){
      box(3);
    };

    pos2D = new PVector(screenX(0,0,0),screenY(0,0,0),0);
    popMatrix();
  };
  
  
    void drawImages(){
        pushMatrix();
          translate(pos2D.x,pos2D.y,0);
          isOver();
          imageMode(CENTER);
          image(thumb,0,0,thumb.width/4,thumb.height/4);
        popMatrix();
    };

  void draw2D(){
    pushMatrix();
    translate(pos2D.x,pos2D.y,0);
    fill(0);
    
    isOver();
    
    /*
    if(over){
      text(name,10,0);
    };
    */
      
    

    noFill();
    stroke(0);
    //rect(10,10,64,32);
      dist = map( sqrt( pow(pos2D.x-mouseX)+pow(pos2D.y-mouseY)),0,width,1,0);
      ddist = 4.0/(pow(dist,12.0)+1);
    if(loaded && thumb!=null){

      //tint( 255 , pow(dist,10.0)*255 );

      //imageMode(CENTER);
      
      //if(!over)
        //image(thumb_bw,0,0,thumb.width/ddist,thumb.height/ddist);
      //else
      //  image(thumb,0,0,thumb.width/ddist,thumb.height/ddist);

      //imageMode(CORNER);

    };
    
    
    popMatrix();

    for(int i = 0 ; i < connections.size();i++){
      Connection c = (Connection)connections.get(i);
      c.update();
      strokeWeight(2);
      stroke(0,120);
      noFill();
      
      //stroke(c.selected ? colors[MODE] : color(0) , c.weight*255/(dist*10));
      Entry tmp = (Entry)c.b;
      if(tmp!=this)
      {
        //line(pos2D.x,pos2D.y,tmp.pos2D.x,tmp.pos2D.y);
        float cx = abs(pos2D.x-tmp.pos2D.x)/2;
        float cy = abs(pos2D.y-tmp.pos2D.y);
        
        if(mode==2){
            cx=0;
            cy=0;
        
        }
        //float dia = sqrt(pow(tmp.pos2D.x-pos2D.x) * pow(tmp.pos2D.y-pos2D.y));
        
        bezier(pos2D.x,
        pos2D.y-thumb.height/8,
        pos2D.x,
        pos2D.y-cx-thumb.height/8,
        tmp.pos2D.x,
        tmp.pos2D.y-cx-thumb.height/8,
        tmp.pos2D.x,
        tmp.pos2D.y-thumb.height/8);
        
      }
    };
    
    
  };

};

//////////////////////////////////////////////

Entry getById(String _id){
    
    Entry tmp = null;
    
    find:
    for(int i = 0 ;i < entries.size();i++){
        Entry curr = (Entry)entries.get(i);
        if(curr.id == _id){
        tmp = curr;
        break find;
        }
    }
    
    return tmp;
    
}


class Connection{
  float weight;
  Entry a,b;
  PVector mid;
  boolean selected = false;


  Connection(Entry _a,int sel){
    a=_a;
    b = (Entry)getById(junctions[sel].items[1].id);
    
    if(debug)
    println(a.id+" ----> "+b.id);
      
    weight = random(0,100)/100.0;
    
    /*
    b = (Entry)entries.get((int)random(entries.size()));
    while(a==b){
      b = (Entry)entries.get((int)random(entries.size()));
    };
    */
          /*
    for(int i = 0 ; i < junctions.length;i++){
        if(junctions[i].items[0].id == a.id){
            b = (Entry)getById(junctions[i].items[1].id);
        }
    }
    */
    
  };

  void update(){
    mid = new PVector(
        lerp(a.pos.x,b.pos.x,0.5),
        lerp(a.pos.y,b.pos.y,0.5),
        lerp(a.pos.z,b.pos.z,0.5)
        );

  };
};


/////////////////////////////////////////////////




class Button{

  String name;
  PVector pos;
  int MODE;

  Button(String _name,int _x,int _y,int _mode){
    MODE = _mode;
    name=  _name;
    pos = new PVector(_x,_y,0);
  };

  void draw(){
    pushMatrix();
    translate(pos.x,pos.y,0);
    fill( over() ? color(#ffcc00) : color(0) );
    text(name,0,0);
    popMatrix();

    if(over()&&mousePressed){
    mode=MODE;
    };
  };

  boolean over(){
    boolean answer = false;
    if(mouseX>pos.x&&mouseX<(pos.x+textWidth(name)) && mouseY < pos.y && mouseY > pos.y-12)
    {
      answer = true;
    };
    return answer;
  };

};


