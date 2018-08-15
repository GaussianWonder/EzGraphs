class buton2_ViewTema {
	float x,y,w,h;
	String s;
	boolean ok=false;
	color c=c6,c_o=c6_o;

	buton2_ViewTema(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
	}

	void display() {
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend_ViewTema==1) {
			if (mousePressed)
				ok=true;
			fill(c_o);
		}
		else fill(c);
		rect(x,y,w,h);
		textSize(R_ViewTema/4);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);
	}

	void mousePress(){
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend_ViewTema==1)
				ok=true;
	}

}