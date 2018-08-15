void setupGPath(){
	SCORE = 0;
	midW = width/2;
	midH = height/2;

	offGR = color(28, 255, 146);
	onGR = color(255, 170, 10);
	hoverGR = color(205, 255, 0);
	darkGR = color(42, 42, 42);

	ellipseMode(RADIUS);
	nodeNum = 0;
	gameResetGR();
}

void drawGPath(){
	if(nodeNum==0) gameResetGR();
	else if(nodes.size()==0) gameResetGR();
	else {
		background(120);

		for(Node n : nodes) n.displayLines();
		muchiiGr.display();

		for(Node n : nodes){
			n.display();
			n.update();
		}

		if(mousePressed){
			if(mouseButton==CENTER){
				nodeNum = 0;
				gameResetGR();
			}
		}

		endGameGR();
	}
}

void endGameGR(){
	if(tabSelected==2){		//Hamiltonian
		int nr = 0;
		for(Node n : nodes)
			if(n.toggle)
				nr++;

		if(nr==nodeNum || OKGAME==true){
			textSize(70);
			textAlign(CENTER);
			fill(10, 6, 124);

			text("YOU WON!", width/2, height/2);
			MAXSCOREGAINED+=nodeNum;
			SCORE += nodeNum * muchiiGr.st.size();
			
			if(OKGAME==false)timer=millis();
			
			OKGAME = true;
			if(OKGAME==true && millis() > timer + 1000){
				OKGAME=false;
				nodeNum = 0;
				gameResetGR();
			}
		}
	}
	else if(tabSelected==1){							//Eulerian
		if(muchiiGr.st.size()==nrMuchiiGR || OKGAME==true){
			textSize(70);
			textAlign(CENTER);
			//fill(onGR);
		    fill(10, 6, 124);
		    text("YOU WON!", width/2, height/2);
		    MAXSCOREGAINED+=2 * nodeNum;
		    SCORE += nodeNum * muchiiGr.st.size();

			if(OKGAME==false)timer=millis();

			OKGAME = true;
			if(OKGAME==true && millis() > timer + 1000){
				OKGAME=false;
				nodeNum = 0;
				gameResetGR();
			}
		}
	}else{	//lantui

		fill(120,120,120);
		rect(width - 140, 0, 140, 70);
		rect(0, 0, 180, 70);
		rect(0, height - 50, 105, 50);

		fill(220,220,220);
		textAlign(CENTER);
		textSize(70);
		text(REZ, width-70, 70);
		text((pGR+1) + " " + (qGR+1), 70, 70);
		textSize(20);
		text("SCORE: " + SCORE, 55, height - 25);



	}
}

void gameResetGR(){
	usee = new int[16];
	xx = new int[16];
	for(int i=0;i<16;++i){
		usee[i]=0;
		xx[i]=0;
	}
	OKGAME = false;
	nrLanturi = 0;
	nrMuchiiGR = 0;
	REZ=0;

	if(nodeNum==0){
		background(100);
		fill(10, 255, 50);
		textSize(50);

		text("ALEGE NUMARUL DE NODURI (5-9)", width/2, height/2);
		if(keyPressed && key>='5' && key<='9')nodeNum = int(key - '0');
		else if(keyPressed) background(255, 0, 0);
	}

	if(nodeNum==0)return;

	SCL = round(map(nodeNum, 5, 15, 80, 40));
	nodes = new ArrayList();
	muchiiGr = new MuchiiGR();
	muchiiGr2 = new MuchiiGR();

	for(int i=0;i<nodeNum;i++){
		PVector pos;

		do{
			pos = new PVector(random(SCL, width - SCL), random(SCL, height - SCL));
		}while(collidingNodesGR(pos));

		nodes.add(new Node(
			pos,
			color(offGR),
			SCL,
			0.15,
			i
			));
	}

	if(tabSelected==2){	//Hamiltonian
		int randEdges = round(random(2, nodeNum/2));
		for(int i=0;i<randEdges;++i){
			int nod, vec;

			do{
				nod = round(random(0, nodeNum - 0.5));
				vec = round(random(0, nodeNum - 0.5));
			}while(notChosenGR(nod, vec));

			nodes.get(nod).vec.append(vec);
			nodes.get(vec).vec.append(nod);
		}
	}
	else if(tabSelected==1){						//Eulerian
		int randEdges = round(random(2, nodeNum/2));
		randEdges -= randEdges % 2;
		int nod = nodeNum-1, vec = -1;

		for(int i=0;i<randEdges;++i){
			do{
				vec = round(random(0, nodeNum - 0.5));
			}while(notChosenGR(nod, vec));

			nodes.get(nod).vec.append(vec);
			nodes.get(vec).vec.append(nod);

			nod = vec;

			++nrMuchiiGR;
		}

		nod = 0;
	}
	else{
		int randEdges = round(random(3, nodeNum * (nodeNum-1)/2));
		if(nodeNum>6)randEdges/=2;
		for(int i=1;i<=randEdges;++i){
			int nod, vec;

			do{
				nod = round(random(0, nodeNum - 0.5));
				vec = round(random(0, nodeNum - 0.5));
			}while(notChosenGR(nod, vec));

			nodes.get(nod).vec.append(vec);
			nodes.get(vec).vec.append(nod);
			muchiiGr2.add(nod, vec);
		}

		do{
			pGR = round(random(0, nodeNum - 0.5));
			qGR = round(random(0, nodeNum - 0.5));
		}while(pGR==qGR);

		xx[0]=pGR;
		usee[pGR]=1;
		bkt(1);
	}

	nrMuchiiGR += nodeNum - 1;
}

boolean notChosenGR(int nod, int vec){
	return (nod==vec || nodes.get(nod).vec.hasValue(vec) && nodes.get(vec).vec.hasValue(nod));
}

boolean collidingNodesGR(PVector pos){
	for(Node n : nodes)
		if(dist(pos.x, pos.y, n.seekPos.x, n.seekPos.y) <= 3 * SCL)
			return true;
	return false;
}

boolean validMuchieGR(int st, int dr){
	for(Node n : nodes)
		for(int i : n.vec)
			if( (st==n.index && dr==i) || (st==i && dr==n.index) )
				return true;
	return false;
}

void bkt(int k){
	for(int i=0;i<nodeNum;++i){
		if(usee[i]!=1 && muchiiGr2.exists(i, xx[k-1])){
			usee[i]=1;
			xx[k]=i;

			if(xx[k]!=qGR)bkt(k+1);
			else ++nrLanturi;

			usee[i]=0;
		}
	}
}
