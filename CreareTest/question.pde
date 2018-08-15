class question {
	float x,y,w,h,w2,x2,y2,h2,h3;
	color c_Fill=c8,c_Fill_o=c8,c_Fill2=c7,c_Fill2_o=c7_o,c_Fill3=c6;
	int number=0,rasp=-1,rc;
	String s,r1,r2,r3,r4;
	raspuns[] raspunsuri=new raspuns[3];
	buton b;
	drawing desen=null;
	textbox t;

	question(float xx,float yy,float ww,float hh,float xx2,float yy2,float ww2,float hh2,float hh3,int nrr,
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
		raspunsuri[0]=new raspuns(x+R,y+R*4,width-R*2,R,r1,nrr,0);
		raspunsuri[1]=new raspuns(x+R,y+R*5+R/10,width-R*2,R,r2,nrr,1);
		raspunsuri[2]=new raspuns(x+R,y+R*6+R/10*2,width-R*2,R,r3,nrr,2);
		if (number==nQuestionsMax) {
			w2=(width-R/10-questions[number-1].x2-questions[number-1].w2)/2;
			x2=questions[number-1].x2+questions[number-1].w2+R/10;
		}
		else if (number==nQuestionsMax+1) {
			w2=questions[number-1].w2;
			x2=questions[number-1].x2+w2+R/10;
			b=new buton(x+R,y+R*4,R*2,R,"Adauga test");
		}
		t=new textbox(x+R,y+R,w-R*2,R*2,R/3);
	}

	void display() {
		int i;
		noStroke();
		if (number<nQuestionsMax) {
			r1=raspunsuri[0].s;
			r2=raspunsuri[1].s;
			r3=raspunsuri[2].s;
			if (questionActive==number) {
				fill(c_Fill2);
				if (questions[nQuestionsMax+1].b.ok)
					if (raspunsuri[rc].bif==0)
						fill(256,80,80);
					else fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//text(s,x+R,y+R,w-R*2,R*2);
				textAlign(CENTER,CENTER);
				raspunsuri[0].display();
				raspunsuri[1].display();
				raspunsuri[2].display();
				s=t.s;
				t.display();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,80,80);
						else fill(80,256,80);
					//if (mousePressed) questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,0,0);
						else fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else if (number==nQuestionsMax) {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//desen=new drawing(w/2,h/4*3,R*3,10);
				//desen.display();
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
			text("Nume test",x2,y2,w2,h2);
		}
		else {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//desen=new drawing(w/2,h/4*3,R*3,10);
				//desen.display();
				if (questions[nQuestionsMax+1].b.ok) {
					text("Test adaugat.",x+R,y+R,w-R*2,R*2);
				}
				else if (verif_rasp()<=nQuestionsMax)
					text("Adauga toate intrebarile!",x+R,y+R,w-R*2,R*2);
				else {
					text("Poti adauga testul.",x+R,y+R,w-R*2,R*2);
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
			text("Adauga test",x2,y2,w2,h2);
		}
	}

	void mousePress(){
		if(b!=null && b.s.equals("Adauga test") && questionActive==number){
			if(b.privBtn!=null && b.privBtn.isHovered(mouseX, mouseY))
				b.privBtn.toggle = (b.privBtn.toggle) ? false : true;
			if(b.usrName!=null)
				b.usrName.focus = (b.usrName.isHovered(mouseX, mouseY)) ? true : false;
			if(b.usrPass!=null)
				b.usrPass.focus = (b.usrPass.isHovered(mouseX, mouseY)) ? true : false;
		}
		int i;
		noStroke();
		if (number<nQuestionsMax) {
			r1=raspunsuri[0].s;
			r2=raspunsuri[1].s;
			r3=raspunsuri[2].s;
			if (questionActive==number) {
				fill(c_Fill2);
				if (questions[nQuestionsMax+1].b.ok)
					if (raspunsuri[rc].bif==0)
						fill(256,80,80);
					else fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//text(s,x+R,y+R,w-R*2,R*2);
				textAlign(CENTER,CENTER);
				raspunsuri[0].mousePress();
				raspunsuri[1].mousePress();
				raspunsuri[2].mousePress();
				s=t.s;
				t.display();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,80,80);
						else fill(80,256,80);
					questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,0,0);
						else fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else if (number==nQuestionsMax) {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				t.display();
				s=t.s;
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					questionActive=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text("Nume test",x2,y2,w2,h2);
		}
		else {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				if (questions[nQuestionsMax+1].b.ok) {
					text("Test adaugat.",x+R,y+R,w-R*2,R*2);
				}
				else if (verif_rasp()<=nQuestionsMax)
					text("Adauga toate intrebarile!",x+R,y+R,w-R*2,R*2);
				else {
					text("Poti adauga testul.",x+R,y+R,w-R*2,R*2);
					b.display();
				}
				
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					questionActive=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text("Adauga test",x2,y2,w2,h2);
		}
	}

	void keyPress(){
		if(questionActive==number){
			t.keyPress();
			raspunsuri[0].keyPress();
			raspunsuri[1].keyPress();
			raspunsuri[2].keyPress();
		}

		if(b!=null && b.s.equals("Adauga test") && questionActive==number){
			if(b.usrName!=null && b.usrName.focus)
				b.usrName.keyIsPressed();
			if(b.usrPass!=null && b.usrPass.focus)
				b.usrPass.keyIsPressed();
		}
	}
}

void display_all_questions() {
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].display();
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

void add_question(String s1,String s2,String s3,String s4,int rc) {
	if (nQuestions>=1)
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,questions[nQuestions-1].x2+R+R/10,
			0,R,R,R*2,nQuestions,s1,s2,s3,s4,rc);
	else {
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,0,0,R,R,R*2,0,s1,s2,s3,s4,rc);
		questionActive=0;
	}
	nQuestions++;
}

int verif_rasp() {
	int i,ok=1;
	for(i=0;i<nQuestions;i++)
		if (questions[i].rasp!=-1) ok++;
	return ok;
}

int verif_rasp_rez() {
	int i,ok=0;
	for(i=0;i<nQuestions;i++)
		if (questions[i].raspunsuri[questions[i].rc].bif==1) ok++;
	return ok;
}

int to_nr(String s) {
	int nr=0,i;
	for (i=0;i<s.length();i++)
		nr=nr*10+int(s.charAt(i))-'0';
	return nr;
}

void add_test() {
	int i=0;
    for (i=0;i<nQuestionsMax;i++)
    	add_question("","","","",0);
}