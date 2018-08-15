void setupHex(){
	//kirbyss = loadFont("KirbyNoKiraKizzu(BRK)-78.vlw");
	//textFont(kirbyss);
	ellipseMode(RADIUS);

	ERR = 1.1239;
	SCL = 50;
	SQR3 = sqrt(3);
	SQR2 = sqrt(2);
	
	//bgCol = color(178,178,178);
  //onCell = color(237,248,168);
  //offCell = color(229,229,229);
  bgCol = color(193, 255, 201);
	offCell = color(83, 28, 179);
	onCell = color(247, 197, 159);
	darkGray = color(41,41,41);
	
	cellSpdAnim = 0.149;
	cellSpdCol = 0.33;
	
	gameResetHex();
}

void drawHex(){
  translate(SCL * 3, SCL * 3);
  background(bgCol);
  
  for(int i=0;i<lin;++i){
    for(int j=0;j<col;++j){
      if(grid[i][j].active){
        //grid[i][j].toggle=true;
        grid[i][j].display();
        grid[i][j].update();
        
        if(grid[i][j].hoveredHex(mouseX - 2*SCL, mouseY - 2*SCL)){
          if(grid[i][j].moved==false)
            grid[i][j].highlightNeighbors(10);
          if(keyPressed){
            if(key=='h' || key=='H'){//hint
              if(grid[i][j].isBomb==true)explodeBomb(i, j);
              else grid[i][j].toggle=true;
            }
            if(key=='q' || key=='Q'){//quick reveal
              if(grid[i][j].toggle==true && grid[i][j].flag==false)toggleNeighbors(i, j);
            }
          }
        }
        else if(grid[i][j].moved==true)
            grid[i][j].resetNeighbors(-10);
      }
    }
  }
  
  if(keyPressed){
    if(key=='s' || key=='S'){
      SCORE = round(CORRECT*2 + FLAG*5 - HINT*7 - WRONG*10);                    //SCORE
      fill(offCell);
      rect(0 - 3*SCL, height/2 - 50 - 3*SCL, width, 175);
      fill(210, 210,210);
      textSize(42);
      text("YOUR SCORE : " + int(SCORE), width/2 - 3*SCL, height/2 - 3*SCL);
      text("MAX SCORE : " + MXSCR , width/2 - 3*SCL, height/2 + 50 - 3*SCL);
      float val = map(SCORE, MNSCR, MXSCR, 0.0, 100.0);
      text("Percentage : " + int(val) , width/2 - 3*SCL, height/2 + 100 - 3*SCL);   //SCORE
     }
    if(key=='E' || key=='e')
    	hub.gameSelected = 0;
  }
}

void mouseClickedHex(){
if(mouseButton==CENTER)gameResetHex();
  
  for(int i=0;i<lin;++i){
    for(int j=0;j<col;++j){
      
      if (grid[i][j].hoveredHex(mouseX - 2*SCL, mouseY - 2*SCL)){
        if(grid[i][j].isBomb==true && grid[i][j].toggle==true && grid[i][j].flag==false)return;
        
        if(mouseButton==LEFT){
          if(grid[i][j].toggle && grid[i][j].flag==false){
            grid[i][j].toggle = false;
            --CORRECT;
          }
          else if(grid[i][j].flag==false){
            if(grid[i][j].isBomb==true) ++WRONG;
            else ++CORRECT;
            grid[i][j].toggle = true;
            if(grid[i][j].bombs==0)remove0Actives(i, j, false);
          }
        }
        
        if(mouseButton == RIGHT){
          if(grid[i][j].flag==false){
            grid[i][j].flag=true;
            if(grid[i][j].isBomb) ++FLAG;
          }
          else {
            grid[i][j].flag=false;
            if(grid[i][j].isBomb) --FLAG;
          }
          
        }
        return;
      }
      
    }
  }
}

