class panouDr {
	float x,y,w,h,x2;
	String s;
	color c=color(152, 84, 255),c_o=color(132, 64, 235);

	panouDr(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
		x2=width+R*5;
	}

	void update() {
		x2=lerp(x2,x,0.2);
	}

	void display() {
		noStroke();
		if (x2>x && s!="") update();
		if (isBetween(x2,x2+w,mouseX) && isBetween(y,y+h,mouseY))
			fill(c_o);
		else fill(c);
		rect(x2,y,w,h);
		fill(-1);
		textAlign(CENTER,CENTER);
		textSize(R*2/3);
		text(s,x2,y,w,h);
	}
}