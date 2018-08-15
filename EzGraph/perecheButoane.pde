class perecheButoane {
	float x,y,w,h,x2,y2;
	String s,s2;
	color c=c6,c_o=c8;
	int nr;
	int atribuire;

	perecheButoane(float xx,float yy,float xx2,float yy2,float ww,float hh,String ss,String ss2,int nrr) {
		x=xx;
		y=yy;
		x2=xx2;
		y2=yy2;
		w=ww;
		h=hh;
		s=ss;
		s2=ss2;
		nr=nrr;
	}

	void display() {
		if (atribuire==0) s="Anulare";
		else s="Atribuire";
		noStroke();
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			if (mousePressed && delay==0) {
				delay=DELAY;
				print(nr);
				if (atribuire==1) {
					atribuire=0;
					s="Anulare";
					if (alegeTemasauTest.selectat==0){
						//pui in db ca s a atribuit testul cu index nr
						int testID = getTestIdByName(teste[nr], IDUSER, clsUsr, false);
						db.query("SELECT * FROM testdata WHERE testID="+testID);
						if(db.next()){
							int classID = db.getInt("classID");
							String testData = db.getString("test");
							String testName = db.getString("testName");

							if(classID==0) db.execute("UPDATE testdata SET classID="+clsUsr+" WHERE testID="+testID);
							else if(classID!=-1){
								db.execute("INSERT INTO testdata VALUES(NULL, "+IDUSER+", "+clsUsr+", '"+testData+"', '"+testName+"', NOW())");
							}
						}
					}
					else{
						//pui in db ca s a atribuit tema cu index nr
						int temaID = getTemaIdByName(teme[nr], IDUSER, clsUsr, false);
						db.query("SELECT * FROM temadata WHERE temaID="+temaID);
						if(db.next()){
							int classID = db.getInt("classID");
							String temaData = db.getString("tema");
							String temaName = db.getString("temaName");

							if(classID==0) db.execute("UPDATE temadata SET classID="+clsUsr+" WHERE temaID="+temaID);
							else if(classID!=-1){
								db.execute("INSERT INTO temadata VALUES(NULL, "+IDUSER+", "+clsUsr+", '"+temaData+"', '"+temaName+"', NOW())");
							} 
						}
					}
				}
				else {
					atribuire=1;
					s="Atribuire";
					if (alegeTemasauTest.selectat==0){
						//pui in db ca s a anulat testul cu index nr
						int testID = getTestIdByName(teste[nr], IDUSER, clsUsr, true);
						db.execute("UPDATE testdata SET classID=0 WHERE testID="+testID);
					}
					else{
						//pui in db ca s a anulat tema cu index nr
						int temaID = getTemaIdByName(teme[nr], IDUSER, clsUsr, true);
						db.execute("UPDATE temadata SET classID=0 WHERE temaID="+temaID);
					}
				}
			}
			fill(c_o);
		}
		else fill(c);
		rect(x,y,w,h);
		textSize(R*2/3);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);

		noStroke();
		if (isBetween(x2,x2+w,mouseX) && isBetween(y2,y2+h,mouseY)) {
			if (mousePressed && delay==0) {
				delay=DELAY;
				
				if(alegeTemasauTest.selectat==0){	//test
					FORCEQUIT = false;
					R_TestView=width/20;
					STARTTEST_TestView = false;
			        testSetup = true;
			        questionActive_TestView=0;
					nQuestions_TestView=0;

					nQuestionsMax_TestView=10;

					
					String tstData = "";

					if(db.connect()){
						db.query("SELECT test, testName, profID FROM testdata WHERE testName='"+teste[nr]+"' AND profID="+IDUSER);
						if(db.next()) tstData = db.getString("test");
						else stopTEST = true;
					}
					//println(tstData);
					if(tstData.equals("") || stopTEST){
						currentModule = 4;
						FORCEQUIT = true;
						nume_test_TestView = "{eRRinDb}";
						return;
					}

					tstData=elimEndl(tstData);
					PrintWriter output;
					output = createWriter(s+".txt");
					output.print(tstData);
					output.flush();
					output.close();

					int i=0;
					String[] lines = loadStrings(s+".txt");
					String sss=lines[0];
					lines=to_lines_TestView(sss);
					nume_test_TestView=lines[0];
				    for (i=0;i<=9;i++)
				    	add_question_TestView(lines[i*6+1],lines[i*6+2],lines[i*6+3],lines[i*6+4],to_nr_TestView(lines[i*6+5]));
					start_TestView=new buton_TestView(width/2-R_TestView*2,height/2-R_TestView/2,R_TestView*4,R_TestView,"Incepe testul");
					STARTTEST_TestView=false;
				   	add_question_TestView("Submit","","","",0);
				   	currentModule = 13;
				}
				else{								//tema
					int j=0,rc=0,tip1,tip2,n1=0,n2=0,tb,nrrrr=0,or;					//REQUEST DATA FROM DB
					String tstData = "";
					STARTTEST_ViewTema = false;
					FORCEQUIT = false;
					temaSetup = true;
					graf_ViewTema[] g=null;
					edge_ViewTema[] e=null;

					if(db.connect()){
						db.query("SELECT tema, temaName, profID FROM temadata WHERE temaName='"+teme[nr]+"' AND profID="+IDUSER);
						if(db.next()) tstData = db.getString("tema");
						else stopTEMA = true;
					}
					if(tstData.equals("") || stopTEMA){
						currentModule = 4;
						FORCEQUIT = true;
						nume_test_ViewTema = "{eRRinDb}";
						return;
					}
					//===============>
					tstData=elimEndl(tstData);
					PrintWriter output;
					output = createWriter(s+".txt");
					output.print(tstData);
					output.flush();
					output.close();
					int i = 0;

					String[] lines = loadStrings(s+".txt");								//CITIRE DIN FISIER
					String sss=lines[0];
					lines=to_lines_ViewTema(sss);
					String a,b,c,d,f;
					a=b=c=d="";
					g=new graf_ViewTema[20];
					e=new edge_ViewTema[20];

					nume_test_ViewTema=lines[0];

				    for (i=2;nrrrr<5 && i+2<lines.length;i++) {
				    	nrrrr++;

				    	tip1=to_nr_ViewTema(lines[i]);
				    	tip2=to_nr_ViewTema(lines[i+2]);
				    	print(i," ",tip1," ",tip2,"\n");

				    	g=new graf_ViewTema[20];
						e=new edge_ViewTema[20];

				    	if (tip1==1) {
				    		or=to_nr_ViewTema(lines[i+3]);
				    		i++;
				    		if (tip2==1) {
				    			n1=to_nr_ViewTema(lines[i+3]);
				    			n2=to_nr_ViewTema(lines[i+4+n1]);
				    			add_question_ViewTema(lines[i],b,c,d,to_nr_ViewTema(lines[i+5+n1+n2]),tip1,tip2,g,e,0,0,1,or,lines[i+5+n1+n2]);
				    			createGraf_ViewTema(lines,i+3,nQuestions_ViewTema-1);
				    			i+=6+n1+n2;
				    		}
				    		else if (tip2==3) {
				    			n1=to_nr_ViewTema(lines[i+3]);
				    			n2=to_nr_ViewTema(lines[i+4+n1]);
				    			add_question_ViewTema(lines[i],lines[i+5+n1+n2],lines[i+6+n1+n2],lines[i+7+n1+n2],to_nr_ViewTema(lines[i+8+n1+n2]),tip1,tip2,g,e,0,0,0,or,
				    				lines[i+8+n1+n2]);
				    			createGraf_ViewTema(lines,i+3,nQuestions_ViewTema-1);
				    			i+=9+n1+n2;
				    		}
						}
						else if (tip1==2) {
							if (tip2==2) {
								a="";
								n1=n2=0;
				    			add_question_ViewTema(lines[i+1],a,a,a,0,tip1,tip2,g,e,n1,n2,0,0,"");
				    			i+=3;
							}
						}
						else if (tip1==3) {
				    		if (tip2==1) {
				    			g=null;
				    			e=null;
				    			n1=n2=0;
				    			add_question_ViewTema(lines[i+1],"","","",to_nr_ViewTema(lines[i+3]),tip1,tip2,g,e,n1,n2,0,0,lines[i+3]);
				    			i+=4;
				    		}
				    		else if (tip2==3) {
				    			g=null;
				    			e=null;
				    			n1=n2=0;
				    			add_question_ViewTema(lines[i+1],lines[i+3],lines[i+4],lines[i+5],to_nr_ViewTema(lines[i+6]),tip1,tip2,g,e,n1,n2,0,0,lines[i+6]);
				    			i+=7;
				    		}
							
						}
				    }

				    questionActive_ViewTema=0;
					nQuestions_ViewTema=0;
					nQuestionsMax_ViewTema=5;
					nnGrafs_ViewTema=5;

					start_ViewTema=new buton2_ViewTema(width/2-R_ViewTema*2,height/2-R_ViewTema/2,R_ViewTema*4,R_ViewTema,"Incepe tema");
					nQuestions_ViewTema=5;
					if(!stopTEMA)add_question_ViewTema("Submit","","","",0,0,0,g,e,0,0,0,0,"");
					
					isToMove_ViewTema=-1;

					currentModule = 14;
				}

			}
			fill(c_o);
		}
		else fill(c);
		rect(x2,y2,w,h);
		textSize(R*2/3);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s2,x2,y2,w,h);
		noStroke();
		if (isBetween(x2+w+1,x2+w*2+1,mouseX) && isBetween(y2,y2+h,mouseY)) {
			if (mousePressed && delay==0) {
				delay=DELAY;
				if (alegeTemasauTest.selectat==0){	//Test
					deleteTest(teste[nr], IDUSER);
				}
				else {								//Tema
					deleteTema(teme[nr], IDUSER);
				}
				float[] w=new float[30];
				String[][] s=new String[30][30];
				String[] el=new String[30];
				int[] nr=new int[30];
				int nrc=0,nrl=0;
				String[] lin=new String[30];
				lin=new String[30];				//TEME NAME
				w=new float[30];
				s=new String[30][30];
				el=new String[30];
				nr=new int[30];
				el[0]="Teme";
				w[0]=width/2;
				nr[0]=0;
				nrc=1;
				nrl=0;
				teme = getTemeCreatedByProfId(IDUSER);
				nTeme = teme.length;
				temeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
				for (int i=0;i<min(5,nTeme);i++) {
				    lin=new String[30];
				    lin[0]=teme[i];
				    addElementInTable(lin,temeT);
				}
				ssTemeT=new sagetiSchimb(R*6,temeT.y+temeT.h*7,R,temeT);

				lin=new String[30];
				w=new float[30];
				s=new String[30][30];
				el=new String[30];
				nr=new int[30];
				  /*for (i=0;i<nTeste;i++)
				    s[i][0]=teste[i];*/
				el[0]="Teste";
				w[0]=width/2;
				nr[0]=0;
				nrc=1;
				nrl=0;

				teste = getTestsCreatedByProfId(IDUSER);
				nTeste = teste.length;
				testeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
				for (int i=0;i<min(5,nTeste);i++) {
				    lin=new String[30];
				    lin[0]=teste[i];
				    addElementInTable(lin,testeT);
				}
				ssTesteT=new sagetiSchimb(R*6,testeT.y+testeT.h*7,R,testeT);

				atribsivizTeme=new perecheButoane[nTeme];
				atribsivizTeste=new perecheButoane[nTeste];

				updateAtribuireVizualizareByProfId(IDUSER, clsUsr);

				for (int i=0;i<nTeme;i++) {
				    atribsivizTeme[i]=new perecheButoane(temeT.x+temeT.sum(temeT.nrc)+R,temeT.y+temeT.h*(i%5+1)+i%5+1,
				                          temeT.x+temeT.sum(temeT.nrc)+R+R*5+1,temeT.y+temeT.h*(i%5+1)+i%5+1,R*5,R*2,"Atribuire","Vizualizare",i);
				    atribsivizTeme[i].atribuire=atribuireAnulareTeme[i];
				}
				for (int i=0;i<nTeste;i++) {
				    atribsivizTeste[i]=new perecheButoane(testeT.x+testeT.sum(testeT.nrc)+R,testeT.y+testeT.h*(i%5+1)+i%5+1,
				                           testeT.x+testeT.sum(testeT.nrc)+R+R*5+1,testeT.y+testeT.h*(i%5+1)+i%5+1,R*5,R*2,"Atribuire","Vizualizare",i);
				    atribsivizTeste[i].atribuire=atribuireAnulareTeste[i];
				}
			}
			fill(c_o);
		}
		else fill(c);
		rect(x2+w+1,y2,w,h);
		textSize(R*2/3);
		textAlign(CENTER,CENTER);
		fill(-1);
		text("Stergere",x2+w+1,y2,w,h);
	}
}
