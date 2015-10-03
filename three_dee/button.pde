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



class Button{

  String name;
  PVector pos;

  Button(String _name,int _x,int _y){
    name=  _name;
    pos = new PVector(_x,_y,0);
  }

  void draw(){
    pushMatrix();
    translate(pos.x,pos.y,0);
    fill( over() ? color(#ffcc00) : color(0) );
    text(name,0,0);
    popMatrix();
  }

  boolean over(){
    boolean answer = false;
    if(mouseX>pos.x&&mouseX<(pos.x+textWidth(name)) && mouseY < pos.y && mouseY > pos.y-12)
      answer = true;

    return answer;
  }

}
