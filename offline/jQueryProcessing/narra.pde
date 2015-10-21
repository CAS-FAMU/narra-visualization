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


////////////////////////////////////////////////
ArrayList projects;

void setup() {
  size(600,600);

  projects = new ArrayList();
}

void draw() {
  background(255);
  for(int i = 0 ; i < projects.size() ; i++) {
    Project tmp = (Project)projects.get(i);
    tmp.draw(); 
  }
}

////////////////////////////////////////////////
Project addProject(String _s) {
  Project tmp = new Project(_s);
  projects.add(tmp);
  return tmp;
}


////////////////////////////////////////////////

class Project{

  String name;

  ArrayList items;
  ArrayList sequences;

  Project(String _name){
    name = _name;
    items = new ArrayList();
    sequences = new ArrayList();
  }

  Item addItem(String _s) {
    Item tmp = new Item(_s);
    items.add(tmp);
    return e;
  }

  Sequence addSequence(String _s) {
    Sequence tmp = new Sequence(_s);
    sequences.add(tmp);
    return e;
  }


  void draw(){
    fill(0);
    text("project: "+name,20,20);


    for(int i = 0 ; i < items.size();i++){
      Item tmp = (Item)items.get(i);
      tmp.draw();
    }
    /*
       for(int i = 0 ; i < sequences.size();i++){
       Sequence tmp = (Sequence)sequences.get(i);
       tmp.draw();
       }
     */
  }

}

class Item{};
class Sequence{};
