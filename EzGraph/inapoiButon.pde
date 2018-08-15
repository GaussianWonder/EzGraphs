class inapoiButon {
	float x,y,w,h;
	color c1=color(94, 155, 255),c2=color(201, 221, 255),c1_o=color(74, 135, 235),c2_o=color(221, 241, 255);

	inapoiButon(float xx,float yy,float ww,float hh) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
	}

	void display() {
		noStroke();
		float sc=0,yc=0;
		 if (currentModule==8) {
			//sc=scrollbarCont.y2-scrollbarCont.y;
			sc=scrollbarCont.decateori*scrollbarCont.h4;
		}
		yc=y;
		y=yc-sc;

		if (currentModule==8)
			if (okIntraClasa==1)
				x=lerp(x,width-w-R*2,0.2);
			else if (okIntraClasa==2)
				x=lerp(x,width-w-R*2,0.2);
			else
				x=lerp(x,width+R,0.2);

		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			if (mousePressed && delay==0) {
				delay=DELAY;
				if (currentModule==8)
					okIntraClasa=0;
			}
			fill(c1_o);
		}
		else fill(c1);
		rect(x,y,w,h);

		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY))
			fill(c2_o);
		else fill(c2);
		rect(x+w/8*2,y+w/8*3,w/8*3,w/8*2);
		triangle(x+w/8*4,y+w/8*2,x+w/8*4,y+w/8*6,x+w/8*6,y+w/8*4);

		y=yc;
	}
}