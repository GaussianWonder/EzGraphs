class raspuns_TestView {
	float x,y,w,h,r1=R_TestView/6,r2=R_TestView/12;
	String s;
	int number,bif,rasp,ctr,ok;
	color c_Fill=c6,c_Fill_o=c6_o;

	raspuns_TestView(float xx,float yy,float ww,float hh,String ss,int nrr,int ctrr) {
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
	}

	void display() {
		noStroke();
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			fill(c_Fill_o);
			fill(-1,60);
		}
		else {
			fill(c_Fill);
			fill(-1,30);
		}
		if (questions_TestView[nQuestionsMax_TestView].b.ok)
				if (questions_TestView[number].rc==ctr) {
					if (bif==1 && ok==0)
						s+="       -> Raspuns corect!";
					fill(0,256,0);
					fill(0,256,0,60);
					ok=1;
				}
				else if (bif==1) {
					fill(256,0,0);
					fill(256,0,0,60);
					if (ok==0)
						s+="       -> Raspuns gresit!";
					ok=1;
				}
		stroke(-1);
		strokeWeight(2);
		rect(x,y,w,h);
		textSize(R_TestView/4);
		fill(-1);
		textAlign(LEFT,CENTER);
		text(s,x+R_TestView,y,w,h);
		fill(-1);
		ellipse(x+R_TestView/2,y+h/2,r1*2,r1*2);
		if (bif==0) fill(-1);
		else fill(0);
		noStroke();
		ellipse(x+R_TestView/2,y+h/2,r2*2,r2*2);
	}

	void mousePress(){
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && !questions_TestView[nQuestionsMax_TestView].b.ok){//if (delay==0) {
	   		delay_TestView=DELAY_TestView;
			if (bif==0) {
				questions_TestView[number].raspunsuri[0].bif=0;
				questions_TestView[number].raspunsuri[1].bif=0;
				questions_TestView[number].raspunsuri[2].bif=0;
				questions_TestView[number].rasp=ctr;
				bif=1;
			}
			else {
				bif=0;
				questions_TestView[number].rasp=-1;
			}
			print(bif);
		}
	}
}