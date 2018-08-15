class question_ViewTema {
	float x,y,w,h,w2,x2,y2,h2,h3;
	color c_Fill=c8,c_Fill_o=c8,c_Fill2=c7,c_Fill2_o=c7_o,c_Fill3=c6;
	int number=0,rasp=-1,rc,tip1,tip2,nGrafs,nEdges,or;
	String s,r1,r2,r3,r4,rcc;
	raspuns_ViewTema[] raspunsuri=new raspuns_ViewTema[3];
	buton2_ViewTema b;
	int tb;
	drawing_ViewTema desen=null;
	graf_ViewTema[] g;
	edge_ViewTema[] e;
	textbox_ViewTema textb;

	question_ViewTema(float xx,float yy,float ww,float hh,float xx2,float yy2,float ww2,float hh2,float hh3,int nrr,
					String ss,String rr1,String rr2,String rr3,int rcc2,int tipp1,int tipp2,graf_ViewTema[] grafss,
					edge_ViewTema[] edgess,int nGrafss,int nEdgess,int tbb,int orr,String rccc) {
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
		rc=rcc2;
		tip1=tipp1;
		tip2=tipp2;
		g=grafss;
		e=edgess;
		nGrafs=nGrafss;
		nEdges=nEdgess;
		tb=tbb;
		or=orr;
		rcc=rccc;
		if (number==nQuestionsMax_ViewTema) {
			w2=width-R_ViewTema/10-questions_ViewTema[number-1].x2-questions_ViewTema[number-1].w2;
			b=new buton2_ViewTema(x+R_ViewTema,y+R_ViewTema*4,R_ViewTema*2,R_ViewTema,"Verificare");
		}
		if (tip2==1)
			if (tip1==3)
				textb=new textbox_ViewTema(x+R_ViewTema,y+R_ViewTema*4,width-R_ViewTema*2,R_ViewTema,R_ViewTema/4,1,0,number);
			else
				textb=new textbox_ViewTema(x+R_ViewTema,y+R_ViewTema*4,width/2-R_ViewTema,R_ViewTema,R_ViewTema/4,1,0,number);
		if (tip1!=3) {
			raspunsuri[0]=new raspuns_ViewTema(x+R_ViewTema,y+R_ViewTema*4,width/2-R_ViewTema,R_ViewTema,r1,nrr,0);
			raspunsuri[1]=new raspuns_ViewTema(x+R_ViewTema,y+R_ViewTema*5+R_ViewTema/10,width/2-R_ViewTema,R_ViewTema,r2,nrr,1);
			raspunsuri[2]=new raspuns_ViewTema(x+R_ViewTema,y+R_ViewTema*6+R_ViewTema/10*2,width/2-R_ViewTema,R_ViewTema,r3,nrr,2);
		}
		else {
			raspunsuri[0]=new raspuns_ViewTema(x+R_ViewTema,y+R_ViewTema*4,width-R_ViewTema*2,R_ViewTema,r1,nrr,0);
			raspunsuri[1]=new raspuns_ViewTema(x+R_ViewTema,y+R_ViewTema*5+R_ViewTema/10,width-R_ViewTema*2,R_ViewTema,r2,nrr,1);
			raspunsuri[2]=new raspuns_ViewTema(x+R_ViewTema,y+R_ViewTema*6+R_ViewTema/10*2,width-R_ViewTema*2,R_ViewTema,r3,nrr,2);
		}
	}

	void display() {
		int i;
		noStroke();
		if (number<nQuestionsMax_ViewTema) {
			if (questionActive_ViewTema==number) {
				fill(c_Fill2);
				if (questions_ViewTema[nQuestionsMax_ViewTema].b.ok)
					if (tip2==3 && raspunsuri[rc].bif==0 || tip2==1 && to_nr_ViewTema(textb.s)!=rc)
						fill(256,80,80);
					else fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				if (tip1!=3)
					rect(x+R_ViewTema,y+R_ViewTema,w/2-R_ViewTema,R_ViewTema*2);
				else 
					rect(x+R_ViewTema,y+R_ViewTema,w-R_ViewTema*2,R_ViewTema*2);
				fill(-1);
				textSize(R_ViewTema/4);
				if (tip1!=3)
					text(s,x+R_ViewTema,y+R_ViewTema,w/2-R_ViewTema,R_ViewTema*2);
				else
					text(s,x+R_ViewTema,y+R_ViewTema,w-R_ViewTema*2,R_ViewTema*2);
				textAlign(CENTER,CENTER);
				if (tip2==1) {
					textb.display();
				}
				else if (tip2==3) {
					raspunsuri[0].display();
					raspunsuri[1].display();
					raspunsuri[2].display();
				}
				if (tip1==1) {
					display_all_edges_ViewTema(number);
					display_all_grafs_ViewTema(number);
				}
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions_ViewTema[nQuestionsMax_ViewTema].b.ok)
						if (tip2==3 && raspunsuri[rc].bif==0 || tip2==1 && to_nr_ViewTema(textb.s)!=rc)
							fill(256,80,80);
						else fill(80,256,80);
					//if (mousePressed) questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions_ViewTema[nQuestionsMax_ViewTema].b.ok)
						if (tip2==3 && raspunsuri[rc].bif==0 || tip2==1 && to_nr_ViewTema(textb.s)!=rc)
							fill(256,0,0);
						else fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R_ViewTema/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else {
			if (questionActive_ViewTema==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R_ViewTema,y+R_ViewTema,w-R_ViewTema*2,R_ViewTema*2);
				fill(-1);
				textSize(R_ViewTema/4);
				if (questions_ViewTema[nQuestionsMax_ViewTema].b.ok) {
					text("Nota finala: "+ str(verif_rasp_rez_ViewTema()),x+R_ViewTema,y+R_ViewTema,w-R_ViewTema*2,R_ViewTema*2);
					desen=new drawing_ViewTema(w/2,h/4*3,R_ViewTema*3,verif_rasp_rez_ViewTema());
					desen.display();
					if(!sentData){
						if(db.connect()){
							db.execute("INSERT INTO temascores VALUES("+idTEMA+", "+IDUSER+", "+verif_rasp_rez_ViewTema()+", NOW())");
							sentData = true;
						}
						else sentData = true;
					}
				}
				else if (verif_rasp_ViewTema()<=nQuestionsMax_ViewTema)
					text("Raspunde la toate intrebarile!",x+R_ViewTema,y+R_ViewTema,w-R_ViewTema*2,R_ViewTema*2);
				else {
					text("Test terminat. Poti trimite testul pentru verificare.",x+R_ViewTema,y+R_ViewTema,w-R_ViewTema*2,R_ViewTema*2);
					b.display();
				}
				
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R_ViewTema/3);
			text("Submit",x2,y2,w2,h2);
		}
	}

	void mousePress(){
		if (number<nQuestionsMax_ViewTema) {
			if (questionActive_ViewTema==number) {
				if (tip2==1) {
					int i;
				}
				else if (tip2==3) {
					raspunsuri[0].mousePress();
					raspunsuri[1].mousePress();
					raspunsuri[2].mousePress();
				}
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY) && mousePressed)questionActive_ViewTema=number;
		}
		else {
			if (questionActive_ViewTema==number) {
				if (questions_ViewTema[nQuestionsMax_ViewTema].b.ok){
					int i2;
				}
				else if (verif_rasp_ViewTema()<=nQuestionsMax_ViewTema){
					int i;
				}
				else {
					b.mousePress();
				}
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY))questionActive_ViewTema=number;
		}
	}

	void keyPress(){
		if (number<nQuestionsMax_ViewTema) {
			if (questionActive_ViewTema==number) {
				if (tip2==1) {
					textb.keyPress();			//watch out for this one
				}
				else if (tip2==3) {
					int i;
				}
			}
		}
		else {
			if (questionActive_ViewTema==number) {
				if (questions_ViewTema[nQuestionsMax_ViewTema].b.ok) {
					int i;
				}
				else if (verif_rasp_ViewTema()<=nQuestionsMax_ViewTema){
					int i;
				}
				else {
					int i;
				}
			}
		}
	}
}

