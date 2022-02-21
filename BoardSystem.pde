class BoardSystem{
  ArrayList<Board> boards;
  
float boardInterval=5000;
float lastAddTime=0;
float minGapWidth=200;
float maxGapWidth=300;
float boardHeight=30; 
  
  BoardSystem(){
    boards=new ArrayList<Board>();
  }
  
  void boardAdder(){
  if(millis()-lastAddTime>boardInterval){
    
    boards.add(new Board());
    lastAddTime=millis();
    }
  }
  
  void boardRemover(){
  for(int i=boards.size()-1;i>height+15;i--){
    boards.remove(i);
  }
 }
 
 void boardHandler(){
  for(int i=0; i<boards.size(); i++){
    Board b=boards.get(i);
    b.boardMover();
    b.boardDrawer();
    b.watchBoardCollision();
    boardRemover();
   }
 }
}
