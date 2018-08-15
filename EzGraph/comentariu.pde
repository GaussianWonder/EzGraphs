class comentariu {
	float x,y,w,h,w2;
	int nota;
	String s,s2;
	votStele vs;

	comentariu(float xx,float yy,float ww,float hh,String ss,String ss2,int notaa) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
		s2=ss2;
		nota=notaa;
		w2=w/40;
		vs=new votStele(x+w2,y+w2*3,1);
		vs.val=nota;
	}

	void display() {
		float sc=0,yc=0;
		if (currentModule==25) {
			//sc=scrollbarModif.y2-scrollbarModif.y;
			sc=scrollbarComentarii.decateori*scrollbarComentarii.h4;
		}
		yc=y;
		y=yc-sc;

		fill(-1,30);
		strokeWeight(2);
		stroke(-1);
		rect(x,y,w,h);
		if (isBetween(x+w2,x+w2+w-w2*2,mouseX) && isBetween(y+w2*5,y+w2*5+h-w2*6,mouseY))
			fill(-1,90);
		else fill(-1,60);
		rect(x+w2,y+w2*5,w-w2*2,h-w2*6);
		textAlign(LEFT,CENTER);
		textSize(w2*2/3);
		fill(-1);
		text(s2,x+w2,y+w2,w-w2*2,w2*3/2);
		vs.display();
		textAlign(CENTER,CENTER);
		text(s,x+w2,y+w2*5,w-w2*2,h-w2*6);
		y=yc;
	}

}