void display_all_questions_ViewTema() {
	int i;
	for(i=0;i<nQuestions_ViewTema;i++)
		questions_ViewTema[i].display();
}

void mousePress_all_questions_ViewTema(){
	int i;
	for(i=0;i<nQuestions_ViewTema;i++)
		questions_ViewTema[i].mousePress();
}

void keyPress_all_questions_ViewTema(){
	int i;
	for(i=0;i<nQuestions_ViewTema;i++)
		questions_ViewTema[i].keyPress();
}


int verif_rasp_ViewTema() {
	int i,ok=1;
	for(i=0;i<nQuestions_ViewTema;i++)
		if (questions_ViewTema[i].tip2==3) {
			if (questions_ViewTema[i].rasp!=-1) ok++;
		}
		else if (questions_ViewTema[i].tip2==1) {
			if (questions_ViewTema[i].textb.s!="")
				ok++;
		}
	return ok;
}

int verif_rasp_rez_ViewTema() {
	int i,ok=0;
	for(i=0;i<nQuestions_ViewTema;i++) {
		if (questions_ViewTema[i].tip2==3) {
			if (questions_ViewTema[i].raspunsuri[questions_ViewTema[i].rc].bif==1) ok++;
		}
		else if (questions_ViewTema[i].tip2==1) {
			if (to_nr_ViewTema(questions_ViewTema[i].textb.s)==questions_ViewTema[i].rc)
				ok++;
		}
	}
	return ok*2;
}

int to_nr_ViewTema(String s) {
	int nr=0,i;
	for (i=0;i<s.length();i++)
		if (s.charAt(i)=='\n') break;
		else
			nr=nr*10+int(s.charAt(i))-'0';
	return nr;
}

