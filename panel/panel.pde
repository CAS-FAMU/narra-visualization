// direct narra api is accessible through 'narra' object
//
// narra.width: window width
// narra.height: window height
//
Object project [] = narra.getProject();// current project
Object items [] = narra.getItems(); //return all project's items
// narra.getItems(synthesizer, item): return project's items in concrete synthesizer scope
// narra.getItem(item): return concrete item
// narra.getJunctions(synthesizer): return junctions in scope of synthesizer
// narra.getJunctions(synthesizer, item): return junctions in scope of synthesizer for concrete item

int canvasWidth = narra.width;
int canvasHeight = narra.height;

int w,h;
int divider = 4;

ArrayList itms;

void setup() {
  size(canvasWidth, canvasHeight);


  
  imageMode(CENTER);
  
  itms = new ArrayList();
  for(int i = 0 ; i< items.length;i++){
      itms.add(new Item(items[i],i));
  }
}

void draw() {
    
  w = 0;
  h = 100;
  
  
  background(255);
  for(int i = 0 ; i< itms.size();i++){
    Item current = (Item)itms.get(i);
    current.draw();
  }
}

class Item{
    Object data;
    ArrayList images;
    ImageHolder holders[];
    int id;
    int W = 320;
    int H = 240;
    
    
    Item(Object _data,int _id){
        data = _data;
        id = _id;
        images = new ArrayList();
       // println("loading assets for "+data.name);
        
        holders = new ImageHolder[data.thumbnails.length];
        
        for(int i = 0 ; i < data.thumbnails.length;i++){
            PImage img = loadImage(data.thumbnails[i]);
            images.add(img);
            
            w += W/divider;
            if(w>canvasWidth){
                w=0;
                h+=H/divider;
            }
            
            holders[i] = new ImageHolder(i,w,h);
        }
    }
    
    void draw(){
        compute();
        for(int i = 0 ; i < images.size();i++){
            PImage img = (PImage)images.get(i);
            
            float dd = holders[i].distance;
            image(img,holders[i].w+W/divider/2,holders[i].h+H/divider/2,W/divider+dd,H/divider+dd);
        }
    }
    
    void compute(){
        for(int i = 0 ; i < images.size();i++){
      
         float dd = map(dist(mouseX,mouseY,holders[i].w,holders[i].h),0,dist(canvasWidth,canvasHeight,0,0),1,0);
         dd = pow(dd,20)*200;
         holders[i].distance = dd;
        }
    }
}

class ImageHolder{
    int id;
    float distace;
    int w,h;
    
    ImageHolder(int _id,int _w,int _h){
        id = _id;
        w = _w;
        h = _h;
        distance = 0.5;
    }
}
