class question {
	float x,y,w,h,w2,x2,y2,h2,h3;
	color c_Fill=c8,c_Fill_o=c8,c_Fill2=c7,c_Fill2_o=c7_o,c_Fill3=c6;
	int number=0,rasp=-1,rc,tip1,tip2,nGrafs,nEdges,tb,or;
	String s,r1,r2,r3,r4;
	raspuns[] raspunsuri=new raspuns[3];
	buton2 b;
	drawing desen=null;
	graf[] g;
	edge[] e;
	textbox textb,t;
	list choose,choose2,choose3;

	question(float xx,float yy,float ww,float hh,float xx2,float yy2,float ww2,float hh2,float hh3,int nrr,
					String ss,String rr1,String rr2,String rr3,int rcc,int tipp1,int tipp2,graf[] grafss,
					edge[] edgess,int nGrafss,int nEdgess,int tbb) {
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
		tip1=tipp1;
		tip2=tipp2;
		g=grafss;
		e=edgess;
		nGrafs=nGrafss;
		nEdges=nEdgess;
		or=0;
		tb=tbb;
		if (number==nQuestionsMax) {
			w2=width-R/10-questions[number-1].x2-questions[number-1].w2;
			x2=questions[number-1].x2+questions[number-1].w2+R/10;
			b=new buton2(x+R,y+R*4,R*2,R,"Adauga tema");
		}
		else if (number==nQuestionsMax-1) {
			w2=width-R/10-questions[number-1].x2-questions[number-1].w2;
			w2/=2;
		}
		
		textb=new textbox(x+R,y+R*4,width/2-R,R,R/4,1,0,number);
		raspunsuri[0]=new raspuns(x+R,y+R*4,width/2-R,R,r1,nrr,0);
		raspunsuri[1]=new raspuns(x+R,y+R*5+R/10,width/2-R,R,r2,nrr,1);
		raspunsuri[2]=new raspuns(x+R,y+R*6+R/10*2,width/2-R,R,r3,nrr,2);

		choose=new list(x,y,R*4,R*2/3,R/2,"Tip1 intrebare",number);
		addElement("Cu graf",choose);
		addElement("Fara graf",choose);

		choose2=new list(choose.x+choose.w+1,y,R*4,R*2/3,R/2,"Tip2 intrebare",number);
		addElement("Cu textBox",choose2);
		addElement("Cu variante multiple",choose2);

		choose3=new list(choose2.x+choose2.w+1,y,R*4,R*2/3,R/2,"Tip graf",number);
		addElement("Neorientat",choose3);
		addElement("Orientat",choose3);

		t=new textbox(x+R,y+R,w-R*2,R*2,R/3,0,0,number);
	}

