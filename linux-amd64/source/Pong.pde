/*
Pong Game
By: Haniel mikhaiel

CONTROLS: 
- W/S or Up/Down for controling
- turbo with t
- autoplay with space bar

*/


import processing.sound.*;

SinOsc music = new SinOsc(this);;

int ballX = 400;
int ballY = 300;
int padlY = 225;
int padrY = 225;
int dX = 100;
int dY = 100;
int ballspeed = 5;
int padSpeed = 10;
int scoreL = 0;
int scoreR = 0;
int nextTextYA = 125;
int nextTextYB = 125;
int turboSpeed = 10;
String autoplayTrigger = "";
String turboTrigger = "";
boolean up = false;
boolean down = false;
boolean autoplay = false;
boolean turbo = false;
boolean directionX = true;
boolean directionY = true;

public void keyPressed(){
  if (padlY >= 0){
    if (keyCode == 87 || keyCode == UP) {
      up = true;
    }
  }
  if (padlY + 100 <= 600){
    if (keyCode == 83 || keyCode == DOWN) {
      down = true;
    }
  }
  
  if (keyCode == 32) {
    autoplay = !autoplay;
  }
  if (keyCode == 84) {
    turbo = !turbo;
  }
}

public void keyReleased(){
  if (keyCode == 87 || keyCode == UP) {
    up = false;
  }
  if (keyCode == 83 || keyCode == DOWN) {
    down = false;
  }
}

public void move(){
  if (padlY >= 0){
    if (up == true){
      padlY -= padSpeed;
    }
  }
  if (padlY + 150 <= 600){
     if (down == true){
      padlY += padSpeed;
    }
  }
}

public void update(){
  if (turbo){
    ballspeed = turboSpeed;
    padSpeed = turboSpeed;
    turboTrigger = "turbo: enabled";
  }
  else{
    ballspeed = 5;
    padSpeed = 5;
    turboTrigger = "";
  }
}

public void ai(){
  if (ballY >= 500){}
  else{
    padrY = ballY - 50;
  }
  
  if (autoplay){
    if (ballY >= 500){}
    else{
    padlY = ballY - 50; //autoplay
    }
    autoplayTrigger = "autoplay: enabled";
    }
  else{
    autoplayTrigger = "";
  }
}

public void score(){
  if ((ballX + 50) == 800){
    scoreL += 1;
    playNote(490, 257);
    playNote(0, 0);
    ballX = 400;
    ballY = 300;
    padlY = 225;
    padrY = 225;
    directionX = !directionX;
  }
  if ((ballX - 50) == 0){
    scoreR += 1;
    playNote(490, 257);
    playNote(0, 0);
    ballX = 400;
    ballY = 300;
    padlY = 225;
    padrY = 225;
    directionX = !directionX;
  }
}

public void bounce(){
  if (directionX){
    ballX += ballspeed;
  }
  else{
    ballX -= ballspeed;
  }
  
  if (directionY){
    ballY += ballspeed;
  }
  else{
    ballY -= ballspeed;
  }
  if ((ballY + 50) == 600){
    playNote(226, 16);
    playNote(0, 0);
    directionY = !directionY;
  }
  if ((ballY - 50) == 0){
    playNote(226, 16);
    playNote(0, 0);
    directionY = !directionY;
  }
}

public void padBounce(){
  if ((ballX - 50) == 675){
    if (padrY <= ballY && ballY <= (padrY + 150)){
      playNote(226, 16);
      playNote(0, 0);
      directionX = !directionX;
    }
  }
  if ((ballX - 50) == 35){
    if (padlY <= ballY && ballY <= (padlY + 150)){
      playNote(226, 16);
      playNote(0, 0);
      directionX = !directionX;
    }
  } 
}

public void draw(){
  bounce();
  padBounce();
  score();
  ai();
  update();
  move();
  background(0, 0, 0); //RGB
  
  fill(255, 255, 255); //RGB
  
  textSize(128);
  text(scoreL, 325, 100); 
  text(scoreR, 425, 100);
  
  textSize(25);
  text(autoplayTrigger, 320, 125);
  
  if (autoplayTrigger != ""){
    text(turboTrigger, 330, 145);
  }
  else{
    text(turboTrigger, 330, 125);
  }

  ellipse(ballX, ballY, dX, dY); //centerX, centerY, diameterX, diameterY
  rect(10, padlY, 25, 150); //topleftX, topleftY, widthX, heightY
  rect(765, padrY, 25, 150); //topleftX, topleftY, widthX, heightY
}

public void setup(){
  size(800, 600); //Width, Height
}

void playNote(int note, int duration){
   music.freq(note);
   music.play();
   delay(duration);
}
