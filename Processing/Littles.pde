class Little {

  //variables 
  float x, y; 
  float rad;  
  float velX, velY; 

  //constructor function
  Little (float _x, float _y) {
    x = _x; 
    y = _y;  
    rad = 4; 
    velX = 0; 
    velY = random(3,4);
  }

  void displayLittle() {
    pushStyle();
    pushMatrix(); 

    translate (x, y); 
    fill (255); 
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

    if (y > 800)
      y = -400;
  }
}
