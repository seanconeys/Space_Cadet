class Planet {
  
  //variables 
  float x, y; 
  float rad1, rad2, rad3; 
  float velX, velY; 
  
  //constructor function
  Planet (float _x, float _y) {
    x = _x; 
    y = _y;  
    rad1 = random (25*2, 35*2); 
    rad2 = random (50*2, 60*2); 
    rad3 = random (20*2, 25*2); 
    velX = 0; 
    velY = random(4,6);
    
  }
  
  void display() {
    pushStyle();
    pushMatrix(); 
    
    translate (x, y); 
    fill (255); 
    stroke(0);
    strokeWeight(5);
    fill(255);
    stroke(255); 
    strokeWeight(5); 
    ellipse(0, 0, rad1, rad1);
    noFill(); 
    ellipse(0, 0, rad2*0.8, rad3*0.8); 
  
    popMatrix(); 
    popStyle();   
  }
  
  void move() {
    x += velX; 
    y += velY;  
    
  }
  
  void fast() {
    x += velX * 10; 
    y += velY * 10; 
  }
  
  void restart() {
   
    if (y > height/2){
     y = -height/2; 
     x = random (-width/2,width/2);}
    }
    
    void force_restart() {
     y = -height/2;
     x = random (-width/2,width/2);
    }
    
}
