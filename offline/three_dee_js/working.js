// direct narra api is accessible through 'narra' object
//
// narra.width: window width
// narra.height: window height
//
// narra.getProject(): current project
// narra.getItems(): return all project's items
// narra.getItems(synthesizer, item): return project's items in concrete synthesizer scope
// narra.getItem(item): return concrete item
// narra.getJunctions(synthesizer): return junctions in scope of synthesizer
// narra.getJunctions(synthesizer, item): return junctions in scope of synthesizer for concrete item


var visualization = function( p ) {
 
  var items = narra.getItems();
  var test = [];
  
  p.setup = function() {
    p.createCanvas(p.windowWidth-5, p.windowHeight-5,'webgl');
    
    for(var i = 0;i<items.length;i++){
      test.push(new Test(items[i]));
      //test[i].testit();
    }
    
      
  };

  p.windowResized = function() {
    p.resizeCanvas(p.windowWidth-5, p.windowHeight-5);
  }

  p.draw = function() {
    p.background(255);
    
    //p.push();
    //p.translate(p.windowWidth/2.0,p.windowHeight/2.0);
    p.rotateX(p.frameCount/100.0);
    p.rotateY(p.frameCount/100.1);
    
    p.fill(255);
    p.stroke(0);
    p.line(0,0,0,0,0,1000);
    p.box(100);
    //p.pop();
    
    /*
    for(var i = 0;i<items.length;i++){
        test[i].draw();
    }
    */
    
  
  };
  
  function Test(_item){
      var item=_item;
      var x = p.random(0,200);
      var y = p.random(0,200);
      
      var img = p.loadImage(item.thumbnails[0]);
      
      this.draw = function(){
          p.image(this.img,this.x,this.y);
      };
      
  }
};
