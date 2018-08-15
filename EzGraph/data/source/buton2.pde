class buton2 {
	float x,y,w,h;
	String s;
	boolean ok=false;
	color c=c6,c_o=c6_o;

	buton2(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
	}

	void display() {
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) {
			if (mousePressed && !ok) {
				ok=true;
				START=true;
			}
			fill(c_o);
		}
		else fill(c);
		rect(x,y,w,h);
		textSize(R/4);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);
	}

}
