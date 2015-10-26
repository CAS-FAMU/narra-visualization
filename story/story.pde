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

ArrayList connections;

void setup() {
  size(canvasWidth, canvasHeight);
  
  imageMode(CENTER);
  textFont(createFont("Tahoma",9,false));
  
  connections = new ArrayList();
  
  for(int i = 0 ; i < junctions.length;i++){
        //println(junctions[i]);
        connections.add(new Connection(junctions[i],i));    
  }
}

void draw() {
    
  w = 0;
  h = 100;
  
  background(255);
  for(int i = 0 ; i< connections.size();i++){
    Item current = (Connection)connections.get(i);
    current.draw();
  }
  
}

class Connection{
    Object data;
    ArrayList items;
    float weight;
    int id;
    int W = 320;
    int H = 240;
    
    
    Connection(Object _data,int _id){
        data = _data;
        id = _id;
        // images = new ArrayList();
        println("got junction between "+data.items[0].id+" -> "+data.items[1].id);
        
        items = new ArrayList();
        items.add(new Item(data.items[0].id));
        items.add(new Item(data.items[1].id));
        
        // holders = new ImageHolder[data.thumbnails.length];
        
        }
    
    
    void draw(){
        // compute();
        for(int i = 0 ; i < items.size();i++){
            Item tmp = (Item)items.get(i);
            tmp.draw();
            // float dd = holders[i].distance;
            // image(img,holders[i].w+W/divider/2,holders[i].h+H/divider/2,W/divider+dd,H/divider+dd);
        }
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
    int x,y;
    
    
    Item(String _id){
        data = narra.getItem(_id);
        thumb = loadImage(data.thumbnails[0]);
        println("creating object "+data.name);
        x = random(canvasWidth);
        y = random(canvasHeight);
    }
    
    void draw(){
        fill(0);
        text(data.name,x,y);
        image(thumb,x,y,thumb.width/4,thumb.height/4);
    }
    
    
}

