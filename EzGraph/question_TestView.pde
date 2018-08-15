class question_TestView {
	float x,y,w,h,w2,x2,y2,h2,h3;
	color c_Fill=c8,c_Fill_o=c8,c_Fill2=c7,c_Fill2_o=c7_o,c_Fill3=c6;
	int number=0,rasp=-1,rc;
	String s,r1,r2,r3,r4;
	raspuns_TestView[] raspunsuri=new raspuns_TestView[3];
	buton_TestView b;
	drawing_TestView desen=null;

	question_TestView(float xx,float yy,float ww,float hh,float xx2,float yy2,float ww2,float hh2,float hh3,int nrr,
					String ss,String rr1,String rr2,String rr3,int rcc) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		x2=xx2;
		y2=yy2;
		w2=ww2;
		h2=hh2;
		h3=hh3;
		number=nrr;
		s=ss;
		r1=rr1;
		r2=rr2;
		r3=rr3;
		rc=rcc;
		raspunsuri[0]=new raspuns_TestView(x+R_TestView,y+R_TestView*4,width-R_TestView*2,R_TestView,r1,nrr,0);
		raspunsuri[1]=new raspuns_TestView(x+R_TestView,y+R_TestView*5+R_TestView/10,width-R_TestView*2,R_TestView,r2,nrr,1);
		raspunsuri[2]=new raspuns_TestView(x+R_TestView,y+R_TestView*6+R_TestView/10*2,width-R_TestView*2,R_TestView,r3,nrr,2);
		if (number==nQuestionsMax_TestView) {
			w2=width-R_TestView/10-questions_TestView[number-1].x2-questions_TestView[number-1].w2;
			b=new buton_TestView(x+R_TestView,y+R_TestView*4,R_TestView*2,R_TestView,"Verificare");
		}
	}

	void display() {
		int i;
		noStroke();
		if (number<nQuestionsMax_TestView) {
			if (questionActive_TestView==number) {
				fill(c_Fill2);
				if (questions_TestView[nQuestionsMax_TestView].b.ok)
					if (raspunsuri[rc].bif==0)
						fill(256,80,80);
					else fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				fill(-1);
				textSize(R_TestView/4);
				text(s,x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				textAlign(CENTER,CENTER);
				raspunsuri[0].display();
				raspunsuri[1].display();
				raspunsuri[2].display();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions_TestView[nQuestionsMax_TestView].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,80,80);
						else fill(80,256,80);
					//if (mousePressed) questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions_TestView[nQuestionsMax_TestView].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,0,0);
						else fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R_TestView/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else {
			if (questionActive_TestView==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				fill(-1);
				textSize(R_TestView/4);
				//desen=new drawing(w/2,h/4*3,R*3,10);
				//desen.display();
				if (questions_TestView[nQuestionsMax_TestView].b.ok) {
					text("Nota finala: "+ str(verif_rasp_rez_TestView()),x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
					desen=new drawing_TestView(w/2,h/4*3,R_TestView*3,verif_rasp_rez_TestView());
					desen.display();
					if(!sentData){
						if(db.connect()){
							db.execute("INSERT INTO testscores VALUES("+idTEST+", "+IDUSER+", "+verif_rasp_rez_TestView()+", NOW())");
							sentData = true;
						}
						else sentData = true;
					}
				}
				else if (verif_rasp_TestView()<=nQuestionsMax_TestView)
					text("Raspunde la toate intrebarile!",x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				else {
					text("Test terminat. Poti trimite testul pentru verificare.",x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
					b.display();
				}
				
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					//if (mousePressed) questionActive=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R_TestView/3);
			text("Submit",x2,y2,w2,h2);
		}
	}

	void mousePress(){
		int i;
		noStroke();
		if (number<nQuestionsMax_TestView) {
			if (questionActive_TestView==number) {
				fill(c_Fill2);
				if (questions_TestView[nQuestionsMax_TestView].b.ok)
					if (raspunsuri[rc].bif==0)
						fill(256,80,80);
					else fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				fill(-1);
				textSize(R_TestView/4);
				text(s,x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				textAlign(CENTER,CENTER);
				raspunsuri[0].mousePress();
				raspunsuri[1].mousePress();
				raspunsuri[2].mousePress();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions_TestView[nQuestionsMax_TestView].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,80,80);
						else fill(80,256,80);
					questionActive_TestView=number;
				}
				else {
					fill(c_Fill3);
					if (questions_TestView[nQuestionsMax_TestView].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,0,0);
						else fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R_TestView/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else {
			if (questionActive_TestView==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				fill(-1);
				textSize(R_TestView/4);
				if (questions_TestView[nQuestionsMax_TestView].b.ok) {
					text("Nota finala: "+ str(verif_rasp_rez_TestView()),x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
					desen=new drawing_TestView(w/2,h/4*3,R_TestView*3,verif_rasp_rez_TestView());
					desen.display();
				}
				else if (verif_rasp_TestView()<=nQuestionsMax_TestView)
					text("Raspunde la toate intrebarile!",x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
				else {
					text("Test terminat. Poti trimite testul pentru verificare.",x+R_TestView,y+R_TestView,w-R_TestView*2,R_TestView*2);
					b.display();
				}
				
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					questionActive_TestView=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R_TestView/3);
			text("Submit",x2,y2,w2,h2);
		}
	}
}

void mousePress_all_questions_TestView(){
	int i;
	for(i=0;i<nQuestions_TestView;i++)
		questions_TestView[i].mousePress();
}

void display_all_questions_TestView() {
	int i;
	for(i=0;i<nQuestions_TestView;i++)
		questions_TestView[i].display();
}

void add_question_TestView(String s1,String s2,String s3,String s4,int rc) {
	if (nQuestions_TestView>=1)
		questions_TestView[nQuestions_TestView]=new question_TestView(0,R_TestView+R_TestView/10,width,height-R_TestView-R_TestView/10,questions_TestView[nQuestions_TestView-1].x2+R_TestView+R_TestView/10,
			0,R_TestView,R_TestView,R_TestView*2,nQuestions_TestView,s1,s2,s3,s4,rc);
	else {
		questions_TestView[nQuestions_TestView]=new question_TestView(0,R_TestView+R_TestView/10,width,height-R_TestView-R_TestView/10,0,0,R_TestView,R_TestView,R_TestView*2,0,s1,s2,s3,s4,rc);
		questionActive_TestView=0;
	}
	nQuestions_TestView++;
}

int verif_rasp_TestView() {
	int i,ok=1;
	for(i=0;i<nQuestions_TestView;i++)
		if (questions_TestView[i].rasp!=-1) ok++;
	return ok;
}

int verif_rasp_rez_TestView() {
	int i,ok=0;
	for(i=0;i<nQuestions_TestView;i++)
		if (questions_TestView[i].raspunsuri[questions_TestView[i].rc].bif==1) ok++;
	return ok;
}

int to_nr_TestView(String s) {
	int nr=0,i;
	for (i=0;i<s.length();i++)
		nr=nr*10+int(s.charAt(i))-'0';
	return nr;
}

String[] to_lines_TestView(String s) {
	String[] s2=new String[2000];
	int n=0,i;
	s2[0]="";
	for (i=0;i<s.length();i++)
		if (i+4<s.length() && s.charAt(i)=='+' && s.charAt(i+1)=='+' && s.charAt(i+2)=='+' && s.charAt(i+3)=='s' && s.charAt(i+4)=='f') {
			n++;
			i+=4;
			s2[n]="";
		}
		else
			s2[n]+=s.charAt(i);

	return s2;
}

void add_test_TestView(String s) {
	//modify content of data.txt according to the db
	String tstData = "";
	if(db.connect()){
		db.query("SELECT test, testID, classID, date FROM testdata WHERE (classID=-1 OR classID="+clsUsr+")");
		int i = 1;	//date=CAST(CURRENT_TIMESTAMP AS DATE) AND 
		while(db.next()){
			tstData = db.getString("test");
			idTEST = db.getInt("testID");
			if(i==lastTest){
				lastTest++;
				i++;
				break;
			}
			i++;
		}
		if(i==1) stopTEST = true;
		db.query("SELECT testID, userID FROM testscores WHERE testID="+idTEST+" AND userID="+IDUSER);
		if(db.next())
			stopTEST = true;
	}
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
}

String elimEndl(String s) {
	int i,n=0;
	String ss="";
	for (i=0;i<s.length();i++)
		if (s.charAt(i)!='\n')
			ss+=s.charAt(i);
	//println(ss);
	return ss;
}