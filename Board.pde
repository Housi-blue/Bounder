class Board{
float boardLeftX=random(0,80);
float boardLeftY=-3;
int[] boards=new int[0];

float boardSpeed=2;
float boardInterval=5000;
float lastAddTime=0;
float minGapWidth=200;
float maxGapWidth=300;
float boardHeight=30;
float boardColor=color(0,0,0);

  Board(){
    int randWidth = round(random(minGapWidth, maxGapWidth));
    int randX = round(random(0, width-randWidth));
    
    rectMode(CENTER);
    fill(boardColor);
    rect(randX/2, -boardHeight/2, randWidth, boardHeight, 0);
  }

void boardDrawer(){
  
  float gapBoardWidth=random(200,300);
  float gapBoardHeight=random(5,10);
  float boardLeftWidth=2*boardLeftX;
  float boardRightX = width-(width-(boardLeftWidth+gapBoardWidth))/2;
  float boardRightY=boardLeftY;
  float boardRightWidth =width-(boardLeftWidth+gapBoardWidth) ;
  
  rectMode(CENTER);
  fill(boardColor);
  rect(boardLeftX, boardLeftY, boardLeftWidth, boardHeight, 0, 15, 15, 0);
  rect(boardRightX, boardRightY,boardRightWidth, boardHeight, 15, 0, 0, 15);
}

void boardMover(){
  boardLeftY +=boardSpeed;
}


void watchBoardCollision(){
  
  float gapBoardWidth=random(200,300);
  float gapBoardHeight=random(5,10);
  float boardScored=10;
  float boardLeftWidth=2*boardLeftX;
  float boardRightX = width-(width-(boardLeftWidth+gapBoardWidth))/2;
  float boardRightY=boardLeftY;
  float boardRightWidth =width-(boardLeftWidth+gapBoardWidth) ;
  float gapBoardY=boardLeftY;
  float boardMoveDistance=boardSpeed;
  
  if(
  (ballY>boardLeftY)&&
  (ballX-(ballSize/2)<boardLeftX+boardLeftWidth/2)&&
  (ballX+(ballSize/2)>boardLeftX-boardLeftWidth/2)
  ){
    if(dist(ballX, ballY, ballX, boardRightY)<=(ballSize/2+boardMoveDistance+boardHeight/2)){ 
      makeBounceTop(boardRightY+boardHeight/2);
      ballY +=boardMoveDistance;
      velocity +=boardSpeed;
    }
  }
  
  if(
  (ballY>boardRightY)&&
  (ballX-(ballSize/2)<boardRightX+boardRightWidth/2)&&
  (ballX+(ballSize/2)>boardRightX-boardRightWidth/2)
  ){
    if(dist(ballX, ballY, ballX, boardRightY)<=(ballSize/2+boardMoveDistance+boardHeight/2)){ 
      makeBounceTop(boardRightY+boardHeight/2);
      ballY +=boardMoveDistance;
      velocity += boardSpeed;
    }
  }
  
  if(
  (ballY<boardLeftY)&&
  (ballX-(ballSize/2)<boardLeftX+boardLeftWidth/2)&&
  (ballX+(ballSize/2)>boardLeftX-boardLeftWidth/2)
  ){
    if(dist(ballX, ballY, ballX, boardLeftY)<=(ballSize/2-boardMoveDistance+boardHeight/2)){ 
      makeBounceBottom(boardRightY-boardHeight/2);
      ballY -=boardMoveDistance;
    }
  }
  
  if(
  (ballY<boardRightY)&&
  (ballX-(ballSize/2)<boardRightX+boardRightWidth/2)&&
  (ballX-(ballSize/2)>boardRightX-boardRightWidth/2)
  ){
    if(dist(ballX, ballY, ballX, boardRightY)<=(ballSize/2-boardMoveDistance+boardHeight/2)){ 
      makeBounceBottom(boardRightY-boardHeight/2);
      ballY -=boardMoveDistance;
    }
  }
  
  if(ballY<gapBoardY-(boardHeight/2)&&boardScored==0){
    boardScored=1;
    score +=10;
  }
 }
}
  