void gameResetHex(){
  CORRECT=0;
  WRONG=0;
  FLAG=0;
  HINT=0;
  TOTBOMBS=0;
  ACTIVES=0;
  DIFFICULTY = random(0.1, 0.3);
  SCL = round(random(30, 80));
  lin = (round(height / (SQR3/2 * (SCL * 2))) - 3);
  col = (round(width / (SCL * 2 * 3/4)) - 3);
  grid = new HexGrid[lin][col];
  
  for(int i=0;i<lin;++i)
    for(int j=0;j<col;++j)
      grid[i][j] = new HexGrid(i, j, onCell, offCell, cellSpdAnim, cellSpdCol);

  for(int i=0;i<lin;++i)
    for(int j=0;j<col;++j)
      if(!grid[i][j].isBomb)
        grid[i][j].bombs = grid[i][j].checkNeighbors();
        
  for(int i=0;i<lin;++i){
    if(grid[i][0].bombs==0 && grid[i][0].active==true)
      remove0Actives(i, 0, true);
    if(grid[i][col-1].bombs==0 && grid[i][col-1].active==true)
      remove0Actives(i, col-1, true);
  }
  for(int i=0;i<col;++i){
    if(grid[0][i].bombs==0 && grid[0][i].active==true)
      remove0Actives(0, i, true);
    if(grid[lin-1][i].bombs==0 && grid[lin-1][i].active==true)
      remove0Actives(lin-1, i, true);
  }
  
  for(int i=0;i<lin;++i)
    for(int j=0;j<col;++j){
      if(continuous(i, j))
        grid[i][j].special=true;
      if(grid[i][j].active==true && grid[i][j].toggle==false)
        ++ACTIVES;
      if(grid[i][j].isBomb==true)
        ++TOTBOMBS;
    }
    
  MXSCR = (ACTIVES-TOTBOMBS)*2 + (TOTBOMBS*5);
  MNSCR = (ACTIVES-TOTBOMBS)*2 - (TOTBOMBS*10);
}

void remove0Actives(int i, int j, boolean reset){
  if(okGrid(i, j)){
    if(grid[i][j].bombs==0){
      if(reset)grid[i][j].active = false;
      else grid[i][j].toggle=true;
    
      if(j % 2 == 0)for(int dir=7;dir>=2;--dir){
        if(reset && okGrid(i + dx[dir], j + dy[dir]) && grid[i + dx[dir]][j + dy[dir]].active==true)
          remove0Actives(i + dx[dir], j + dy[dir], reset);
        if(!reset && okGrid(i + dx[dir], j + dy[dir]) && grid[i + dx[dir]][j + dy[dir]].bombs==0 && grid[i + dx[dir]][j + dy[dir]].toggle==false)
          remove0Actives(i + dx[dir], j + dy[dir], reset);
      }
      else for(int dir=0;dir<=5;++dir){
        if(reset && okGrid(i + dx[dir], j + dy[dir]) && grid[i + dx[dir]][j + dy[dir]].active==true)
          remove0Actives(i + dx[dir], j + dy[dir], reset);
        if(!reset && okGrid(i + dx[dir], j + dy[dir]) && grid[i + dx[dir]][j + dy[dir]].bombs==0 && grid[i + dx[dir]][j + dy[dir]].toggle==false)
          remove0Actives(i + dx[dir], j + dy[dir], reset);
      }
    }
    else if(!grid[i][j].isBomb)grid[i][j].toggle=true;
 
  }
  
}

boolean okGrid(int x, int y){
  return(x>=0 && x<lin && y>=0 && y<col);
}

