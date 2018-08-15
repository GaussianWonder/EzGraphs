class list {
	boolean init1 = false, init2 = false;
	float x,y,w,h,h2;
	int nr,selectat;
	color c=c6,c_o=c8,c2=c8_o;
	String s;
	String[] elemente;
	boolean ok;

	list(float xx,float yy,float ww,float hh,float hh2,String ss) {
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
	}

	void display() {
		float sc=0,yc=0;
		if (currentModule==10) {
			//sc=scrollbarModif.y2-scrollbarModif.y;
			sc=scrollbarModif.decateori*scrollbarModif.h4;
		}
		else if (currentModule==6) {
			//sc=scrollbarInreg.y2-scrollbarInreg.y;
			sc=scrollbarInreg.decateori*scrollbarInreg.h4;
		}
		else if (currentModule==8) {
			//sc=scrollbarCont.y2-scrollbarCont.y;
			sc=scrollbarCont.decateori*scrollbarCont.h4;
		}
		else if (currentModule==20) {
			//sc=scrollbarNoteElevi.y2-scrollbarNoteElevi.y;
			sc=scrollbarNoteElevi.decateori*scrollbarNoteElevi.h4;
		}
		else if (currentModule==22) {
			//sc=scrollbarNoteElev.y2-scrollbarNoteElev.y;
			sc=scrollbarNoteElev.decateori*scrollbarNoteElev.h4;
		}
		yc=y;
		y=yc-sc;
		int i;
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
		for (i=0;i<nr;i++)
				if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY) && frameCount%4==0) {
					if (mousePressed)
						if (selectat!=i) {
							selectat=i;
							if (currentModule==20)

								if (s=="Alege test"){
									init1 = true;
									float[] ww=new float[30];
									String[][] ss=new String[30][30];
									String[] el=new String[30];
									int[] nrr=new int[30];
									int nrc=0,nrl=0;
									String[] lin=new String[30];
									nrc=2;
									ww[0]=width-R*11-R*2;
									ww[1]=R*10;
									el[0]="Nume elev";
									el[1]="Nota test";
									nrr[0]=0;
									nrr[1]=1;

									updateEleviTest(clsUsr, IDUSER, teste[selectat]);
									nElevi = elevi.length;
									noteElevi=new tabel(R*3/2,R*3,R*2,nrl,nrc,ww,ss,el,nrr);
									for (i=0;i<nElevi;i++) {
									    lin=new String[200];
									    lin[0]=elevi[i];
									    lin[1]=noteEleviTest[i];
									    addElementInTable(lin, noteElevi);
									}
								}
								else if (s=="Alege tema"){
									init2 = true;
									float[] ww=new float[30];
									String[][] ss=new String[30][30];
									String[] el=new String[30];
									int[] nrr=new int[30];
									int nrc=0,nrl=0;
									String[] lin=new String[30];

									nrc=2;
									ww[0]=width-R*11-R*2;
									ww[1]=R*10;
									el[0]="Nume elev";
									el[1]="Nota tema";
									nrr[0]=0;
									nrr[1]=1;

									updateEleviTema(clsUsr, IDUSER, teme[selectat]);
									nElevi = elevi.length;
									noteElevi2=new tabel(R*3/2,R*3,R*2,nrl,nrc,ww,ss,el,nrr);
									for (i=0;i<nElevi;i++) {
									  	lin=new String[30];
									    lin[0]=elevi[i];
									    lin[1]=noteEleviTema[i];
									    addElementInTable(lin,noteElevi2);
									}
								}
						}
						//else selectat=-1;
				}
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY))
			ok=true;
		if (ok)
			for (i=0;i<nr;i++) {
				if (selectat==i) fill(c_o);
				else if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY)) fill(c2);
				else fill(c);
				rect(x,y+h+i*h2,w,h2);
				fill(-1);
				textSize(h2/3);
				text(elemente[i],x,y+h+i*h2,w,h2);
			}
		y=yc;
	}
}

void addElement(String s,list l) {
	if (l.nr<30) {
		l.elemente[l.nr]=s;
		l.nr++;
	}
}