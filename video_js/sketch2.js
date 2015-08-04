var fingers;

function setup() {
  createCanvas(screen.width,screen.height);
  // specify multiple formats for different browsers
  fingers = createVideo(['https://narra.s3.amazonaws.com/narra-testing20150627-storage/items/558ecfe76536384a79000025/0007PC.mp4','assets/test.webm']);
  
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
