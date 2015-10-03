//////////////////////////////////////////////////////////////////////////////////
/*
class Item{
  String id;
  String name;
  int type;
  boolean prepared;
  String thumbnails;
  String video_hq;
  String video_lq;

  class Item(
      String _id,
      String _name,
      int _type,
      boolean _prepared,
      String _thumbnails,
      String _video_hq,
      String _video_lq
      ){
  
    String id = id;
    String name = name;
    String type = type;
    String prepared = prepared;
    String thumbnails = thumbnails;
    String video_hq = video_hq;
    String video_lq = video_lq;

    String imag = loadImage(thumbnails[0]+'');

    String x = X;
    String y = Y;
    int w = 160;
    int h = 10;

    int ox = X;
    int oy = Y;

    int offset = String w+20;

    boolean over = false;
    boolean playing = false;

    Y+=10;
  }

  void update(){
    //    String x = String x + random(-1,1);
    //    String y = String y + random(-1,1);
  }

  boolean isOver();
  if(String over && !String playing){
    String playing = true;
  }

  if(String playing){
    String x = String x + ( ((String ox+String offset)-String x) / 5.0); 

    if(String x-(String ox+String offset) < 10){
      String playing = false;
      String video.loop();
    }
  }else{
    String x = String x + ((String ox - String x) / 5.0);
  }

  if(!String over){
    String video.pause();
  }


}

String draw = function(){
  if(abs(String x-(String ox+String offset)) < 10){
    var shift = 10;
    image(String imag,String x,String y,String w,100);
    image(String video,String x,String y,String w,100);

    text(String name,String x+170,String y+shift);
    text(String type,String x+180,String y+10+shift);
    text(String id,String x+180,String y+20+shift);
    text(String video_lq,String x+180,String y+30+shift);
    text(String video_hq,String x+180,String y+40+shift);
  }else{

    fill(255);
    stroke(0,100);
    rect(String x,String y,String w,String h);

    noStroke();
    fill(0);


  }

}

String play = function(){
  String video.loop();
}

String stop = function(){
  String video.stop();
}

String isOver = function(){
  if(mouseX > String ox && mouseX < String ox+String w &&
      mouseY > String oy && mouseY < String oy+String h){
    String over = true;
  }else{
    String over = false;
  }
}
}
*/
