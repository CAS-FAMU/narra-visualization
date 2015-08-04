
/**
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

var url;
var data;
var font;

function setup() {
  createCanvas(800,600);
  url = 'http://api.narra.eu/v1/system/version';
  data = loadJSON(url);
  font = loadFont('assets/ProFontWindows.ttf');
  textFont(font,9,false);
}

function draw() {
  background(255);
  fill(0);
  text(data.status+"",100,100);
  text(data.version+"",100,120);

}

