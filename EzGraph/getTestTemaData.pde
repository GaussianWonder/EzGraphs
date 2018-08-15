int getTestIdByName(String testName, int profID, int classID, boolean ok){
	int id = -1;
	if(db.connect()){
		if(!ok) db.query("SELECT testID, testName, profID, classID FROM testdata WHERE testName='"+testName+"' AND profID="+profID);
		else db.query("SELECT testID, testName, profID, classID FROM testdata WHERE testName='"+testName+"' AND profID="+profID+" AND (classID="+classID+" OR classID=0)");

		if(db.next()) id = db.getInt("testID");
	}

	return id;
}

int getTemaIdByName(String temaName, int profID, int classID, boolean ok){
	int id = -1;
	if(db.connect()){
		if(!ok) db.query("SELECT temaID, temaName, profID FROM temadata WHERE temaName='"+temaName+"' AND profID="+profID);
		else db.query("SELECT temaID, temaName, profID FROM temadata WHERE temaName='"+temaName+"' AND profID="+profID+" AND (classID="+classID+" OR classID=0)");
		
		if(db.next()) id = db.getInt("temaID");
	}

	return id;
}

void getTestNotesDatesByUserId(int userID){
	IntList notes = new IntList();
	ArrayList<java.sql.Date> times = new ArrayList<java.sql.Date>();

	if(db.connect()){
		db.query("SELECT userID, score, date FROM testscores WHERE userID="+userID);
		int i = 0;
		while(db.next()){
			notes.append(db.getInt("score"));
			times.add(db.getDate("date"));
			i++;
		}
	}

	zile = new String[times.size()];
	for(int i=0;i<times.size();i++)
		zile[i] = times.get(i).toString();
	noteTest = notes.array();
}

void getTemaNotesDatesByUserId(int userID){
	IntList notes = new IntList();
	ArrayList<java.sql.Date> times = new ArrayList<java.sql.Date>();

	if(db.connect()){
		db.query("SELECT userID, score, date FROM temascores WHERE userID="+userID);
		int i = 0;
		while(db.next()){
			notes.append(db.getInt("score"));
			times.add(db.getDate("date"));
			i++;
		}
	}

	zile = new String[times.size()];
	for(int i=0;i<times.size();i++)
		zile[i] = times.get(i).toString();
	noteTema = notes.array();
}

void getTestElev(int userID){
	StringList testNames = new StringList();
	IntList note = new IntList();

	if(db.connect()){
		db.query("SELECT * FROM testdata, testscores WHERE testscores.userID="+userID+" AND testscores.testID = testdata.testID");
		while (db.next()) {
			testNames.append(db.getString("testdata.testName"));
			note.append(db.getInt("testscores.score"));
		}
	}

	teste = testNames.array();
	noteTest = note.array();
}

void getTemaElev(int userID){
	StringList temaNames = new StringList();
	IntList note = new IntList();

	if(db.connect()){
		db.query("SELECT * FROM temadata, temascores WHERE temascores.userID="+userID+" AND temascores.temaID = temadata.temaID");
		while (db.next()) {
			temaNames.append(db.getString("temadata.temaName"));
			note.append(db.getInt("temascores.score"));
		}
	}

	teme = temaNames.array();
	noteTema = note.array();
}

String[] getTestsCreatedByProfId(int profID){
	StringList teste = new StringList();

	if(db.connect()){
		db.query("SELECT profID, testName FROM testdata WHERE profID="+profID);
		while (db.next())
			teste.append(db.getString("testName"));
	}

	return teste.array();
}

String[] getTemeCreatedByProfId(int profID){
	StringList teme = new StringList();

	if(db.connect()){
		db.query("SELECT profID, temaName FROM temadata WHERE profID="+profID);
		while (db.next())
			teme.append(db.getString("temaName"));
	}

	return teme.array();
}

void updateEleviTest(int classID, int profID, String testName){	
	StringList numeEleviTest = new StringList();
	StringList noteTest = new StringList();

	if(db.connect()){
		db.query("SELECT * FROM users, testscores, testdata WHERE (users.classID="+classID+" AND users.userID!="+profID+") AND (testscores.userID = users.userID) AND testscores.testID=testdata.testID AND testdata.testName='"+testName+"'");
		while(db.next()){
			numeEleviTest.append(db.getString("users.name") + " " + db.getString("users.surname"));
			noteTest.append(db.getInt("testscores.score") + "");
		}
	}

	elevi = numeEleviTest.array();
	noteEleviTest = noteTest.array();
}

void updateEleviTema(int classID, int profID, String temaName){	
	StringList numeEleviTema = new StringList();
	StringList noteTema = new StringList();

	if(db.connect()){
		db.query("SELECT * FROM users, temascores, temadata WHERE (users.classID="+classID+" AND users.userID!="+profID+") AND (temascores.userID = users.userID) AND temascores.temaID=temadata.temaID AND temadata.temaName='"+temaName+"'");
		while(db.next()){
			numeEleviTema.append(db.getString("users.name") + " " + db.getString("users.surname"));
			noteTema.append(db.getInt("temascores.score") + "");
		}
	}

	elevi = numeEleviTema.array();
	noteEleviTema = noteTema.array();
}

