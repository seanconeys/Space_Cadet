class Asteroid {

  //variables 
  float x, y; 
  float rad;  
  float velX, velY; 
  float npoints = random (10, 30);
  //float radius1 = 30;
  //float radius2 = 35;

  //constructor function
  Asteroid (float _x, float _y) {
    x = _x; 
    y = _y;  
    rad = 70; 
    velX = 0; 
    velY = random(5, 7);
  }

  void displayAsteroid() {
    pushStyle();
    pushMatrix(); 

    translate (x, y); 
    stroke(255);
    strokeWeight(3); 
    fill (178, 0, 0, 70); 
    //ellipse(x, y, rad, rad); 
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * random(30, 60);
      float sy = y + sin(a) * random(30, 60);
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * random(30, 60);
      sy = y + sin(a+halfAngle) * random(30, 60);
      vertex(sx, sy);
    }
    endShape(CLOSE);

    popMatrix(); 
    popStyle();
  }
  void move() {
    x += velX; 
    y += velY;
  }
  void restart() {

    if (y > height/2){
      y = -height/2;
      x = random (-width/2,width/2);
  }
  }
}
