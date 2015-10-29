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

int canvasWidth = narra.width;
int canvasHeight = narra.height;

Object project;
Object junctions[],items[];

void setup() {
  size(canvasWidth, canvasHeight);
  
  textFont(createFont("Tahoma",9,false),9);
  
  project = narra.getProject();
  junctions = narra.getJunctions("sequence");
  items = narra.getItems();
  
}

void draw() {
  background(255);
  fill(0);
  for(int i = 0 ;i < items.length;i++){
      Object item = items[i];
      text(item.id+" "+item.name+" "+item.type+" "+item.url,10,10*i+100);
  }
  
  for(int i = 0 ;i < junctions.length;i++){
      Object junction = junctions[i];
      text(junction.items[0]+" --> "+junction.items[1],canvasWidth/2,10*i+300);
      
  }
}
