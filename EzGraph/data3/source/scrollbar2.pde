class scrollbar2 {
	float x,y,w,h,y2,h2,y3,h3,numar;
	color c1=c6,c2=c8,c2_o=c8_o;
	float h4;
	float decateori;

	scrollbar2(float xx,float yy,float ww,float hh,float numarr) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		numar=numarr;
		h2=(float)h/numar;
		y2=y3=y;
		h3=h2/4;
		h4=R*3;
		decateori=0;
	}

	void display() {
		fill(c1);
		noStroke();
		rect(x,y,w,h);
		if (isBetween(x,x+w,mouseX) && isBetween(y2,y2+h2,mouseY)) {
			fill(c2_o);
		}
		else fill(c2);
		rect(x,y2,w,h2);
	}
}