void updateAtribuireVizualizareByProfId(int profID, int classID){
	StringList testNames = new StringList();
	StringList temaNames = new StringList();

	if(db.connect()){
		db.query("SELECT profID, testName, classID FROM testdata WHERE profID="+profID+" AND (classID=-1 OR classID="+classID+")");
		while(db.next()) testNames.append(db.getString("testName"));

		db.query("SELECT profID, temaName, classID FROM temadata WHERE profID="+profID+" AND (classID=-1 OR classID="+classID+")");
		while(db.next()) temaNames.append(db.getString("temaName"));
	}

	String[] temp = testNames.array();
	for(int i=0;i<teste.length;i++){
		if(nameExists(teste[i], temp)) atribuireAnulareTeste[i] = 0;
		else atribuireAnulareTeste[i] = 1;
	}
	temp = temaNames.array();
	for(int i=0;i<teme.length;i++){
		if(nameExists(teme[i], temp)) atribuireAnulareTeme[i] = 0;
		else atribuireAnulareTeme[i] = 1;
	}
}

boolean nameExists(String name, String[] array){
	for(int i=0;i<array.length;i++)
		if(array[i].equals(name))
			return true;
	return false;
}

void getCommData(){
	StringList commData = new StringList();
	StringList userName = new StringList();
	IntList commNota = new IntList();

	if(db.connect()){
		db.query("SELECT * FROM comentarii");
		while(db.next()){
			commData.append(db.getString("commData"));
			userName.append(db.getString("userName"));
			commNota.append(db.getInt("nota"));
		}
	}

	numeCom = userName.array();
	notaCom = commNota.array();
	com = commData.array();

	nComentarii = com.length;
	comentarii=new comentariu[nComentarii + 1];
	for (int i=0;i<nComentarii;i++)
		if (i==0) comentarii[i]=new comentariu(R*3,R*6,width-R*6,R*18,com[i], numeCom[i], notaCom[i]);
		else comentarii[i]=new comentariu(R*3,comentarii[i-1].y+comentarii[i-1].h+R*3,width-R*6,R*18,com[i],numeCom[i],notaCom[i]);
  scrollbarComentarii=new scrollbar2(width-R/2,R*2,R/2,height-R*2,int(lungimeCom()/4/R/3+1));
}

void submitCommData(String data, int nota){
	if(db.connect()){
		db.query("SELECT userID, commID FROM comentarii WHERE userID="+IDUSER);

		if(db.next()){
			int tmpID = db.getInt("commID");
			db.execute("UPDATE comentarii SET commData='"+data+"', nota="+nota+" WHERE commID="+tmpID);
		}
		else db.execute("INSERT INTO comentarii VALUES(NULL, "+IDUSER+", '"+nmUsr+"', '"+data+"', "+nota+")");
	}
}

void getLectii(){
	StringList lectieData = new StringList();
	StringList lectieName = new StringList();
	StringList profNM = new StringList();
	FloatList note = new FloatList();

	if(db.connect()){
		db.query("SELECT lectiedata.lectieData, lectiedata.lectieName, lectiedata.profID, lectiedata.scor, users.userID, users.name FROM lectiedata, users WHERE lectiedata.profID=users.userID");
		while(db.next()){
			lectieData.append(db.getString("lectiedata.lectieData"));
			lectieName.append(db.getString("lectiedata.lectieName"));
			profNM.append(db.getString("users.name"));
			note.append(db.getFloat("lectiedata.scor"));
		}
	}

	numeAutorLectii = profNM.array();
	numeLectii = lectieName.array();
	lectii = lectieData.array();
	noteLectiiVot = note.array();

	nLectii = lectii.length;
	lectiiProf=new lectieProf[nLectii + 1];
	for (int i=0;i<nLectii;i++)
	  if (i==0) lectiiProf[i]=new lectieProf(R*3,R*9,width-R*6,R*13,lectii[i],numeLectii[i],numeAutorLectii[i],noteLectiiVot[i],0);
	  else lectiiProf[i]=new lectieProf(R*3,lectiiProf[i-1].y+lectiiProf[i-1].h+R*3,width-R*6,R*13,lectii[i],numeLectii[i],numeAutorLectii[i],noteLectiiVot[i],0);
	scrollbarLectii=new scrollbar2(width-R/2,R*2,R/2,height-R*2,int(lungimeLectii()/4/R/3+1));
}

String getGraf(String lectieData, String lectieName){	
	if(db.connect()){
		db.query("SELECT lectieData, lectieGraf, lectieName FROM lectiedata WHERE lectieData='"+lectieData+"' AND lectieName='"+lectieName+"'");
		if(db.next()) return db.getString("lectieGraf");
	}
	return "INVALID";
}

void deleteTest(String testName, int profID){		//profID = IDUSER (e deja facut)
	if(db.connect()){
		int testID = -1;
		db.query("SELECT testID, profID, testName, classID FROM testdata WHERE testName='"+testName+"' AND profID="+profID+" AND classID="+clsUsr);
		if(db.next()) testID = db.getInt("testID");
		
		db.execute("DELETE FROM testdata WHERE testID="+testID);
		db.execute("DELETE FROM testscores WHERE testID="+testID);
	}
}

void deleteTema(String temaName, int profID){		//profID = IDUSER (e deja facut)
	if(db.connect()){
		int temaID = -1;
		db.query("SELECT temaID, profID, temaName, classID FROM temadata WHERE temaName='"+temaName+"' AND profID="+profID+" AND classID="+clsUsr);
		if(db.next()) temaID = db.getInt("temaID");
		
		db.execute("DELETE FROM temadata WHERE temaID="+temaID);
		db.execute("DELETE FROM temascores WHERE temaID="+temaID);
	}
}