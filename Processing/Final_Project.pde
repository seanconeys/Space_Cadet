import processing.video.*;
import processing.sound.*;
import processing.serial.*;
import java.lang.*;

String myString = null;
Serial myPort;
SoundFile life_lost;
SoundFile collect;
SoundFile soundtrack;
Capture cam;
int NUM_OF_VALUES = 2;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int[] sensorValues;      /** this array stores values from Arduino **/


ArrayList<Star> stars = new ArrayList<Star>(); 
ArrayList<Planet> planets = new ArrayList<Planet>(); 
ArrayList<Little> littles = new ArrayList<Little>(); 
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>(); 
ArrayList<PImage> lives_array = new ArrayList<PImage>(); 
PImage rocketImg; 
PImage rocketFireImg;
int powerup_spawn;
int movement;
int score =0;
int lives = 5;
float posY = 0;
boolean invulnerable = false;
int invulnerable_timer = 30;
boolean dif_stepped_up = false; 
void setup() {
  fullScreen();
  background (0);  
  life_lost = new SoundFile(this, "./data/life_lost.wav");
  collect = new SoundFile(this, "./data/collect.wav");
  soundtrack = new SoundFile(this, "./data/soundtrack.wav");
  soundtrack.amp(0.6);
  soundtrack.loop();
  //https://freesound.org/people/stumpbutt/sounds/381773/
  //https://creativecommons.org/licenses/by-nc/3.0/
  cam = new Capture(this, 320, 240);
  cam.start();

  setupSerial();

  rocketImg = loadImage("data/rocket_2.png");
  rocketFireImg = loadImage("data/fire.png");

  for (int i = 0; i<400; i++) {

    stars.add(new Star(random(-width/2, width/2), 
      random (-height/2, height/2)));
  }

  for (int i = 0; i<4; i++) {

    planets.add(new Planet(random(-width/2, width/2), random(-height/2, height/2)));
  }
  for (int i = 0; i<800; i++) {
    littles.add(new Little(random(-width/2, width/2), random(-height/2, height/2)));
  }
  for (int i = 0; i<5; i++) {
    asteroids.add(new Asteroid(random(-width/2, width/2), random(-height/2, height/2)));
  }
   for (int i = 0; i<lives; i++) {

    lives_array.add(loadImage("data/rocket.png"));
  }
  for (int i = 0; i<lives_array.size(); i++) {
    PImage p = lives_array.get(i);
    p.resize(0,40);}
}

