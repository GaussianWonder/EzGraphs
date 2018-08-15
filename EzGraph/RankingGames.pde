class GameRanking{
	MultipleSelectionDropDown filter;
	Ranks rankScores;
	int scroolOffset = 0;

	GameRanking(PVector pos, color c, float sz, float anim){
		filter = new MultipleSelectionDropDown(new PVector(0, menu2.h+1/2*R), color(72, 83, 255), color(63, 70, 204), 40, margLeft/3, 50, 0.2);
		initDropDown(pos, c, sz, anim);

		rankScores = new Ranks(clsUsr, IDUSER, -1);
	}

	void display(){
		rankScores.display();
		filter.display();
	}

	void update(){
		if(scroolOffset < 0) scroolOffset = 0;
		filter.update();
		rankScores.update();
		checkFilterUpdate();
		
		boolean OK = false;
		for(MultipleSubTab tab : filter.mainTabs.get(0).subTabs){	//Game Filter
			if(tab.toggle == true){
				rankScores.gameID = tab.index;
				OK = true;
				break;
			}
		}
		if(!OK) rankScores.gameID = -1;
	}

	void initDropDown(PVector pos, color c, float sz, float anim){
		filter.addMainTab("Game", 1);	//dropdown main tabs
		filter.addMainTab("Class", 2);
		filter.addMainTab("Score", 3);

		filter.mainTabs.get(0).addSubTab("All", 7);		//games subtabs
		filter.mainTabs.get(0).addSubTab("Hamilton Path", 2);	
		filter.mainTabs.get(0).addSubTab("Eulerian Path", 1);
		filter.mainTabs.get(0).addSubTab("Gaseste Lanturi", 6);
		filter.mainTabs.get(0).addSubTab("Hex Sweeper", 3);
		filter.mainTabs.get(0).addSubTab("Fill The Land", 4);
		filter.mainTabs.get(0).addSubTab("Hex Collector", 5);
		filter.mainTabs.get(0).indexSelected = 7;
		filter.mainTabs.get(0).subTabs.get(0).toggle = true;

		filter.mainTabs.get(1).addSubTab("All", 1);		//group subtabs
		filter.mainTabs.get(1).addSubTab("My class", 2);
		filter.mainTabs.get(1).indexSelected = 1;
		filter.mainTabs.get(1).subTabs.get(0).toggle = true;

		filter.mainTabs.get(2).addSubTab("Ascending", 1);	//order subtabs
		filter.mainTabs.get(2).addSubTab("Descending", 2);
		filter.mainTabs.get(2).indexSelected = -1;
	}

	void checkFilterUpdate(){
		int tmpData = -1;
		for(MultipleMainTab mt : filter.mainTabs){
			mt.changed = false;	//old idea
			if(mt.indexSelected==-1)return;
			for(MultipleSubTab st : mt.subTabs) //extract selected subTab
				if(st.toggle)
					tmpData = st.index;
			if(tmpData==-1)return;

			switch (mt.index) { //ORDER Game > Class > Sort (irrelevant)
				case 1:{	//Game
					int i = 0;
					for(RankMember m : rankScores.members)
						if(tmpData==7 || tmpData==m.gameID) m.initPos = new PVector(0, ++i * 2.5 * R + 3 * R);
						else m.initPos = new PVector(-width, m.initPos.y);
					break;
				}
				case 2:{	//Class
					int i = 0;
					for(RankMember m : rankScores.members)
						if((tmpData==1 || m.classID==clsUsr) && m.initPos.x>=0) m.initPos = new PVector(0, ++i * 2.5 * R + 3 * R);
						else if(m.initPos.x>=0) m.initPos = new PVector(-width, m.initPos.y);
					break;
				}
				case 3:{	//Sort
					if(tmpData!=1 && tmpData!=2)return;
					for (int i = 0; i < rankScores.members.size(); i++){
						RankMember m1 = rankScores.members.get(i);
						for (int j = i + 1; j < rankScores.members.size(); j++){
							RankMember m2 = rankScores.members.get(j);
							if((m1.initPos.x>=0 && m2.initPos.x>=0) && ((tmpData==1 && m1.score > m2.score) || (tmpData==2 && m1.score < m2.score))){
								int scr = m1.score, ind = m1.index, usrID = m1.userID, gmID = m1.gameID, clsID = m1.classID;
								m1.score = m2.score;
								m2.score = scr;
								m1.index = m2.index;
								m2.index = ind;
								m1.userID = m2.userID;
								m2.userID = usrID;
								m1.gameID = m2.gameID;
								m2.gameID = gmID;
								m1.classID = m2.classID;
								m2.classID = clsID;

								String nm = m1.name, nknm = m1.nickname, srnm = m1.surname;
								m1.name = m2.name;
								m1.nickname = m2.nickname;
								m1.surname = m2.surname;
								m2.name = nm;
								m2.nickname = nknm;
								m2.surname = srnm;
							}
						}
					}
					break;
				}
			}

		}
	}
}

