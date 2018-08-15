class list {
	float x,y,w,h,h2;
	int nr,selectat,number;
	color c=c6,c_o=c8,c2=c8_o;
	String s;
	String[] elemente;
	boolean ok;

	list(float xx,float yy,float ww,float hh,float hh2,String ss,int numberr) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		h2=hh2;
		s=ss;
		nr=0;
		selectat=-1;
		elemente=new String[30];
		ok=false;
		number=numberr;
	}

	void display() {
		int i;
		boolean ok2;
		if (isBetween(x,x+w,mouseX) && (ok && isBetween(y,y+h+nr*h,mouseY) || isBetween(y,y+h,mouseY))) {
			fill(c_o);
		}
		else {
			ok=false;
			fill(c);
		}
		fill(c);
		noStroke();
  		textAlign(CENTER,CENTER);
		rect(x,y,w,h);
		fill(0,256,0);
		textSize(h/3);
		if (selectat==-1)// || ok)
			text(s,x,y,w,h);
		else 
			text(s+": "+elemente[selectat],x,y,w,h);

		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY))
			ok=true;
		if (ok) {
			for (i=0;i<nr;i++) {
				if (selectat==i) fill(c_o);
				else if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY)) fill(c2);
				else fill(c);
				if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY)) {
					fill(c2);
					ok2=true;
				}
				rect(x,y+h+i*h2,w,h2);
				fill(-1);
				textSize(h2/3);
				text(elemente[i],x,y+h+i*h2,w,h2);
			}
		}
		
	}

	void mousePress(){
		int i;
		if (ok) {
			for (i=0;i<nr;i++) {
				if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY)) {
					if (selectat!=i)
						selectat=i;
					else selectat=-1;
				}
			}
		}
	}
}

void addElement(String s,list l) {
	if (l.nr<30) {
		l.elemente[l.nr]=s;
		l.nr++;
	}
}
