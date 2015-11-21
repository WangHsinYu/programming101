final int GAME_START = 1;
final int GAME_RUN = 2;
final int HIT = 3;
final int GAME_LOSE = 4;

int gameState;
int bg1x, bg1y, bg2x, bg2y;
int fx, fy, dx;
int tx, ty;
int hpw;
int h = 0;
int n = 1;
int nf = 0;

float [] ex;
float [] ey;
float [] bx;
float [] by;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean []ed;

PImage start, pStart;
PImage bg1, bg2;
PImage hp; 
PImage fighter;
PImage treasure;
PImage [] enemy;
PImage end, pEnd;
PImage []flame;

void setup () {  
  size(640,480);
  
  bg1x = 0;
  bg1y = 0;
  bg2x = -width;
  bg2y = 0; 
  fx = width -50;
  fy = height/2;
  dx = 5;
  hpw = 40;
  tx = floor(random(40,width-40));
  ty = floor(random(40,height-40));
  
  ex = new float [18];
  ey = new float [18]; 
  bx = new float [18];
  by = new float [18];
  ed = new boolean [18];
  
  ex[0] = -width;
  ex[5] = 0;
  ex[10] = 0;
  ey[0] = random(60,(height-60));
  ey[5] = random(60,height-220);
  ey [10] = random(180,height-180);
  
  for(int i = 0; i<18;i++){    
    ed[i] = true;
    ex[i] = -width;
  }
  
  start = loadImage("img/start2.png");
  pStart = loadImage("img/start1.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  hp = loadImage("img/hp.png");
  fighter = loadImage("img/fighter.png");
  treasure = loadImage("img/treasure.png");
  enemy = new PImage [18];
  end =  loadImage("img/end2.png");
  pEnd =  loadImage("img/end1.png");
  
  for(int i = 0; i<18;i++){
    enemy[i] = loadImage("img/enemy.png");
  }
  
  flame = new PImage[5];
  for (int i=0; i<5; i++){
    flame[i] = loadImage("img/flame"+(i+1)+".png");   
  }
  
  gameState = GAME_START;
}

void draw(){
  switch(gameState){
    case GAME_START:
      if(mouseX>=205 && mouseX<= 460 && mouseY >=375 && mouseY <= 410 ){
        image(pStart, 0, 0);      
      }
      else{
        image(start, 0, 0);      
      }
    break;
    
    case GAME_RUN:;    
      //background
      image(bg1,bg1x,bg1y);
      image(bg2,bg2x,bg2y);
      bg1x = bg1x+1;
      bg2x = bg2x+1;
      if(bg1x > width ){
        bg1x = -bg1x;     
      }
     if(bg2x > width ){
        bg2x = -bg2x;     
      }
      
      //fighter
      image(fighter,fx,fy);
      if(upPressed){
        fy = fy-dx;
        if(fy<0){
          fy = 0;
        }
      }
      if(downPressed){
        fy = fy+dx;
        if(fy>(height-50)){
          fy = (height-50);
        }
      }
      if(leftPressed){
        fx = fx-dx;
        if(fx<0){
          fx = 0;
        }
      }
      if(rightPressed){
        fx = fx+dx;
        if(fx>(width-60)){
          fx = (width-50);
        }
      }
      
      //treasure
      image(treasure, tx,ty);
      if(fx>tx-20 && fx<tx+20 && fy>ty-20 && fy<ty+20){
        tx = floor(random(40,width-40));
        ty = floor(random(40,height-40));
        image(treasure, tx,ty);
        hpw = hpw +20;
        if(hpw > 200){
          hpw = 200;
        }
      }
      
      //enemy      
      for(h = 0; h<5; h++){              
          ex[h] = ex[0] - h*60;
          if( n==0){
            if(ey[0] == -60){          
              ey[h] = ey[1];
            }
            else{
              ey[h] = ey[0]; 
            }           
          }
          else{
            if(ey[0] != -60){
              ey[h] = ey[0];
            }
          }
          if(ed[h]){
            image(enemy[h], ex[h], ey[h]);     
          }
          else{
              ey[h] = - 60;
          }     
          ex[0] = ex[0] + 0.7;             
      }
          
      if(ex[4]>width){
        for(h =5; h<10; h++){
          ex[h] = ex[5] - 60*(h-5);          
          if( n==5 ){  
            if(ey[5] == - 60 ){
              ey[h] = ey[6] + 40 *(h-6); 
            }
            else{
              ey[h] = ey[5] + 40 *(h-5); 
            }
          }
          else{
            if( ey[5]!= -60){
              ey[h] = ey[5] + 40 *(h-5);
            }
          }
          if(ed[h]){
            image(enemy[h], ex[h], ey[h]);
          }
          else{
              ey[h] = - 60;
          }
          ex[5] = ex[5] + 1;
       
        }
      }
      if(ex[9]>width ){        
        for(h= 10;h<18;h++){
          ex[11] = ex[10] - 60;
          ex[12] = ex[10] - 60;
          ex[13] = ex[10] - 120;
          ex[14] = ex[10] - 120;
          ex[15] = ex[10] - 180;
          ex[16] = ex[10] - 180;
          ex[17] = ex[10] - 240;
          if(n==10){
            if(ey[10] == -60){
              ey[11] = ey[15] = ey[17] - 40;
              ey[12] = ey[16] = ey[17] + 40;
              ey[13] = ey[17] - 80;
              ey[14] = ey[17] + 80;
              ey[n] = -60;   
            }
            else{
              ey[11] = ey[15] = ey[10] - 40;
              ey[12] = ey[16] = ey[10] + 40;
              ey[13] = ey[10] - 80;
              ey[14] = ey[10] + 80;
              ey[17] = ey[10];
              ey[n] = -60; 
            }
          }
          else{
            if(ey[10] != -60){
              ey[11] = ey[15] = ey[10] - 40;
              ey[12] = ey[16] = ey[10] + 40;
              ey[13] = ey[10] - 80;
              ey[14] = ey[10] + 80;
              ey[17] = ey[10];
              ey[n] = -60; 
            }
          }
          if(ed[h]){
            image(enemy[h], ex[h], ey[h]);
          }
          else{
              ey[h] = - 60;
          }
          ex[10] = ex[10] + 0.5;                 
        }
      }
      if(ex[17] >width && ex[0] >width && ex[9] >width ){
        ex[0] = 0;
        ex[5] = -width; 
        ex[9] = -width; 
        ex[10] = -width;
        ey[0] = random(60,(height-60));
        ey[5] = random(60,height-220);
        ey[10] = random(180,height-180);
        for(int i = 0; i<18;i++){    
          ed[i] = true;
        }
      }
      if(ex[17] >width  ){
        for(h = 0; h<5; h++){ 
          ex[h] = ex[0] - h*60;
          if( n==0){
            if(ey[0] == -60){          
              ey[h] = ey[1];
            }
            else{
              ey[h] = ey[0]; 
            }           
          }
          else{
            if(ey[0] != -60){
              ey[h] = ey[0];
            }
          }
          if(ed[h]){
            image(enemy[h], ex[h], ey[h]);     
          }
          else{
              ey[h] = - 60;
          } 
          ex[0] = ex[0] + 0.1;  
        }
      }
      
     // hit
     for(h =0; h<18;h++){
       if(fx>ex[h] && fx<(ex[h]+60) && fy>ey[h] && fy<(ey[h]+60)){    
         n = h;
         for(nf = 0; nf<5;nf++){
           bx[nf] = ex[h];
           by[nf] = ey[h];
         }
         nf = nf%5;         
         hpw = hpw -20;
         gameState  = HIT;  
       }        
     }
     h = h%18;
      
      
      //hp
      noStroke();
      fill(225,0,0);
      rect(5,5,hpw,20);
      image(hp,0,0);
      
      break;
      
    case HIT:    
            
      ed[n] = false;
      if(hpw<=0){
        gameState = GAME_LOSE;
      }
      else{     
        if(frameCount%(60/10)==0){          
          image(flame[nf] ,bx[nf],by[nf]);          
          nf = (nf+1)%5;
          if(nf ==4){
            gameState = GAME_RUN;
          }
          else{
            gameState = HIT;
          }
        }
      }  
      
      upPressed = false;
      downPressed = false;
      leftPressed = false;
      rightPressed = false;
      
      break;
      
    
      
    case GAME_LOSE:   
    
    if(mouseX>=205 && mouseX<= 430 && mouseY >=305 && mouseY <= 380 ){
       image(pEnd, 0, 0);      
     }
     else{
       image(end, 0, 0);
    
     }
    break;
     
  }
  
  
}

void mousePressed(){
  if(gameState == GAME_START){
     if(mouseX>=205 && mouseX<= 460 && mouseY >=375 && mouseY <= 410){
       gameState = gameState + 1;
     }
   }
   
   if(gameState == GAME_LOSE){
     if(mouseX>=205 && mouseX<= 430 && mouseY >=305 && mouseY <= 380){
       
       bg1x = 0;
       bg1y = 0;
       bg2x = -width;
       bg2y = 0; 
       fx = width -50;
       fy = height/2;
       dx = 5;
       hpw = 40;
       tx = floor(random(40,width-40));
       ty = floor(random(40,height-40));
        
       ey = new float [18]; 
       bx = new float [18];
       by = new float [18];
       ed = new boolean [18];
       
       ex[0] = -width;        
       ex[5] = 0;
       ex[10] = 0;
       ey[0] = random(60,(height-60));
       ey[5] = random(60,(height-220));
       ey[10] = random(180,(height-180));
       
       for(int i = 0; i<18;i++){    
          ed[i] = true;
        }
       
       upPressed = false;
       downPressed = false;
       leftPressed = false;
       rightPressed = false;
       
       gameState = GAME_START;
     }
   }
  
}

void keyPressed(){
  if (key == CODED && gameState == GAME_RUN) {
     switch(keyCode) {
     case UP:
       upPressed = true;
       break;
     case DOWN:
       downPressed = true;
       break;
     case LEFT:
       leftPressed = true;
       break;
     case RIGHT:
       rightPressed = true;
       break;  
     }
   }
}

void keyReleased(){
  if (key == CODED && gameState == GAME_RUN) {
     switch(keyCode) {
     case UP:
       upPressed = false;
       break;
     case DOWN:
       downPressed = false;
       break;
     case LEFT:
       leftPressed = false;
       break;
     case RIGHT:
       rightPressed = false;
       break;  
     }
   }
}
