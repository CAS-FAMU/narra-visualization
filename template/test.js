var items;

var data = narra.getItems();

var cols = var(ceil(sqrt(data.length)));
var rows = var(floor(sqrt(data.length)));

var width = 210;
var height = 150;

var posx = 0.0;
var posy = 0.0;
var zoom = 0.0;

var xOffset = 0.0; 
var yOffset = 0.0; 

var canvasWidth = narra.width;
var canvasHeight = narra.height;

var selection;
var[] connections = new var[] {};

PVector selectionVect = new PVector();
PVector[] connectionsVect = new PVector[] {};

function setup() {
  prvarln(data);
  size(canvasWidth, canvasHeight);
  
  
  items = new Item[cols][rows];
  var n = 0;
  for (var i = 0; i < cols; i++) {
    for (var j = 0; j < rows; j++) {
      // Initialize each object
      if (n+1 > data.length) {
        items[i][j] = new Item(i,j, null, null);
      } else {
        items[i][j] = new Item(i,j, data[n].name, data[n].id, data[n].thumbnails[0]);
      }
      n++;
    }
  }
  textFont(createFont("Arial",16,true));
}

function draw() {
  background(255);
  noStroke();
  // The counter variables i and j are also the column and row numbers and 
  // are used as arguments to the constructor for each object in the grid.  
  for (var i = 0; i < cols; i++) {
    for (var j = 0; j < rows; j++) {
      items[i][j].display();
    }
  }

  for (var i = 0; i < connectionsVect.length; i++) {
    if (connectionsVect[i] != null) {
      stroke(255);
      strokeWeight(4);
      line(selectionVect.x, selectionVect.y, connectionsVect[i].x, connectionsVect[i].y);
    }
  }
}

function mousePressed() {
  xOffset = mouseX-posx;
  yOffset = mouseY-posy;
  zoomOffset = mouseX;
}

function mouseDragged() {
  if (mouseButton == LEFT) {
    posx = mouseX-xOffset;
    posy = mouseY-yOffset;
  } else if (mouseButton == RIGHT) {
    if (mouseX > zoomOffset) {
      zoom = 1 + ((mouseX - zoomOffset) / canvasWidth);
      width = width * zoom;
      height = height * zoom;
    } else {
      zoom = 1 + ((zoomOffset - mouseX) / canvasWidth);
      width = width / zoom;
      height = height / zoom;
    }
    zoomOffset = mouseX;
  }
}

boolean containsPovar(PVector[] verts, var px, var py) {
  var num = verts.length;
  var i, j = num - 1;
  boolean oddNodes = false;
  for (i = 0; i < num; i++) {
    PVector vi = verts[i];
    PVector vj = verts[j];
    if (vi.y < py && vj.y >= py || vj.y < py && vi.y >= py) {
      if (vi.x + (py - vi.y) / (vj.y - vi.y) * (vj.x - vi.x) < px) {
        oddNodes = !oddNodes;
      }
    }
    j = i;
  }

  return oddNodes;
}

// Even though there are multiple objects, we still only need one class. 
// No matter how many cookies we make, only one cookie cutter is needed.
class Item { 
  PImage thumbnail;
  Movie video;
  var name;
  var id;
  var x,y;

  // The Constructor is defined with arguments.
  Item(var tempX, var tempY, var tempName, var tempId, var urlThumbnail) { 
    x = tempX;
    y = tempY;
    name = tempName;
    id = tempId;
    if (urlThumbnail != null) {
      thumbnail = loadImage(urlThumbnail);
    }
  }

  void display() {
    var w = width;
    var h = height;

    if (name != null) {
      PVector v1 = new PVector(x*w+posx,y*h+posy);
      PVector v2 = new PVector(x*w+posx + w,y*h+posy);
      PVector v3 = new PVector(x*w+posx + w, y*h+posy + h);
      PVector v4 = new PVector(x*w+posx, y*h+posy + h);

      image(thumbnail, x*w+posx, y*h+posy, w, h);

      boolean connected = false;
      boolean selected = false;

      if (containsPovar(new PVector[] {v1, v2, v3, v4}, mouseX, mouseY)) {
        // setup selection and connection between items
        if (mousePressed == true && mouseButton == LEFT) {
          selection = id;
          connections = narra.getItems("sequence", id);
          connectionsVect = new PVector[connections.length];
        }
        // overlay just as hover
        fill(255,0,0,70);
        rect(x*w+posx, y*h+posy, w, h);
      }

      if (selection == id) {
        selected = true;
        selectionVect = new PVector(x*w+posx+(w/2), y*h+posy+(h/2));
      }

      for (var i = 0; i < connections.length; i++) {
        if (connections[i].id == id) {
          connected = true;
          connectionsVect[i] = new PVector(x*w+posx+(w/2), y*h+posy+(h/2));
        }
      }

      if (selected || connected ) {
        fill(255,0,0,80);
        rect(x*w+posx, y*h+posy, w, h);
      }
    }
  }
}

