// direct narra api is accessible through 'narra' object
//
// narra.width: window width
// narra.height: window height
//
// Object project [] = narra.getProject();// current project
// Object items [] = narra.getItems(); //return all project's items
// narra.getItems(synthesizer, item): return project's items in concrete synthesizer scope
// Object data [] = narra.getItem(item);//: return concrete item
// narra.getJunctions(synthesizer, item): return junctions in scope of synthesizer for concrete item


Object junctions[] = narra.getJunctions("sequence"); //return junctions in scope of synthesizer

int canvasWidth = narra.width;
int canvasHeight = narra.height;

int w,h;
int divider = 4;

ArrayList connections,items,authors;


void setup() {
  size(canvasWidth, canvasHeight);
  
  imageMode(CENTER);
  textFont(createFont("Tahoma",9,false));
  
  connections = new ArrayList();
  items = new ArrayList();
        
  
  for(int i = 0 ; i < junctions.length;i++){
        //println(junctions[i]);
        connections.add(new Connection(junctions[i],i));    
  }
  
  uniq();
  
  for(int i = 0 ; i < connections.size();i++){
        Connection tmp = (Item)connections.get(i);
        tmp.castConnections();    
  }
  
}

void uniq(){
    
    
    
    for(int c = 0 ; c < items.size();c++){
        Item tmp1 = (Item)items.get(c);
        
        for(int i = 0 ; i < items.size();i++){
            Item tmp2 = (Item)items.get(i);
            
            if(i!=c && tmp1.id==tmp2.id){
              items.remove(tmp2);
            }
            
        }
    
    }
    
}

void draw() {
    
  w = 0;
  h = 100;
  
  background(255);
  for(int i = 0 ; i< items.size();i++){
    Item current = (Item)items.get(i);
    h+=12;
    current.draw();
  }
  
}

class Connection{
    Object data;
    float weight;
    Item a,b;
    int id;
    int W = 320;
    int H = 240;
    
    
    Connection(Object _data,int _id){
        data = _data;
        id = _id;
        // images = new ArrayList();
        println("got junction between "+data.items[0].id+" -> "+data.items[1].id);
        
        a = new Item(data.items[0].id);
        b = new Item(data.items[1].id);
        
        
        
        items.add(a);
        items.add(b);
        
        
    }
    
    void castConnections(){
        for(int i = 0 ; i < items.size();i++){
            Item tmp = (Item)items.get(i);
            if(tmp.id==a.id || tmp.id == b.id){
                tmp.addCon(this);            
            }
        }
    }
    
    
    void draw(){
        // compute();
        
    }
    
    void compute(){
        for(int i = 0 ; i < images.size();i++){
      
         float dd = map(dist(mouseX,mouseY,holders[i].w,holders[i].h),0,dist(canvasWidth,canvasHeight,0,0),1,0);
         dd = pow(dd,20)*200;
        //  holders[i].distance = dd;
        }
    }
}

class Item{
    Object data[];
    PImage thumb;
    ArrayList con;
    String id;
    int x,y;
    
    
    Item(String _id){
        id = _id;
        data = narra.getItem(id);
        thumb = loadImage(data.thumbnails[0]);
        println("creating object "+data.name);
        x = (int)random(canvasWidth);
        y = (int)random(canvasHeight);
        
        con = new ArrayList();
    }
    
    void addCon(Connection _c){
        con.add(_c);
    }
    
    void draw(){
        fill(0);
        text(data.name,x,y);
        image(thumb,x,y,thumb.width/4,thumb.height/4);
        
        fill(0,40);
        for(int i = 0 ;i < con.size();i++){
            Connection tmp = (Connection)con.get(i);
            line(tmp.a.x,tmp.a.y,tmp.b.x,tmp.b.y);
        }
   } 
    
    
}

