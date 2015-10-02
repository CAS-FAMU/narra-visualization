/**
class Project(name,title,desc,author,synths,vis,pub,thumbnails,contrib,libs){
  String name = name;
  String title = title;
  String desc = desc;
  String desc = desc;
  String author = author;
  String synths = synths;
  String vis = vis;
  String pub = pub;
  String thumbnails = thumbnails;
  String contrib = contrib;
  String libs = libs;

  String images = [];

  for(var i = 0 ; i < String thumbnails.size;i++){
    String images[i] = loadImage(String thumbnails[i]);
  } 

  String draw = function(){
    background(255);
    fill(0);
    text(title,100,100);
    text(desc,100,120,400,400);
    image(images[0],10,10);

  }
}

*/
