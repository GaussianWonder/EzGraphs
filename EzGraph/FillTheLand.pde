void setupFillTheLand(){
	midW = width/2;
	midH = width/2;

	gameResetFTB();
}

void drawFillTheLand(){
	background(120, 120, 120);
	for(int i=0;i<LIN;i++){
		for(int j=0;j<COL;j++){
			if(map[i][j].visible){
				map[i][j].display();
				map[i][j].update();
			}
		}
	}

	if(mousePressed && mouseButton==CENTER) gameResetFTB();
	if(BLOCKS == MOVES + playerCount){
		stroke(3);
		strokeWeight(4);
		fill(10,6,124);
		textAlign(CENTER);
		textSize(100);
		text("YOU WON", width/2, height/2);
	}
	if(keyPressed && (key=='E' || key=='e')){
		hub.gameSelected=0;
	}
}

void gameResetFTB(){
	BLOCKS = 0; MOVES = 0;
	SCL = round(random(80, 120));
	LIN = round(height/SCL) - 1;
	COL = round(width/SCL) - 1;

	map = new Square[LIN][COL];
	playerCount = round(random(1, 4.3));
	players = new PVector[playerCount];
	initPlayers = new PVector[playerCount];

	for(int i=0;i<LIN;++i){
		for(int j=0;j<COL;++j){
			PVector pos = new PVector(j * SCL, i * SCL);
			map[i][j] = new Square(pos, inactiveCol, SCL, 0.2);
		}
	}

	for(int i=0;i<playerCount;++i){
		int x, y;

		do{
			x = round(random(0, LIN - 1));
			y = round(random(0, COL - 1));
		}while(map[x][y].viz);
		
		map[x][y].viz = true;
		map[x][y].active = true;
		map[x][y].seekColor(color(random(0, 255), random(0, 255), random(0, 255)));
		players[i] = new PVector(x, y);
		initPlayers[i] = new PVector(x, y);
	}

	int dir;
	do{
		dir = validPath();
		if(dir!=-1){
			for(int i=0;i<playerCount;++i){
				int x = int(players[i].x) + dirx[dir];
				int y = int(players[i].y) + diry[dir];

				if(okGridFTB(x, y) && !map[x][y].solid && !map[x][y].viz){
					map[x][y].seekColor(map[int(players[i].x)][int(players[i].y)].seekCol);

					map[x][y].viz = true;
					map[x][y].active = true;
					map[int(players[i].x)][int(players[i].y)].active = false;

					players[i].x = x;
					players[i].y = y;
				}
			}
			//30% chance to get the chance of placing an obstacle, 40% chance of actually placing an obstacle for each player
			if(random(0, 1)>=0.7) for(int i=0;i<playerCount;++i) if(random(0, 1)>=0.6)
				placeObstacle(int(players[i].x), int(players[i].y));
		}

	}while(dir!=-1);

	for(int i=0;i<LIN;++i){
		for(int j=0;j<COL;++j){
			if(map[i][j].viz && !map[i][j].solid)
				++BLOCKS;
			if(!map[i][j].solid){
				map[i][j].visible = map[i][j].viz;
				map[i][j].active = false;
				map[i][j].viz = false;
				map[i][j].seekColor(inactiveCol);
			}
		}
	}

	for(int i=0;i<playerCount;++i){
		int x = int(initPlayers[i].x);
		int y = int(initPlayers[i].y);

		players[i] = new PVector(x, y);

		map[x][y].active = true;
		map[x][y].viz = true;
		map[x][y].seekColor(color(random(0, 255), random(0, 255), random(0, 255)));
	}
}

boolean okGridFTB(int i, int j)
{
	return(i>=0 && i<LIN && j>=0 && j<COL);
}

int validPath(){
	if(playerStuck())return -1;

	boolean[] dirs = {true, true, true, true};
	int nr = 0, dir = -1, i;
	//Choose a common dir (if possible)
	if(random(0, 1)>=0.5){
		for(i=0;i<playerCount;++i){
			for(dir=0;dir<4;++dir){
				int x = int(players[i].x) + dirx[dir];
				int y = int(players[i].y) + diry[dir];

				if(!okGridFTB(x, y) || (okGridFTB(x, y) && (map[x][y].viz || map[x][y].solid)) ){
					if(dirs[dir]){
						++nr;
						dirs[dir] = false;
					}
				}
			}
		}

		if(nr!=4) do{
			dir = round(random(0, 3.5));
		}while(!dirs[dir]);
		if(nr!=4) return dir;
	}
	//Otherwise go crazy 
	return round(random(0, 3.5));
}

boolean playerStuck(){
	for(int i=0;i<playerCount;++i){
		for(int dir=0;dir<4;++dir){
			int x = int(players[i].x) + dirx[dir];
			int y = int(players[i].y) + diry[dir];

			if(okGridFTB(x, y) && !map[x][y].viz && !map[x][y].solid) return false;
		}
	}
	return true;
}

void placeObstacle(int i, int j)
{
	IntList dirs = new IntList();

	for(int dir=0;dir<4;++dir){
		int x = i + dirx[dir];
		int y = j + diry[dir];

		if(okGridFTB(x, y) && !map[x][y].viz && !map[x][y].solid) dirs.append(dir);
	}

	if(dirs.size()>0){
		int dir = dirs.get(round(random(0, dirs.size() - 0.5)));

		int x = i + dirx[dir];
		int y = j + diry[dir];

		if(okGridFTB(x, y) && !map[x][y].viz)
			map[x][y].solid = true;
	}
}

void gameRestartFTB(){
	MOVES = 0;
	UP_ARR = false;DOWN_ARR = false;LEFT_ARR = false;RIGHT_ARR = false;
	for(int i=0;i<LIN;++i){
		for(int j=0;j<COL;++j){
			if(map[i][j].viz){
				map[i][j].active = false;
				map[i][j].viz = false;
				map[i][j].seekColor(inactiveCol);
			}
		}
	}

	for(int i=0;i<playerCount;++i){
		int x = int(initPlayers[i].x);
		int y = int(initPlayers[i].y);

		players[i] = new PVector(x, y);

		map[x][y].active = true;
		map[x][y].viz = true;
		map[x][y].seekColor(color(random(0, 255), random(0, 255), random(0, 255)));
	}
}

void movePlayers(){
	int dir;

	if(UP_ARR)dir = 0;
	else if(DOWN_ARR)dir = 2;
	else if(LEFT_ARR)dir = 3;
	else dir = 1;

	for(int i=0;i<playerCount;++i){
		int x = int(players[i].x) + dirx[dir];
		int y = int(players[i].y) + diry[dir];

		if(okGridFTB(x, y) && !map[x][y].viz && !map[x][y].solid && map[x][y].visible){
			map[x][y].seekColor(map[int(players[i].x)][int(players[i].y)].seekCol);
			map[int(players[i].x)][int(players[i].y)].active = false;

			map[x][y].active = true;
			map[x][y].viz = true;

			players[i] = new PVector(x, y);

			++MOVES;
		}
	}
}