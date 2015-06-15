/**
Narra.eu visualisation using ProcessingJs and jQuery
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