void draw () {
  if(invulnerable == true){
    invulnerable_timer -= 1;}
   
  if(invulnerable_timer <= 0){
    invulnerable = false;
    invulnerable_timer = 30;}
    
  if((score != 0) && ((score%10)==0) && dif_stepped_up == false){
    for (int i = 0; i<5; i++) {
    asteroids.add(new Asteroid(random(-width/2, width/2), random(-height/2, height/2)));
    dif_stepped_up = true;
  }}else{
    if((score != 0) && ((score%10)!=0)){
    dif_stepped_up = false;}
  }
  powerup_spawn = int(random(0, 40));
  if (powerup_spawn == 20){
    
  }
  if(powerup_spawn == 21){
  }
  fill(0);
  rect(0, 0, width, height ); 

  //pushMatrix(); 
  translate (width/2, height/2); 

  for (int i = 0; i<stars.size(); i++) {
    Star s = stars.get(i);
    s.move(); 
    //stars[].display(); //for array--the total number of the elements is fixed
    s.restart(); 

    if ( i % 3 == 0 ) {
      s.displayStar();
    }
  }

  for (int i =0; i<planets.size(); i++) {
    Planet p = planets.get(i);
    p.move(); 
    //stars[].display(); //for array--the total number of the elements is fixed
    p.restart(); 
    p.display(); //for arraylist. Number of elements in an array list is not fixed.
  }
  for (int i = 0; i<littles.size(); i++) {
    Little l = littles.get(i);

    l.displayLittle(); //for arraylist. Number of elements in an array list is not fixed.
    l.move();
    l.restart();
  }
  for (int i = 0; i<asteroids.size(); i++) {
    Asteroid a = asteroids.get(i);

    a.displayAsteroid(); //for arraylist. Number of elements in an array list is not fixed.
    a.move();
    a.restart();
  }
 // popMatrix(); 
  fill(255); 
  //text(frameRate, 10, 20);

  updateSerial();
  printArray(sensorValues);
  
   if(sensorValues[1]==0){
    movement = 10;}
  else{
    movement = - 10;}
  
  float posX = map(sensorValues[0], 0, 1023, -width/2, width/2);
  if (posX < -width/2){
    posX=-width/2;}
  if(posX>width/2){
    posX=width/2;}
  posY = posY + movement;
  if (posY < -height/2){
    posY=-height/2;}
  if(posY>(height/2)-250){
    posY=(height/2)-250;}
  
 
 if (cam.available() == true) {
    cam.read();
  }
  PImage player = cam.get(70,70,200,200);
  //player.resize(20,20);

  if(invulnerable == false){
    if(sensorValues[1]==1){
      image (rocketFireImg, posX-20, posY+200);}
    image(player, posX+73,posY+103, 50, 50);
    image (rocketImg, posX, posY);
  }
  else{
    if((invulnerable_timer%2)==0){
      if(sensorValues[1]==1){
      image (rocketFireImg, posX-20, posY+200);}
      image(player, posX+73,posY+103, 50, 50);
      image (rocketImg, posX, posY);
   }
  }
  //ellipse(posX+100, posY+30, 30, 30);
  //ellipse(posX+60, posY+130, 30, 30);
  //ellipse(posX+140, posY+130, 30, 30);
  //ellipse(posX+30, posY+200, 30, 30);
  //ellipse(posX+170, posY+200, 30, 30);
  
  for (int i = 0; i<asteroids.size(); i++) {
    Asteroid a = asteroids.get(i);
     if((dist((posX+100), (posY+30), (2*a.x), (2*a.y)) < 60) && (invulnerable == false)){
    lives -= 1;
    invulnerable = true;
    life_lost.play();
  }
    else{
     if((dist((posX+60), (posY+130), (2*a.x), (2*a.y)) < 60) && (invulnerable == false)){
      lives -= 1;
      invulnerable = true;
    life_lost.play();}
      else{
        if((dist((posX+140), (posY+130), (2*a.x), (2*a.y)) < 60) && (invulnerable == false)){
          lives -= 1; 
          invulnerable = true;
          life_lost.play();
        }
        else{
           if((dist((posX+30), (posY+200), (2*a.x), (2*a.y)) < 60) && (invulnerable == false)){
            lives -= 1; 
            invulnerable = true;
            life_lost.play();
          }
          else{
             if((dist((posX+170), (posY+200), (2*a.x), (2*a.y)) < 60) && (invulnerable == false)){
              lives -= 1;
              invulnerable = true;
              life_lost.play();
            }
              }
        }}}}
  for (int i = 0; i<planets.size(); i++) {
    Planet p = planets.get(i);
    if(lives != 0){
     if(dist((posX+100), (posY+30), (p.x), (p.y)) < 60){
    score += 1;
    p.force_restart();
    collect.play();}
    else{
     if(dist((posX+60), (posY+130), (p.x), (p.y)) < 60){
      score += 1;
      p.force_restart();
      collect.play();}
      else{
        if(dist((posX+140), (posY+130), (p.x), (p.y)) < 60){
          score += 1;
          p.force_restart();
          collect.play();
        }
        else{
           if(dist((posX+30), (posY+200), (p.x), (p.y)) < 60){
            score += 1; 
            p.force_restart();
            collect.play();
          }
          else{
             if(dist((posX+170), (posY+200), (p.x), (p.y)) < 60){
              score += 1; 
              p.force_restart();
              collect.play();
            }
              }
        }}}}}

  textSize(32);
  text("SCORE:", -width/2+10, -height/2+30);
  text(score, -width/2+150, -height/2+30);
  for (int i = 0; i<lives; i++) {
    PImage p = lives_array.get(i);
    image(p,-width/2+30*i, -height/2+50);
}
  if(lives<=0){
  invulnerable = true;
  invulnerable_timer = 100;
  textSize(64);
  text("GAME OVER", -150, 0);
  text("FINAL SCORE:", -200, 100);
  text(score, 220, 100);
  }
  }
  
 






//void lives (float x, float y) {

//  popMatrix(); 
  
//  beginShape(); 
//  vertex(50, 15);
//  bezierVertex(50, -5, 75, 5, 50, 45);
//  vertex(50, 15);
//  bezierVertex(50, -5, 25, 5, 50, 45);
//  endShape();
  
//  pushMatrix();
  
//}
void setupSerial() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[ 0 ], 9600);

  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  myString = null;

  sensorValues = new int[2];
}

void updateSerial() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}
