class Star {

  //variables 
  float x, y; 
  float rad; 
  float velX, velY; 

  //constructor function
  Star (float _x, float _y) {
    x = _x; 
    y = _y; 
    rad = random (4, 10); 
    velX = 0; 
    velY = random(3,4);
  }

  void displayStar() {
    pushStyle();
    pushMatrix(); 

    translate (x, y); 
    fill (214,219,255); 
    noStroke();
    ellipse(x, y, rad, rad);

    popMatrix(); 
    popStyle();
  }

  void move() {
    x += velX; 
    y += velY; 
  }

  void restart() {

    if (y > 600) 
      y = -400;
  }
}
