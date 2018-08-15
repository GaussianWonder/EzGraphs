class raspuns {
	float x,y,w,h,r1=R/6,r2=R/12;
	String s;
	int number,bif,rasp,ctr,ok;
	color c_Fill=c6,c_Fill_o=c6_o;
	textbox t;

	raspuns(float xx,float yy,float ww,float hh,String ss,int nrr,int ctrr) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
		number=nrr;
		ctr=ctrr;
		bif=0;
		rasp=-1;
		ok=0;
		t=new textbox(x+R,y,w-R,h,R/4,1,0,number);
	}

	void display() {
		noStroke();
		t.w=w-R;
		
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			fill(c_Fill_o);
			fill(-1,60);
		}
		else {
			fill(c_Fill);
			fill(-1,30);
		}
		stroke(-1);
		strokeWeight(2);
		rect(x,y,w,h);
		textSize(R/4);
		fill(-1);
		textAlign(LEFT,CENTER);
		fill(-1);
		ellipse(x+R/2,y+h/2,r1*2,r1*2);
		if (bif==0) fill(-1);
		else fill(0);
		noStroke();
		ellipse(x+R/2,y+h/2,r2*2,r2*2);
		s=t.s;
		t.display();
	}

	void mousePress(){
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && !questions[nQuestionsMax].b.ok){
       		delay=DELAY;
			if (bif==0) {
				questions[number].raspunsuri[0].bif=0;
				questions[number].raspunsuri[1].bif=0;
				questions[number].raspunsuri[2].bif=0;
				questions[number].rasp=ctr;
				bif=1;
			}
			else {
				bif=0;
				questions[number].rasp=-1;
			}
		}
	}

	void keyPress(){
		t.keyPress();
	}
}