boolean continuous(int i, int j){
  int x, y;
  boolean ok = false, zero = false;
  
  if(j%2==0){
    x=i + dir0[0][0];
    y=j + dir0[0][1];
    if(okGrid(x, y) && okGrid(i + dir0[5][0], j + dir0[5][1]) && grid[x][y].isBomb==true && grid[x][y].isBomb==grid[i + dir0[5][0]][j + dir0[5][1]].isBomb){
      int st=0;
      x = i + dir0[st][0];
      y = j + dir0[st][1];
      while(okGrid(x, y) && grid[x][y].active==true && grid[x][y].isBomb==true && st<6){
        ++st;
        x = i + dir0[st][0];
        y = j + dir0[st][1];
      }
      
      int dr=5;
      x = i + dir0[dr][0];
      y = j + dir0[dr][1];
      while(okGrid(x, y) && grid[x][y].active==true && grid[x][y].isBomb==true && dr>1){
        --dr;
        x = i + dir0[dr][0];
        y = j + dir0[dr][1]; 
      }
      
      if(dr==st)return true;
      for(int dir=st;dir<=dr;++dir){
        x = i + dir0[dir][0];
        y = j + dir0[dir][1]; 
        if(okGrid(x, y) && grid[x][y].isBomb==true)return false;
      }
      return true;
    }
    
    for(int dir=0;dir<6;++dir){
      x = i + dir0[dir][0];
      y = j + dir0[dir][1];
      
      if(okGrid(x, y)){
        if(ok && zero && grid[x][y].isBomb==true)return false;
        if(ok && zero==false && (grid[x][y].isBomb == false || grid[x][y].active==false))zero = true;
        if(!ok && grid[x][y].isBomb==true)ok = true;
      }
    }

  }
  else{
    x=i + dir1[0][0];
    y=j + dir1[0][1];
    if(okGrid(x, y) && okGrid(i + dir1[5][0], j + dir1[5][1]) && grid[x][y].isBomb==true && grid[x][y].isBomb==grid[i + dir1[5][0]][j + dir1[5][1]].isBomb){
      int st=0;
      x = i + dir1[st][0];
      y = j + dir1[st][1];
      while(okGrid(x, y) && grid[x][y].active==true && grid[x][y].isBomb==true && st<6){
        ++st;
        x = i + dir1[st][0];
        y = j + dir1[st][1];
      }
      
      int dr=5;
      x = i + dir1[dr][0];
      y = j + dir1[dr][1];
      while(okGrid(x, y) && grid[x][y].active==true && grid[x][y].isBomb==true && dr>0){
        --dr;
        x = i + dir1[dr][0];
        y = j + dir1[dr][1]; 
      }
      
      if(dr==st)return true;
      for(int dir=st;dir<=dr;++dir){
        x = i + dir1[dir][0];
        y = j + dir1[dir][1]; 
        if(okGrid(x, y) && grid[x][y].isBomb==true)return false;
      }
      return true;
    }
    
    for(int dir=0;dir<6;++dir){
      x = i + dir1[dir][0];
      y = j + dir1[dir][1];
      
      if(okGrid(x, y)){
        if(ok && zero && grid[x][y].isBomb==true)return false;
        if(ok && zero==false && (grid[x][y].isBomb == false || grid[x][y].active==false))zero = true;
        if(!ok && grid[x][y].isBomb==true)ok = true;
      }
    }
    
  }
  
  return true;
}

void toggleNeighbors(int i, int j){
  if(j % 2 == 0)for(int dir=7;dir>=2;--dir){
     int x = i + dx[dir], y = j + dy[dir];
     if(okGrid(x, y) && grid[x][y].flag==false && grid[x][y].active==true && grid[x][y].toggle==false){
       grid[x][y].toggle=true;
       if(grid[x][y].isBomb)WRONG++;
       else CORRECT++;
     }
   }
  else for(int dir=0;dir<=5;++dir){
    int x = i + dx[dir], y = j + dy[dir];
    if(okGrid(x, y) && grid[x][y].flag==false && grid[x][y].active==true && grid[x][y].toggle==false){
      grid[x][y].toggle=true;
      if(grid[x][y].isBomb)WRONG++;
      else CORRECT++;
    }
  }
}

void explodeBomb(int i, int j){
  if(!(grid[i][j].isBomb==false && grid[i][j].flag==false && grid[i][j].bombs==0)){
    grid[i][j].isBomb=false;
    grid[i][j].flag=false;
    grid[i][j].bombs=0;
    grid[i][j].bmbspl=true;
    ++HINT;
  }
  
  if(j % 2 == 0)for(int dir=7;dir>=2;--dir){
     int x = i + dx[dir], y = j + dy[dir];
     if(okGrid(x, y) && grid[x][y].flag==false && grid[x][y].active==true && grid[x][y].toggle==false){
       grid[x][y].toggle=true;
       if(grid[x][y].isBomb){
         grid[x][y].flag=true;
         HINT++;
       }
     }
   }
  else for(int dir=0;dir<=5;++dir){
    int x = i + dx[dir], y = j + dy[dir];
    if(okGrid(x, y) && grid[x][y].flag==false && grid[x][y].active==true && grid[x][y].toggle==false){
       grid[x][y].toggle=true;
       if(grid[x][y].isBomb){
         grid[x][y].flag=true;
         HINT++;
       }
    }
  }
}