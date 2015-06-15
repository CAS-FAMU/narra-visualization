ArrayList entries;

void setup() {
  size(320,320);
  entries = new ArrayList();
}

void draw() {
  background(255);
  for(int i = 0 ; i < entries.size() ; i++) {
    Entry e = (Entry) entries.get(i);
    e.draw(); 
  }
}

Entry addEntry(String _s) {
  Entry e = new Entry(_s);
  entries.add(e);
  return e;
}

class Entry {
  int x,y;

  String name,title,desc;
  boolean pub;
  ArrayList thumbs;
  ArrayList contributors;

  Entry(String _name){
    this.name=_name;
    this.x=20;
    this.y=20;
  }

  void draw() {
    fill(0);
    text(name,this.x,this.y);
  }
}

