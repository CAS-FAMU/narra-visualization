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

var DEBUG = false;

var token;
$.get('token.txt', function(data) {
  token = data;
});

var query = "http://api.narra.eu/v1/projects?token="+token;

var json = $.getJSON(query, function(data) {
  
  var pjs = Processing.getInstanceById('narra');
  
  if(DEBUG)console.log(data);

  for(i = 0;i<data.projects.length;i++){
    if(DEBUG)console.log(data.projects[i].name);

    pjs.addProject(data.projects[i].name);
  }
});

