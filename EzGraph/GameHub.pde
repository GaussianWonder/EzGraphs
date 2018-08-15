class gameHub{
	int gameSelected = 0;	//none
	gameTab[] games = new gameTab[6];

	gameHub(float x, float y, float w, float h){
		games[0] = new gameTab("Hamiltonian Path", 2, w/3 - 10, h/3 - 10, x, y);
		games[1] = new gameTab("Eulerian Path", 1, w/3 - 10, h/3 - 10, x + w/3, y);
		games[2] = new gameTab("Gaseste Lanturi", 6, w/3 - 10, h/3 - 10, x + 2*w/3, y);
		games[3] = new gameTab("Hexagon MineSweeper", 3, w/3 - 10, h/3 - 10, x , y + h/3);
		games[4] = new gameTab("Fill The Land", 4, w/3 - 10, h/3 - 10, x + w/3, y + h/3);
		games[5] = new gameTab("Hex Collector", 5, w/3 - 10, h/3 - 10, x + 2*w/3, y + h/3);
	}

	void display(){
		for(int i=0;i<6;i++)
			games[i].display();
		for(int i=0;i<6;i++)
			if(games[i].isHovered(mouseX, mouseY))
				showGameInfo(mouseX, mouseY, games[i].index);
	}

	void update(){	//UPDATE FIRST
		for(int i=0;i<6;i++)
			games[i].update();
	}

}

class gameTab{
	PVector basePos, seekPos;
	String name;
	int index;
	float w, h;

	gameTab(String n, int i, float ww, float hh, float x, float y){
		index = i;
		name = n;
		basePos = new PVector(width/2, height/2);
		seekPos = new PVector(x, y);
		w = ww;
		h = hh;
	}

	void update(){
		basePos.lerp(seekPos, 0.2);
	}

	void display(){
		fill(71, 182, 82);

		if(isHovered(mouseX, mouseY) && !menu2.mainTabHovered()){
			fill(45,182,114);
			rect(basePos.x, basePos.y, w, h);

			if(mousePressed && delay==0){
				hub.gameSelected = index;
				delay = DELAY;
			}
		}
		else rect(basePos.x, basePos.y, w, h);

    fill(-1);
		//fill(0, 255, 0);
		text(name, basePos.x + w/2, basePos.y + h/2);
	}

	boolean isHovered(float x, float y){
		return (x>=basePos.x && x<=basePos.x + w && y>=basePos.y && y<=basePos.y + h);
	}

}