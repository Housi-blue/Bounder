BoardSystem bs;

float gameScreen=0;
float ballSize=35;
float ballX;
float ballY;
float ballColor;

float gravity=0.4;
float velocity=0;
float airfriction=0.005;
float friction=0.001;
float surface;

float racketColor;
float boardColor;
float racketWidth;
float racketHeight;
float haddle;
float lastAddTime=0;

float ballSpeedHorizon=5;

int score=0;
int bestScore=0;

void setup(){
  bs=new BoardSystem();
  
  size(700,550);
  ballX=width/4;
  ballY=height/5;
  ballColor=color(0,0,250);
  racketColor =color(250, 0, 0);
  boardColor = color(23, 20, 11);
  smooth();                      
  racketWidth =200;              
  racketHeight=15;                 
  haddle=50;                       
  frameRate(60);
}

void draw(){
  
  if(gameScreen==0){
    initScreen();
  } else if(gameScreen==1){
    gameplayScreen();
  } else if(gameScreen==2){
    gameOverScreen();
  }
}

void initScreen(){
  background(36,250,241);
  textAlign(CENTER);
  fill(52,73,94);
  textSize(100);
  text("Bounder",width/2,height/2);
  
  fill(92,167,182);
  noStroke();
  rectMode(CENTER);
  rect(width/2,height-40,200,60,5);
  fill(236,240,241);
  textSize(30);
  text("start",width/2,height-30);
}

void gameplayScreen(){
  background(36,250,241);
  drawBall();
  applyGravity();
  keepInScreen();
  drawRacket();
  watchRacketBounce();
  applyHorizontalSpeed();
  printScore();
  
  bs.boardAdder();
  bs.boardHandler();
}

void gameOverScreen(){
  background(36,250,241);
  textAlign(CENTER);
  
  if(bestScore < score){
    bestScore=score;
  }
  fill(23,50,7);
  textSize(40);
  text("bestScore",width/2,height/14);
  textSize(40);
  text(bestScore,width/2,height/6);
  fill(217,116,43);
  textSize(40);
  text("Score",width/2,height/2-145);
  
  fill(230,180,80);
  textSize(150);
  text(score,width/2,height/2+50);
  
  fill(92,167,182);
  rectMode(CENTER);
  noStroke();
  rect(width/2,height-40,200,60,5);
  fill(236,240,241);
  textSize(30);
  text("restart",width/2,height-30);
}

void drawBall(){
  fill(random(0,255),random(0,255),random(0,255));
  ellipse(ballX,ballY,ballSize,ballSize);
}

void drawRacket(){
  fill(200,90,0);
  rectMode(CENTER);
  if(score>600){
    racketWidth=80;
  } else if(score>300){
    racketWidth=100;
  } else {
    racketWidth=racketWidth;
  }
  rect(mouseX,mouseY-haddle,racketWidth,racketHeight,5);
}

void applyGravity(){
  velocity +=gravity;
  ballY +=velocity;
  velocity -=(velocity*airfriction);
}

void makeBounceBottom(float surface){
  ballY=surface-(ballSize/2);
  velocity *=-1;
  velocity -=(velocity*friction);
}

void makeBounceTop(float surface){
  ballY=surface+(ballSize/2);
  velocity *=-1;
  velocity -=(velocity*friction);
}

void watchRacketBounce(){
  float overhead=mouseY-pmouseY;
  
  if((ballX+(ballSize/2)>mouseX-(racketWidth/2))&&(ballX-(ballSize/2)<mouseX+(racketWidth/2))){
    if (dist(ballX, ballY, ballX, mouseY-haddle)<=(ballSize/2)+abs(overhead)+(racketHeight/2)) {
      makeBounceBottom(mouseY-haddle-(racketHeight/2));
      ballSpeedHorizon = ballSpeedHorizon+(ballX - mouseX)/10;
      addScore();
      
      if(overhead<0){
        ballY +=overhead;
        velocity +=overhead/2;
      }
    }
  }
}

void applyHorizontalSpeed(){
  ballSpeedHorizon -=(ballSpeedHorizon*airfriction);
  ballX +=ballSpeedHorizon;
}

void makeBounceLeft(float surface){
  ballX=surface+(ballSize/2);
  ballSpeedHorizon *=-1;
  ballSpeedHorizon -=(ballSpeedHorizon*friction);
}

void makeBounceRight(float surface){
  ballX=surface-(ballSize/2);
  ballSpeedHorizon *=-1;
  ballSpeedHorizon -=(ballSpeedHorizon*friction);
}

void keepInScreen(){
  if(ballY+(ballSize/2)>height){
    gameOver();
  }
  
  if(ballY-(ballSize/2)<0){
    makeBounceTop(0);
  }
  
  if(ballX+(ballSize/2)>width){
    makeBounceRight(width);
  }
  
  if(ballX-(ballSize/2)<0){
    makeBounceLeft(0);
  }
}

void addScore(){
  score++;
}

void printScore(){
  textAlign(CENTER);
  fill(0);
  textSize(30);
  text(score,width/2,height/20);
}

void restart(){
  ballSpeedHorizon=10;
  velocity=0;
  score=0;
  ballX=width/4;
  ballY=height/5;
  racketWidth=200;
  gameScreen=1;
  
  lastAddTime=0;
}

void mousePressed(){
  if(gameScreen==0){
    startGame();
  }
  if(gameScreen==2){
    restart();
  }
}

void startGame(){
  gameScreen=1;
}

void gameOver(){
  gameScreen=2;
}