void add_question_ViewTema(String s1,String s2,String s3,String s4,int rc,int tip1,int tip2,graf_ViewTema[] g,edge_ViewTema[] e,int n1,int n2,int tb,int or,String rcc) {
	nQuestionsMax_ViewTema=5;
	R_ViewTema=width/20;
	if (nQuestions_ViewTema>=1)
		questions_ViewTema[nQuestions_ViewTema]=new question_ViewTema(0,R_ViewTema+R_ViewTema/10,width,height-R_ViewTema-R_ViewTema/10,questions_ViewTema[nQuestions_ViewTema-1].x2+R_ViewTema+R_ViewTema/10,
			0,R_ViewTema,R_ViewTema,R_ViewTema*2,nQuestions_ViewTema,s1,s2,s3,s4,rc,tip1,tip2,g,e,n1,n2,tb,or,rcc);
	else {
		questions_ViewTema[nQuestions_ViewTema]=new question_ViewTema(0,R_ViewTema+R_ViewTema/10,width,height-R_ViewTema-R_ViewTema/10,0,0,R_ViewTema,R_ViewTema,R_ViewTema*2,0,s1,s2,s3,s4,rc,tip1,tip2,g,e,n1,n2,tb,or,rcc);
		questionActive_ViewTema=0;
	}
	nQuestions_ViewTema++;
}

void createGraf_ViewTema(String[] s,int nr,int nrr) {
	int a,b,x,y,n=0,n2=0,act,nn=0;
	int[] vec=new int[200];
	int i,j;
	n=to_nr_ViewTema(s[nr]);
	nr++;
	for (i=1;i<=n;i++) {
	  j=0;
	  x=y=act=0;
	  while (s[nr].charAt(j)!=' ') {
	    x=x*10+s[nr].charAt(j)-'0';
	    j++;
	  }
	  j++;
	  while (s[nr].charAt(j)!=' ') {
	    y=y*10+s[nr].charAt(j)-'0';
	    j++;
	  }
	  j++;
	  while (j<s[nr].length()) {
	    act=act*10+s[nr].charAt(j)-'0';
	    j++;
	  }
	  add_graf_ViewTema(x,y,nrr);
	  if (act==0) {
	  	vec[nn]=questions_ViewTema[nrr].nGrafs-1;
	  	nn++;
	  }
	  nr++;
	}
	  
	n2=to_nr_ViewTema(s[nr]);
	nr++;
	for (i=1;i<=n2;i++) {
	  j=0;
	  a=b=act=0;
	  while (s[nr].charAt(j)!=' ') {
	    a=a*10+s[nr].charAt(j)-'0';
	    j++;
	  }
	  j++;
	  while (s[nr].charAt(j)!=' ') {
	    b=b*10+s[nr].charAt(j)-'0';
	    j++;
	  }
	  j++;
	  while (j<s[nr].length()) {
	    act=act*10+s[nr].charAt(j)-'0';
	    j++;
	  }
	  if (a<200 && b<200) add_edge_ViewTema(questions_ViewTema[nrr].g[a-1],questions_ViewTema[nrr].g[b-1],nrr);
	  if (act==0)
	  	questions_ViewTema[nrr].e[questions_ViewTema[nrr].nEdges-1].active=false;
	  nr++;
	}
	for (i=0;i<nn;i++)
	  	questions_ViewTema[nrr].g[vec[i]].active=false;
}

String[] fct_ViewTema(String[] s) {
	int i;
	String[] ss=new String[1000];
	for (i=0;i<s.length;i+=2)
		ss[i/2]=s[i];
	return ss;
}

String[] to_lines_ViewTema(String s) {
	String[] s2=new String[2000];
	int n=0,i;
	s2[0]="";
	//+++sf
	//012345
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

void add_test_ViewTema(String s) {
	int j=0,rc=0,tip1,tip2,n1=0,n2=0,tb,nrrrr=0,or;					//REQUEST DATA FROM DB
	String tstData = "";
	if(db.connect()){
		db.query("SELECT tema, temaID, classID, date FROM temadata WHERE (classID=-1 OR classID="+clsUsr+")");
		int i = 1;		//date=CAST(CURRENT_TIMESTAMP AS DATE) AND 
		while(db.next()){
			tstData = db.getString("tema");
			idTEMA = db.getInt("temaID");
			if(i==lastTema){
				lastTema++;
				i++;
				break;
			}
			i++;
		}
		if(i==1) stopTEMA = true;
		db.query("SELECT temaID, userID FROM temascores WHERE temaID="+idTEMA+" AND userID="+IDUSER);
		if(db.next())
			stopTEMA = true;
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
	graf_ViewTema[] g=new graf_ViewTema[20];
	edge_ViewTema[] e=new edge_ViewTema[20];

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
}

/*

tip1:
1. Cu graf
2. Deseneaza graf
3. Fara graf

tip2:
1. Cu textbox
2. Doar desenare (pentru 2)
3. Cu variante a,b,c

numar intrebari

tip1
intrebare
tip2
tip2==1: varianta raspuns
tip2==2: nimic
tip2==3: var1,var2,var3,varianta corecta

*/