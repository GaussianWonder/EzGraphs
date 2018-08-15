class sagetiSchimb {
	float x,y,w,h;
	color c1=color(172, 117, 255),c1_o=color(152, 97, 235),c2=color(135, 0, 255),c2_o=color(115, 0, 235),c3=color(229, 198, 255),c4=color(214, 165, 255);
	tabel t;

	sagetiSchimb(float xx,float yy,float ww,tabel tt) {
		x=xx;
		y=yy;
		w=ww;
		t=tt;
	}

	void display() {
		noStroke();
		int ok=1,ok2=1;
		if (t.el[0]=="Teme") {
			if (temeT.ramasC+5>=nTeme)
				ok=0;
		}
		else if (t.el[0]=="Teste") {
			if (testeT.ramasC+5>=nTeste)
				ok=0;
		}

		if (t.ramasC==0)
			ok2=0;

		fill(-1);
		//text(t.ramasC,mouseX,mouseY);
		
		if (ok2==0) {
			/*fill(c3);
			rect(x,y,w,w);
			fill(c4);
			triangle(x+w-w/10,y+w/10,x+w-w/10,y+w-w/10,x+w/10,y+w/2);*/
		}
		else if (isBetween(x,x+w,mouseX) && isBetween(y,y+w,mouseY)) {
			if(mousePressed)
				if (delay==0) {
					delay=DELAY;
					updateTabel(t,-1);
				}
			fill(c1_o);
			rect(x,y,w,w);
			fill(c2_o);
			triangle(x+w-w/10,y+w/10,x+w-w/10,y+w-w/10,x+w/10,y+w/2);
		}
		else {
			fill(c1);
			rect(x,y,w,w);
			fill(c2);
			triangle(x+w-w/10,y+w/10,x+w-w/10,y+w-w/10,x+w/10,y+w/2);

		}

		if (ok==0) {
			/*fill(c3);
			rect(x+w*3/2,y,w,w);
			fill(c4);
			triangle(x+w/10+w*3/2,y+w/10,x+w/10+w*3/2,y+w-w/10,x+w-w/10+w*3/2,y+w/2);*/
		}
		else if (isBetween(x+w*3/2,x+w+w*3/2,mouseX) && isBetween(y,y+w,mouseY)) {
			if(mousePressed)
				if (delay==0) {
					delay=DELAY;
					updateTabel(t,1);
				}
			fill(c1_o);
			rect(x+w*3/2,y,w,w);
			fill(c2_o);
			triangle(x+w/10+w*3/2,y+w/10,x+w/10+w*3/2,y+w-w/10,x+w-w/10+w*3/2,y+w/2);
		}
		else {
			fill(c1);
			rect(x+w*3/2,y,w,w);
			fill(c2);
			triangle(x+w/10+w*3/2,y+w/10,x+w/10+w*3/2,y+w-w/10,x+w-w/10+w*3/2,y+w/2);
		}
	}
}