	void display() {
		int i;
		noStroke();
		if (number<nQuestionsMax-1) {
			if (questionActive==number) {
				if (choose.selectat==0) tip1=1;
				else if (choose.selectat==1) tip1=3;
				else tip1=0;
				if (choose2.selectat==0) tip2=1;
				else if (choose2.selectat==1) tip2=3;
				else tip2=0;
				if (choose3.selectat==0) or=1;
				else if (choose3.selectat==1) or=2;
				else or=0;

				if (tip2==1)
					if (tip1==3)
						textb.w=width-R*2;
					else
						textb.w=width/2-R;
				if (tip1==1) {
					raspunsuri[0].w=width/2-R;
					raspunsuri[1].w=width/2-R;
					raspunsuri[2].w=width/2-R;
				}
				else if (tip1==3) {
					raspunsuri[0].w=width-R*2;
					raspunsuri[1].w=width-R*2;
					raspunsuri[2].w=width-R*2;
				}

				fill(c_Fill2);
				if (questions[nQuestionsMax].b.ok)
					fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				if (tip1!=3)
					t.w=w/2-R;
				else
					t.w=w-R*2;
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3))
					t.display();
				fill(-1);
				textSize(R/4);
				textAlign(CENTER,CENTER);
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3)) {
					if (tip2==1) {
						textb.display();
					}
					else if (tip2==3) {
						raspunsuri[0].display();
						raspunsuri[1].display();
						raspunsuri[2].display();
					}
					if (tip1==1) {
						display_all_edges(questionActive);
						display_all_grafs(questionActive);
						display_all_butons();
						/*if (mousePressed && delay==0 && butonActive=="Add point" && nGrafs<200 &&
								isBetween(width/2+R,width,mouseX) && isBetween(move.y+R,height,mouseY)) {
				        	add_graf(mouseX, mouseY,questionActive);
				    	}*/
					}
				}
				choose.display();
				choose2.display();
				if (tip1==1)
					choose3.display();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions[nQuestionsMax].b.ok)
						fill(80,256,80);
					//if (mousePressed) questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions[nQuestionsMax].b.ok)
						 fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else if (number==nQuestionsMax-1) {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				t.display();
				s=t.s;
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
			textSize(R/3);
			text("Nume tema",x2,y2,w2,h2);
		}
		else {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//desen=new drawing(w/2,h/4*3,R*3,10);
				//desen.display();
				if (questions[nQuestionsMax].b.ok) {
					text("Tema adaugata.",x+R,y+R,w-R*2,R*2);
				}
				else if (verif_rasp()<nQuestionsMax)
					text("Adauga toate intrebarile!",x+R,y+R,w-R*2,R*2);
				else {
					text("Poti adauga tema.",x+R,y+R,w-R*2,R*2);
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
			textSize(R/3);
			text("Adauga tema",x2,y2,w2,h2);
		}
	}

	void mousePress(){
		if(b!=null && b.s.equals("Adauga tema") && questionActive==number){
			if(b.privBtn!=null && b.privBtn.isHovered(mouseX, mouseY))
				b.privBtn.toggle = (b.privBtn.toggle) ? false : true;
			if(b.usrName!=null)
				b.usrName.focus = (b.usrName.isHovered(mouseX, mouseY)) ? true : false;
			if(b.usrPass!=null)
				b.usrPass.focus = (b.usrPass.isHovered(mouseX, mouseY)) ? true : false;
		}
		int i;
		if (number<nQuestionsMax-1) {
			if (questionActive==number) {
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3))
					t.display();			//keyPress
				
				textAlign(CENTER,CENTER);
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3)) {
					if (tip2==1) {
						textb.display();	//keyPress
					}
					else if (tip2==3) {
						raspunsuri[0].mousePress();
						raspunsuri[1].mousePress();
						raspunsuri[2].mousePress();
					}
					if (tip1==1) {
						display_all_edges(questionActive);
						display_all_grafs(questionActive);
						display_all_butons();
						if (delay==0 && butonActive=="Add point" && nGrafs<200 && isBetween(width/2+R,width,mouseX) && isBetween(move.y+R,height,mouseY)) {
				        	add_graf(mouseX, mouseY,questionActive);
				    	}
					}
				}
				choose.mousePress();			//mouse Press????? maybe		===>  !!
				choose2.mousePress();
				if (tip1==1)
					choose3.mousePress();
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY))questionActive=number;
		}
		else if (number==nQuestionsMax-1) {
			if (questionActive==number) {
				textSize(R/4);
				t.display();		//keyPress
				s=t.s;
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY))questionActive=number;
		}
		else {
			if (questionActive==number) {
				if (questions[nQuestionsMax].b.ok) {
					int kkk;
				}
				else if (verif_rasp()<nQuestionsMax){
					int kkk;
				}
				else {
					int kkk;
					b.mousePress();
				}
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) questionActive=number;
		}
	}

	void keyPress(){
		if(b!=null && b.s.equals("Adauga tema") && questionActive==number){
			if(b.usrName!=null && b.usrName.focus)
				b.usrName.keyIsPressed();
			if(b.usrPass!=null && b.usrPass.focus)
				b.usrPass.keyIsPressed();
		}
		int i;
		if (number<nQuestionsMax-1) {
			if (questionActive==number) {
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3))
					t.keyPress();			//keyPress
				
				textAlign(CENTER,CENTER);
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3)) {
					if (tip2==1) {
						textb.keyPress();	//keyPress
					}
					else if (tip2==3) {
						raspunsuri[0].keyPress();
						raspunsuri[1].keyPress();
						raspunsuri[2].keyPress();
					}
					if (tip1==1) {
						display_all_edges(questionActive);
						display_all_grafs(questionActive);
						display_all_butons();
						/*if (mousePressed && delay==0 && butonActive=="Add point" && nGrafs<200 && isBetween(width/2+R,width,mouseX) && isBetween(move.y+R,height,mouseY)) {
				        	add_graf(mouseX, mouseY,questionActive);
				    	}*/
					}
				}
			}
		}
		else if (number==nQuestionsMax-1) {
			if (questionActive==number) {
				textSize(R/4);
				t.keyPress();		//keyPress
				s=t.s;
			}
		}
		else {
			if (questionActive==number) {
				if (questions[nQuestionsMax].b.ok) {
					int kkk;
				}
				else if (verif_rasp()<nQuestionsMax){
					int kkk;
				}
				else {
					int kkk;
				}
			}
		}
	}
}

