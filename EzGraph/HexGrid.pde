class HexGrid{
  PVector basePos, seekPos;
  float widthHex, heightHex;
  float spdAnim, spdCol;
  color ON, OFF, HOVER, flagCol, bombCol;
  color baseCol, seekCol;
  boolean toggle, isBomb, active, flag, moved, special, bmbspl;
  int indexI, indexJ, bombs;
  
  HexGrid(int i, int j, color on, color off, float spd, float spdCl){
    widthHex = SCL * 2;
    heightHex = SQR3 / 2 * widthHex;
    
    indexI = i;  //just in case
    indexJ = j;
    
    seekPos = new PVector(j * widthHex * 3/4, i * heightHex);
    basePos = new PVector(width/2, height/2);
    
    if(j%2 == 0) seekPos.y += heightHex/2;
    this.toggle = false;
    
    ON = on;
    OFF = off;
    seekCol = OFF;
    baseCol = OFF;
    HOVER = color( (hue(ON) + hue(OFF))/2, 100, 100);
    
    spdCol = spdCl;
    spdAnim = spd;
    
    float chance = random(0, 1);
    if(chance < DIFFICULTY){
      isBomb = true;
      bombs = -1;
    }
    else{
      isBomb = false;
      bombs = 0;
    }
    bmbspl=false;
    active = true;
    flag = false;
    moved = false;
    special = false;
    flagCol = color(76,217,168);
    bombCol = color(217,55,74);
  }
  
  void update(){
    baseCol = lerpColor(baseCol, seekCol, spdCol);
    basePos.lerp(seekPos, spdAnim);
    
    if(toggle)seekCol = ON;
    else {
      seekCol = OFF;
      //flag = false;
    }
    if(flag==true) seekCol = flagCol;
    else if(toggle==true && isBomb==true && flag==false)seekCol = bombCol;
    if(bmbspl)seekCol = color(254,136,57);
  }
  
  void display(){
    stroke(darkGray);
    //noStroke();
    strokeWeight(2);      //4, 6, 8
    fill(baseCol);
    
    ArrayList <float[]> pts = new ArrayList <float[]> ();
    for(int i=0;i<6;++i)
      pts.add(hexCorner(basePos.x, basePos.y, i));
    pts.add(pts.get(0));
    
    beginShape();
    for(float[] pt : pts)
      vertex(pt[0], pt[1]);
    endShape();
    
    if(toggle == true && isBomb==false && flag==false && bombs!=0){
      textSize(SCL);
      textAlign(CENTER);
      fill(66,164,64);
      if(!special || bombs==1)text(bombs, basePos.x, basePos.y + heightHex/4);
      else text("[" + bombs + "]", basePos.x, basePos.y + heightHex/4);
    }
  }
  
  float[] hexCorner(float x, float y, int i){  //Can be improved!!
    float angleDeg = 60 * i, angleRad = PI / 180 * angleDeg;
    float[] pair = {x + SCL * cos(angleRad), y + SCL * sin(angleRad)};
    return pair;
  }
  
  boolean hoveredHex(float testX, float testY){
    float[] vertX, vertY;
    vertX = new float[7];
    vertY = new float[7];
    
    for(int i=0;i<6;++i){
      float[] pt = hexCorner(basePos.x, basePos.y, i);
      vertX[i] = pt[0] + SCL;
      vertY[i] = pt[1] + SCL;
    }
    vertX[6] = vertX[0];
    vertY[6] = vertY[0];
    
    boolean c = false;
    for(int i=0, j=6; i<7; j = i++)
      if ( ((vertY[i]>testY) != (vertY[j]>testY)) && (testX < (vertX[j]-vertX[i]) * (testY-vertY[i]) / (vertY[j]-vertY[i]) + vertX[i]) )
        c = !c;
        
    return c;
  }
  
  int checkNeighbors(){
    int num = 0;
    
    if(indexJ % 2 == 0)for(int dir=7;dir>=2;--dir){
        int x = indexI + dx[dir], y = indexJ + dy[dir];
        if(okGrid(x, y) && grid[x][y].isBomb)
          ++num;
      }
    else for(int dir=0;dir<=5;++dir){
      int x = indexI + dx[dir], y = indexJ + dy[dir];
      if(okGrid(x, y) && grid[x][y].isBomb)
        ++num;
    }
    
    return num;
  }
  
  void highlightNeighbors(float sz){
    if(moved==false){
      seekPos.y -= sz;
      moved = true;
      
      if(indexJ % 2 == 0)for(int dir=7;dir>=2;--dir){
          int x = indexI + dx[dir], y = indexJ + dy[dir];
          if(okGrid(x, y)){
            grid[x][y].seekPos.y -= sz;
          }
        }
      else for(int dir=0;dir<=5;++dir){
        int x = indexI + dx[dir], y = indexJ + dy[dir];
        if(okGrid(x, y)){
            grid[x][y].seekPos.y -= sz;
        }
      }
    }
  }
  
  void resetNeighbors(float sz){
    if(moved==true){
      seekPos.y -= sz;
      moved = false;
      
      if(indexJ % 2 == 0)for(int dir=7;dir>=2;--dir){
          int x = indexI + dx[dir], y = indexJ + dy[dir];
          if(okGrid(x, y)){
            grid[x][y].seekPos.y -= sz;
          }
        }
      else for(int dir=0;dir<=5;++dir){
        int x = indexI + dx[dir], y = indexJ + dy[dir];
        if(okGrid(x, y)){
            grid[x][y].seekPos.y -= sz;
        }
      }
    }
  }
  
}