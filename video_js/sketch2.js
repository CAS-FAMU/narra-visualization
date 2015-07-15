var fingers;

function setup() {
  createCanvas(screen.width,screen.height);
  // specify multiple formats for different browsers
  fingers = createVideo(['http://video.webmfiles.org/big-buck-bunny_trailer.webm','assets/test.webm']);
  
  fingers.loop();
  fingers.hide();
  noStroke();
  fill(0);
  background(255);
}

function draw() {
  
  image(fingers,frameCount/10.0,frameCount/10.0,fingers.width/4,fingers.height/4);
  /*
  fingers.loadPixels();
  var stepSize = round(constrain(mouseX / 8, 6, 32));
  for (var y=0; y<height; y+=stepSize) {
    for (var x=0; x<width; x+=stepSize) {
      var i = y * width + x;
      var darkness = (255 - fingers.pixels[i*4]) / 255;
      var radius = stepSize * darkness;
      ellipse(x, y, radius, radius);
    }
  }
  */
}