void mousePress_all_questions(){
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].mousePress();
}

void keyPress_all_questions(){
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].keyPress();
}

void display_all_questions() {
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].display();
}

int verif_rasp() {
	int i,ok=0;
	for(i=0;i<nQuestionsMax;i++)
		if (questions[i].t.s.length()>0 && (questions[i].tip1>0 && questions[i].tip2>0 && (questions[i].tip1==1
				&& questions[i].or>0 || questions[i].tip1==3))) {
			if (questions[i].tip2==3) {
				if (questions[i].rasp!=-1 && questions[i].raspunsuri[0].t.s.length()>0 && questions[i].raspunsuri[1].t.s.length()>0
					 && questions[i].raspunsuri[2].t.s.length()>0) {
					ok++;
					//print(1);
				}
				//else print(0);
			}
			else if (questions[i].tip2==1) {
				if (questions[i].textb.s.length()>0) {
					ok++;
					//print(1);
				}
				//else print(0);
			}
		}
		//else print(0);
	if (questions[nQuestionsMax-1].s.length()>0)
		ok++;
	//print("  :     ",ok,'\n');
	return ok;
}

boolean compareStrings(String a,String b) {
	String aa="",bb="";
	int i;
	boolean ok=true;
	for (i=0;i<a.length();i++)
		if (textWidth(a.charAt(i))>0)
			aa+=a.charAt(i);
	for (i=0;i<b.length();i++)
		if (textWidth(b.charAt(i))>0)
			bb+=b.charAt(i);
	if (aa.length()!=bb.length()) ok=false;
	else
		for (i=0;i<aa.length();i++)
			if (aa.charAt(i)!=bb.charAt(i)) {
				ok=false;
				break;
			}
	return ok;
}

int verif_rasp_rez() {
	int i,ok=0;
	for(i=0;i<nQuestions;i++) {
		if (questions[i].tip2==3) {
			if (questions[i].raspunsuri[questions[i].rc].bif==1) ok++;
		}
		else if (questions[i].tip2==1) {
			if (to_nr(questions[i].textb.s)==questions[i].rc)
				ok++;
		}
	}
	return ok*2;
}

int to_nr(String s) {
	int nr=0,i;
	for (i=0;i<s.length();i++)
		nr=nr*10+int(s.charAt(i))-'0';
	return nr;
}

void add_question(String s1,String s2,String s3,String s4,int rc,int tip1,int tip2,graf[] g,edge[] e,int n1,int n2,int tb) {
	nQuestionsMax=6;
	R=width/20;
	if (nQuestions>=1)
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,questions[nQuestions-1].x2+R+R/10,
			0,R,R,R*2,nQuestions,s1,s2,s3,s4,rc,tip1,tip2,g,e,n1,n2,tb);
	else {
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,0,0,R,R,R*2,0,s1,s2,s3,s4,rc,tip1,tip2,g,e,n1,n2,tb);
		questionActive=0;
	}
	nQuestions++;
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
