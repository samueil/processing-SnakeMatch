ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>(), xCut = new ArrayList<Integer>(), yCut = new ArrayList<Integer>();
ArrayList<Integer> xX = new ArrayList<Integer>(), yY = new ArrayList<Integer>(), xXCut = new ArrayList<Integer>(), yYCut = new ArrayList<Integer>();
int w = 30, h = 30, bs = 20, dir = 1, dirN = 1, applex = 12, appley = 10, waterX = 18, waterY = 18, index = 0;
int[] dx = {0,1,0,-1}, dy = {1, 0, -1, 0};
boolean pause =false;
boolean playing = false;
void setup() {
  size(600,600);
  x.add(5);
  y.add(5);
  xX.add(5);
  yY.add(20);
}
void draw() {
  background(36);
  for(int i = 0 ; i < w; i++) { //linien
    line(i*bs, 0, i*bs, height);
  }
  for(int i = 0 ; i < h; i++) {
    line(0, i*bs, width, i*bs);
  }
  if(!playing) {
fill(210);
    textSize(80);
    textAlign(CENTER);
    text("SnakeMatch", width/2, height/2-120);
    textSize(24);
        fill(201,158,96);
    text("Player 1 controls the red snake by cursor keys", width/2, height/2-60);
        fill(161,172,117);
        text("Player 2 controls the blue snake by keys W,A,S,D", width/2, height/2+40);
        fill(210);
    text("For pause push SPACE", width/2, height/2+120);
        text("Press N for New Game", width/2, height/2+180);
        welcomeAnimation();
    if(keyPressed&&key=='n'){
      playing = true;
    }
  }
    else{
  for(int i = 0 ; i < x.size(); i++) {
    fill(158,98,97);
    rect(x.get(i)*bs, y.get(i)*bs, bs, bs); //draw snake 1
  }
    for(int i = 0 ; i < xCut.size(); i++) {
    fill(201,158,96);
    rect(xCut.get(i)*bs, yCut.get(i)*bs, bs, bs); //draw dead parts of snake 1
  }
  for(int i = 0 ; i < xX.size(); i++) {
    fill(77,125,139);
    rect(xX.get(i)*bs, yY.get(i)*bs, bs, bs); //draw snake 2
  }
    for(int i = 0 ; i < xXCut.size(); i++) {
    fill(161,172,117);
    rect(xXCut.get(i)*bs, yYCut.get(i)*bs, bs, bs); //draw dead parts of snake 2
  }
  if(!pause) {
       fill(244,218,95);
       rect(applex*bs, appley*bs, bs, bs);  //draw apple
       fill(210);
    textSize(30);
    textAlign(RIGHT);
    text(x.size(), w*bs-bs, 2*bs);
    textSize(30);
    textAlign(LEFT);
    text(xX.size(), 2*bs, 2*bs);
  if (frameCount%5==0) {
    int xNext = x.get(0) + dx[dir];
    int yNext = y.get(0) + dy[dir];
    if (xNext < 0) xNext = w-1; //snake goes through wall
    if (xNext >= w) xNext = 0;
    if (yNext < 0) yNext = h-1;
    if (yNext >= h) yNext = 0; 
   if (x.size()>=2) {
          int xPrev = x.get(1);
          int yPrev = y.get(1);
          if ((xPrev == xNext) && (yPrev == yNext)) {
          x=reverseList(x);
          y=reverseList(y);
          xNext = x.get(0) + dx[dir];
          yNext = y.get(0) + dy[dir];
          xPrev = x.get(1);
          yPrev = y.get(1);
   if ((xPrev == xNext) && (yPrev == yNext)) {
     switch (dir)
     {
       case 0: dir=2;
       break;
       case 1: dir=3;
       break;
       case 2: dir=0;
       break;
       default: dir=1;
     }    
      xNext = x.get(0) + dx[dir];
    yNext = y.get(0) + dy[dir];      
    }
    }
   }
   if (!equalSnake(xNext,xX,yNext,yY) && !equalSnake(xNext,xCut,yNext,yCut)){
      x.add(0,xNext);
      y.add(0,yNext);
   }
    for(int i = 1; i < x.size(); i++) { //snake cuts itself
      if(x.get(0)==x.get(i) && y.get(0) == y.get(i)) {
      for (int k = x.size()-1; k > i; k--) {
        xCut.add(x.get(x.size()-1)); //cut peaces get transfered to dead part
        yCut.add(y.get(y.size()-1));
        x.remove(x.size()-1);
        y.remove(y.size()-1);
      }
      }
    }
    if(xNext==applex && yNext==appley) {
      setCoord();
    }else if(equalSnake(xNext,xXCut,yNext,yYCut)){
      xXCut.remove(index);
      yYCut.remove(index);
    }else if(x.size()>1){
    x.remove(x.size()-1);
    y.remove(y.size()-1);
    }
    int xXNext = xX.get(0) + dx[dirN];
    int yYNext = yY.get(0) + dy[dirN];
    if (xXNext < 0) xXNext = w-1; //snake goes through wall
    if (xXNext >= w) xXNext = 0;
    if (yYNext < 0) yYNext = h-1;
    if (yYNext >= h) yYNext = 0; 
   if (xX.size()>=2) {
          int xXPrev = xX.get(1);
          int yYPrev = yY.get(1);
          if ((xXPrev == xXNext) && (yYPrev == yYNext)) {
          xX=reverseList(xX);
          yY=reverseList(yY);
          xXNext = xX.get(0) + dx[dirN];
          yYNext = yY.get(0) + dy[dirN];
          xXPrev = xX.get(1);
          yYPrev = yY.get(1);
   if ((xXPrev == xXNext) && (yYPrev == yYNext)) {
     switch (dirN)
     {
       case 0: dirN=2;
       break;
       case 1: dirN=3;
       break;
       case 2: dirN=0;
       break;
       default: dirN=1;
     }     
      xXNext = xX.get(0) + dx[dirN];
    yYNext = yY.get(0) + dy[dirN];      
    }
    }
   }
   if (!equalSnake(xXNext,x,yYNext,y) && !equalSnake(xXNext,xXCut,yYNext,yYCut)){
      xX.add(0,xXNext);
      yY.add(0,yYNext);
   }
    for(int i = 1; i < xX.size(); i++) { //snake cuts itself
      if(xX.get(0)==xX.get(i) && yY.get(0) == yY.get(i)) {
      for (int k = xX.size()-1; k > i; k--) {
        xXCut.add(xX.get(xX.size()-1)); //cut peaces get transfered to dead part
        yYCut.add(yY.get(yY.size()-1));
        xX.remove(xX.size()-1);
        yY.remove(yY.size()-1);
      }
      }
    }
    if(xX.get(0)==applex && yY.get(0)==appley) {
      setCoord();
    }else if(equalSnake(xXNext,xCut,yYNext,yCut)){
      xCut.remove(index);
      yCut.remove(index);
    }else if(xX.size()>1){
    xX.remove(xX.size()-1);
    yY.remove(yY.size()-1);
  }
  }
  if(keyPressed&&key==' '){
      pause = true;
    }
  }else {
    fill(210);
    textSize(30);
    textAlign(CENTER);
    text("Pause", width/2, height/2-60);
    textSize(24);
    text("Press B to continue", width/2, height/2);
    text("Press N for New Game", width/2, height/2+60);
    if(keyPressed&&key=='b'){
      pause = false;
    }
    else if(keyPressed&&key=='n'){
      x.clear();
      y.clear();
      x.add(5);
      y.add(5);
      xX.clear();
      yY.clear();
      xX.add(5);
      yY.add(20);
      xCut.clear();
      yCut.clear();
      xXCut.clear();
      yYCut.clear();
      pause = false;
    }
  }
}
}
ArrayList<Integer> reverseList(ArrayList<Integer> old) {
  ArrayList<Integer> rev = new ArrayList<Integer>();
  for (int i = 1; i <= old.size(); i++) {
    rev.add(old.get(old.size()-i));
  }
  return rev;
}
void setCoord(){
  applex = (int)random(0,w);
  appley = (int)random(0,h);
  if (equalSnake(applex, x, appley, y) || equalSnake(applex, xX, appley, yY) || equalSnake(applex, xCut, appley, yCut) || equalSnake(applex, xXCut, appley, yYCut) || (waterX==applex && waterY==appley)){
      setCoord();
  }
}
boolean equalSnake(int xDot, ArrayList<Integer> xList, int yDot, ArrayList<Integer> yList){
  boolean contain =false;
  for (int i=0; i<xList.size(); i++) {
    if(xList.get(i)==xDot && yList.get(i)==yDot) {
      index=i;
      contain=true;
    }
  }
  return contain;
}
void keyPressed() {
  int newdir = keyCode==DOWN ? 0 : (keyCode==UP ? 2 : (keyCode==RIGHT ? 1 : (keyCode==LEFT ? 3 : - 1)));
  if(newdir != -1) dir = newdir;
  int newdirN = key=='s' ? 0 : (key=='w' ? 2 : (key=='d' ? 1 : (key=='a' ? 3 : - 1)));
  if(newdirN != -1) dirN = newdirN;
}
void welcomeAnimation() {
  ArrayList<Integer> xIntro = new ArrayList<Integer>(), yIntro = new ArrayList<Integer>(), xXIntro = new ArrayList<Integer>(), yYIntro = new ArrayList<Integer>();
  int dxDir=1, dyDir=0;
  for(int i=0; i<30; i++){
        xIntro.add(i);
  yIntro.add(13);
    xXIntro.add(i);
  yYIntro.add(18);
}
    for(int i = 0 ; i < xIntro.size(); i++) {
    fill(158,98,97);
    rect(xIntro.get(i)*bs, yIntro.get(i)*bs, bs, bs); //draw snake 1
  }
    for(int i = 0 ; i < xXIntro.size(); i++) {
    fill(77,125,139);
    rect(xXIntro.get(i)*bs, yYIntro.get(i)*bs, bs, bs); //draw snake 2
  }
}