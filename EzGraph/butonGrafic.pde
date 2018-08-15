class butonGrafic {
	float x,y,w,h,w2,w3;
	String s1,s2;
	color c,c_o;
	
	butonGrafic(float xx,float yy,float ww,float hh, String ss1,String ss2) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s1=ss1;
		s2=ss2;
		w2=w;
		w3=w-w/3;
	}

	void update(float q) {
		w=lerp(w,q,0.2);
	}

	void display() {
		float sc=0,yc=0;
		if (currentModule==22) {
			//sc=scrollbarNoteElev.y2-scrollbarNoteElev.y;
			sc=scrollbarNoteElev.decateori*scrollbarNoteElev.h4;
		}
		yc=y;
		y=yc-sc;

		stroke(-1,(w2-w)*100/(w2-w3));
		strokeWeight(1);

		line(x+w3+(w2-w3)/8*3,y-(w2-w3)/8*2,x+w3+(w2-w3)/8*3,y+(w2-w3)/8*2);
		line(x+w3+(w2-w3)/8*3,y-(w2-w3)/8*2,x+w3+(w2-w3)/8*2,y-(w2-w3)/8);
		line(x+w3+(w2-w3)/8*3,y-(w2-w3)/8*2,x+w3+(w2-w3)/8*4,y-(w2-w3)/8);

		line(x+w3+(w2-w3)/8*2,y+(w2-w3)/8,x+w3+(w2-w3)/8*6,y+(w2-w3)/8);
		line(x+w3+(w2-w3)/8*6,y+(w2-w3)/8,x+w3+(w2-w3)/8*5,y+(w2-w3)/8*2);
		line(x+w3+(w2-w3)/8*6,y+(w2-w3)/8,x+w3+(w2-w3)/8*5,y);


		noStroke();
		fill(c7);
		strokeWeight(1);
		//rect(x,y-w2/6,w,w2/3);
		if (isBetween(x,x+w2,mouseX) && isBetween(y-w2/6,y+w2/6,mouseY)) {
			if (mousePressed && delay==0) {
				if(!pressedFromMyClass) idNOTE3 = -1;
				delay=DELAY;
				if (s2=="Teme") currentModule=23;
				else currentModule=9;
			}
			update(w3);
			stroke(200);
			fill(200);
		}
		else {
			update(w2);
			stroke(-1);
			fill(-1);
		}

		if (isBetween(x,x+w2,mouseX) && isBetween(y-w2/6,y+w2/6,mouseY)) {
			if (mousePressed && delay==0) {
				delay=DELAY;
				currentModule=20;
			}
			update(w3);
			stroke(200);
		}
		else {
			update(w2);
			stroke(-1);
		}
		line(x,y,x+w,y);
		line(x+w,y,x+w-w2/6,y-w2/6);
		line(x+w,y,x+w-w2/6,y+w2/6);
		textSize(w2/8);
		textAlign(LEFT,CENTER);
		text(s1,x,y-w2/4,w-w2/6,w2/5);
		text(s2,x,y,w-w2/6,w2/5);

		y=yc;
	}

}