class Ranks{
	int classID, userID, gameID;
	String order;
	boolean ERR = false;
	ArrayList<RankMember> members;

	Ranks(int c, int u, int g){
		members = new ArrayList<RankMember>();

		classID = c;
		userID = u;
		gameID = g;
	}

	void display(){
		for(RankMember m : members){
			m.display();
		}
	}

	void update(){
		if(members.size()==0 && !ERR){
			getData();
		}
		for(RankMember m : members){
			m.update();
		}
	}

	void getData(){
		if(!db.connect())dbConnect();
		members.clear();
		db.query("SELECT * FROM gameScores");
		int i = 0;
		while(db.next()){
			int gmid = db.getInt("gameID");
			int usrid = db.getInt("userID");
			int scr = db.getInt("score");

			members.add(new RankMember(++i, usrid, scr, new PVector(0, i * 2.5 * R + 3*R), c6, 2*R, 0.2, gmid, -1));
		}
	}

	int membersOnScreen(){
		int nr = 0;
		for(RankMember m : members)
			if(m.initPos.x>=0)
				nr++;
		return nr;
	}

	int[] scores(){
		int[] vals = new int[3];
		return vals;
	}
}

class RankMember extends Obj{
	int index, score, userID, gameID, classID, idStolen;
	boolean missingData = true;
	float baseW = 10, baseH = 10, seekW, seekH, initW, initH;
	PVector initPos;
	String nickname, name, surname;

	RankMember(int i, int uid, int scr, PVector pos, color c, float sz, float anim, int gmID, int clsID){
		super(pos, c, sz, anim);
		seekW = width;
		seekH = sz;
		initW = seekW;
		initH = seekH;

		initPos = new PVector(pos.x, pos.y);

		index = i;
		userID = uid;
		score = scr;
		idStolen = index;
		gameID = gmID;
		classID = clsID;
	}

	void display(){
		fill(baseCol);
		rect(basePos.x, basePos.y, baseW, baseH);

		fill(42);
		textAlign(LEFT, CENTER);
		textSize(30);
		text(name + " " + surname, basePos.x + R/2, basePos.y, baseW, baseH);

		textAlign(CENTER, CENTER);
		text(gameName() + ": " + score, basePos.x, basePos.y, baseW, baseH);

		textAlign(RIGHT, CENTER);
		if(baseW>textWidth(nickname))
			text(nickname, basePos.x + baseW - R/2, basePos.y + baseH/2);
	}

	void update(){
		if(missingData)getName();

		animate();
		baseW = lerp(baseW, seekW, animSpd);
		baseH = lerp(baseH, seekH, animSpd);

		
		if(basePos.y < 5 * R) {
			seekW = 0;
			seekH = 0;
			seekPosition(new PVector(initPos.x + width/2, initPos.y + rankingScore.scroolOffset * -R));
		}
		else {
			seekW = initW;
			seekH = initH;
			seekPosition(new PVector(initPos.x, initPos.y + rankingScore.scroolOffset * -R));
		}
	}

	void getName(){
		missingData = false;
		if(!db.connect())dbConnect();
		db.query("SELECT name, surname, nickname, classID, userID FROM users WHERE userID="+userID);
		if(db.next()){
			name = db.getString("name");
			surname = db.getString("surname");
			nickname = db.getString("nickname");
			classID = db.getInt("classID");
		}
	}

	String gameName(){
		if(gameID == 1)return "Eulerian Path";
		if(gameID == 2)return "Hamiltonian Path";
		if(gameID == 3)return "Hexagon MineSweeper";
		if(gameID == 4)return "Fill The Land";
		if(gameID == 5)return "Hex Collector";
		if(gameID == 6)return "Gaseste Lanturi";
		return "";
	}

}

