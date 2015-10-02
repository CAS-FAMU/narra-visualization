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



class Connection{
  float weight;
  Entry a,b;
  PVector mid;

  Connection(Entry _a){
    a=_a;
    weight = random(0,100)/100.0;

    b = (Entry)entries.get((int)random(entries.size()));
    while(a==b){
      b = (Entry)entries.get((int)random(entries.size()));
    }
  }

  void update(){
    mid = new PVector(
        lerp(a.pos.x,b.pos.x,0.5),
        lerp(a.pos.y,b.pos.y,0.5),
        lerp(a.pos.z,b.pos.z,0.5)
        );

  }
}
