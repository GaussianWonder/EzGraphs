void myClass(){
	membriiClasa.update();
	membriiClasa.display();
}

class ClassMembers{
	int profID, classID, userID;
	int scroolOffset = 0;
	boolean ERR = false;
	String classNM, profNM1, profNM2, usrNM;
	ArrayList<Member> members = new ArrayList<Member>();

	ClassMembers(int c, int u, int isProf, String n, String nn, String pn){
		classID = c;
		userID = u;
		classNM = n;
		usrNM = nn;

		if(isProf==1){
			profID = userID;
			profNM1 = usrNM;
			profNM2 = pn;
		}
		else getProf();

		if(profID==-1) ERR = true;
	}

	void display(){
		if(ERR){
			textAlign(CENTER);
			fill(255, 0, 0);
			text("CEVA NU E BINE", width/2, height/2);
			return;
		}

		fill(42);
		textSize(1.5 * R);

		for(Member m : members){
			m.display();
		}

		fill(255, 234, 69);
		rect(0, 2.5 * R, width, 2*R);
		fill(42);
		textAlign(CENTER);
		text("Profesor: " + profNM1 + " " + profNM2, width/2, 4 * R);
	}

	void update(){
		if(missingData())getData();
		if(scroolOffset < 0) scroolOffset=0;

		for(Member m : members){
			m.update();
		}
	}

	void getData(){
		members.clear();
		if(!db.connect())dbConnect();
		db.query("SELECT userID, name, surname, nickname, classID FROM users WHERE classID="+classID);
		int i = 0;
		while(db.next())
			members.add(new Member(++i, db.getInt("userID"), db.getString("name"), db.getString("surname"), db.getString("nickname")));
		
		for(Member m : members){
			int nrNote = 0, sumaNote = 0;

			db.query("SELECT userID, score FROM testscores WHERE userID="+m.userID);
			while(db.next()){
				nrNote++;
				sumaNote += db.getInt("score");
			}
			db.query("SELECT userID, score FROM temascores WHERE userID="+m.userID);
			while(db.next()){
				nrNote++;
				sumaNote += db.getInt("score");
			}

			if(nrNote!=0) m.medieNota = sumaNote / nrNote;
			else m.medieNota = -1;
		}
	}

	void getProf(){
		if(!db.connect())dbConnect();
		db.query("SELECT classID, profID FROM classes WHERE classID="+classID);
		if(db.next()){
			profID = db.getInt("profID");
			db.query("SELECT userID, name, surname FROM users WHERE userID="+profID);
			if(db.next()){
				profNM1 = db.getString("name");
				profNM2 = db.getString("surname");
			}
		}
	}

	boolean missingData(){
		return (members.isEmpty());
	}

	int membersOnScreen(){
		int nr = 0;
		for(Member m : members)
			if (m.seekPos.x==0)
				nr++;
		return nr;
	}
}

class Member extends Obj{
	int userID, index;
	String name, surname, nickname;
	float w = width, h = 2 * R,  sgn, medieNota;
	PVector initPos;

	Member(int i, int usr, String n, String s, String nn){
		super(new PVector(0, (i * 2.5 * R) + 3 * R), c6, 2 * R, 0.2);

		basePos.x = 0;
		basePos.y = height + 5 * R;

		index = i;
		userID = usr;

		name = n;
		surname = s;
		nickname = nn;

		initPos = new PVector(seekPos.x, seekPos.y);
	}

	void display(){
		if(basePos.y > 4 * R){
			fill(baseCol);
			rect(basePos.x, basePos.y, w, h);
			
			fill(42);
			textSize(20);
			textAlign(LEFT);
			text(name + " " + surname, basePos.x + R/2, basePos.y + h/2 + R/2);

			textAlign(CENTER);
			if(medieNota!=-1)text("Reusita: " + medieNota, basePos.x + width/2, basePos.y + h/2 + R/2);
			else text("N/A", basePos.x + width/2, basePos.y + h/2 + R/2);

			textAlign(RIGHT);
			text(nickname, basePos.x + width - R/2, basePos.y + h/2 + R/2);
		}
	}

	void update(){
		animate();

		if(basePos.y < 5 * R) {
			if(sgn == 0){
				sgn = random(0, 1);
				if(sgn < 0.5) sgn = -1;
				else sgn = 1; 
			}
			seekPosition(new PVector(sgn * width, initPos.y + membriiClasa.scroolOffset * -R));
		}
		else {
			sgn = 0;
			seekPosition(new PVector(0, initPos.y + membriiClasa.scroolOffset * -R));
		}

		if(isHovered(mouseX, mouseY) && mousePressed){
			if(!usrProf){
				pressedFromMyClass = false;
				return ;
			}
			currentModule = 22;
			getData22 = true;
			idNOTE3 = userID;
			pressedFromMyClass = true;

			float[] w=new float[30];
			String[][] s=new String[30][30];
			String[] el=new String[30];
			int[] nr=new int[30];
			int nrc=0,nrl=0, i;
			String[] lin=new String[30];
			getTestElev(userID);
			getTemaElev(userID);
			nrc=2;
			w[0]=(width-R*11-R*2)/2;
			w[1]=R*5;
			el[0]="Tema";
			el[1]="Nota";
			nr[0]=0;
			nr[1]=1;
			nrNoteTema = noteTema.length;
			nrNoteTest = noteTest.length;
			noteElevTemaa = new tabel(R*3/2-R/2,R*6,R*2,nrl,nrc,w,s,el,nr);
			for (i=0;i<nrNoteTema;i++) {
				lin=new String[30];
				lin[0]=teme[i];
				lin[1]=str(noteTema[i]);
				addElementInTable(lin,noteElevTemaa);
			}
			w=new float[30];
			s=new String[30][30];
			el=new String[30];
			nr=new int[30];
			nrc=0;nrl=0;
			lin=new String[30];
			nrc=2;
			w[0]=(width-R*11-R*2)/2;
			w[1]=R*5;
			el[0]="Test";
			el[1]="Nota";
			nr[0]=0;
			nr[1]=1;
			noteElevTestt = new tabel(noteElevTemaa.x+noteElevTemaa.sum(nrc)+R/2,R*6,R*2,nrl,nrc,w,s,el,nr);
			for (i=0;i<nrNoteTest;i++) {
				lin=new String[30];
			    lin[0]=teste[i];
			    lin[1]=str(noteTest[i]);
			    addElementInTable(lin,noteElevTestt);
			}

		}
	}

	boolean isHovered(int x, int y){
		return(x>=basePos.x && x<=basePos.x + w && y>=basePos.y && y<=basePos.y + h);
	}
}