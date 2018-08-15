class lectieProf {
	float x,y,w,h,w2,nota;
	String s,s2,s3;
	votStele vs;
	int vot;

	lectieProf(float xx,float yy,float ww,float hh,String ss,String ss2,String ss3,float notaa,int vott) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
		s2=ss2;
		s3=ss3;
		nota=notaa;
		w2=w/40;
		vot=vott;
		if (vot==0) {
			vs=new votStele(x+w2,y+w2*5,1);
			vs.val=int(nota);
		}
		else 
			vs=new votStele(x+w2,y+w2*5,0);
	}

	void display() {
		float sc=0,yc=0;
		if (currentModule==26) {
			//sc=scrollbarModif.y2-scrollbarModif.y;
			sc=scrollbarLectii.decateori*scrollbarLectii.h4;
		}
		else if (currentModule==27) {
			//sc=scrollbarModif.y2-scrollbarModif.y;
			sc=scrollbarLectie.decateori*scrollbarLectie.h4;
		}
		yc=y;
		y=yc-sc;
		if (currentModule==27 && w2!=w/20) {
			w2=w/20;
			vs.x=x+w2;
			vs.y=y+w2*5;
		}

		fill(-1,30);
		strokeWeight(2);
		stroke(-1);
		rect(x,y,w,h);
		if (isBetween(x+w2,x+w2+w-w2*2,mouseX) && isBetween(y+w2*7,y+w2*7+h-w2*8,mouseY)) {
			if (mousePressed && delay==0) {
				delay=DELAY;
				if (currentModule==26) {
					lectieCurentaprof=new lectieProf(R*3,R*9,w/2 - R*3,lungimeLectie(s),s,s2,s3,0,1);
					String grafCoded = getGraf(lectieCurentaprof.s, lectieCurentaprof.s2);
					if(!grafCoded.equals("INVALID")) textToGraf(grafCoded);
					else grafLectie = null;

					scrollbarLectie=new scrollbar2(w/2 + R*3, R*2, R/2,height-R*2,int((lectieCurentaprof.y+lectieCurentaprof.h+R*3)/4/R/3+1));
					currentModule=27;
				}
			}
			fill(-1,90);
		}
		else fill(-1,60);
		rect(x+w2,y+w2*7,w-w2*2,h-w2*8);
		textAlign(LEFT,CENTER);
		textSize(R/2);
		fill(-1);
		text(s2,x+w2,y+w2,w-w2*2,w2*3/2);
		text(s3,x+w2,y+w2*3,w-w2*2,w2*3/2);
		vs.display();
		if (vot==0)
			image(steaPlina.get(0,0,int((nota-int(nota))*steaPlina.width),steaPlina.height),vs.x+vs.w*3/2*(int)(nota),vs.y-sc);
		textAlign(LEFT,CENTER);
		text(s,x+w2*2,y+w2*7,w-w2*4,h-w2*8);
		y=yc;
		noStroke();
	}

}

