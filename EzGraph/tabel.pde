class tabel {
	float x,y,h;
	float[] w=new float[30];
	String[][] s=new String[30][30];
	String[] el=new String[30];
	int nrc,nrl,ord,ord2;
	int[] nr=new int[30];
	color c=c6,c_o=c8,c2=c8_o;
	int ramasC=0;

	tabel(float xx,float yy,float hh,int nrll,int nrcc,float[] ww, String[][] ss,String[] ell,int[] nrr) {
		x=xx;
		y=yy;
		h=hh;
		w=ww;
		s=ss;
		nrc=nrcc;
		nrl=nrll;
		el=ell;
		ord=-1;
		ord2=1;
		nr=nrr;
	}

	float sum(int j) {
		float suma=0;
		int i;
		for (i=0;i<j;i++)
			suma+=w[i]+1;
		return suma;
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

		int i,j;
		for (i=0;i<nrc;i++) {
			noStroke();
			if (isBetween(x+sum(i),x+sum(i)+w[i],mouseX) && isBetween(y,y+h,mouseY)) {
				fill(c8_o);
				if (mousePressed && delay==0 && currentModule!=21) {
					delay=DELAY;
					if (ord==i)
						ord2=-ord2;
					else
						ord=i;
					s=ordonare(ord,ord2);
				}
			}
			else fill(c6_o);
			rect(x+sum(i),y,w[i],h);
			textAlign(CENTER,CENTER);
			textSize(h/2);
			fill(0,256,0);
			text(el[i],x+sum(i),y,w[i],h);
			if (ord==i) {
				stroke(0,256,0);
				strokeWeight(2);
				line(x+sum(i)+w[i]-20,y+h/3,x+sum(i)+w[i]-20,y+h/3*2);
				if (ord2==1) {
					line(x+sum(i)+w[i]-20,y+h/3*2,x+sum(i)+w[i]-20-h/6,y+h/3*2-h/6);
					line(x+sum(i)+w[i]-20,y+h/3*2,x+sum(i)+w[i]-20+h/6,y+h/3*2-h/6);
				}
				else {
					line(x+sum(i)+w[i]-20,y+h/3,x+sum(i)+w[i]-20-h/6,y+h/3+h/6);
					line(x+sum(i)+w[i]-20,y+h/3,x+sum(i)+w[i]-20+h/6,y+h/3+h/6);	
				}
			}
		}
		for (i=0;i<nrl;i++)
			for (j=0;j<nrc;j++) {
				noStroke();
				if (isBetween(x,x+sum(nrc),mouseX) && isBetween(y+h*i+h+i+1,y+h*i+h+i+1+h,mouseY))
					fill(c8_o);
				else fill(c);
				rect(x+sum(j),y+h*i+h+i+1,w[j],h);
				textAlign(CENTER,CENTER);
				textSize(h/4);
				fill(-1);
				text(s[i][j],x+sum(j),y+h*i+h+i+1,w[j],h);
			}
		y=yc;
	}

	String[][] ordonare(int o,int o2) {
		int i,j;
		String[] a;
		if (o2==1) {
			for (i=0;i<nrl-1;i++)
				for (j=i+1;j<nrl;j++)
					if (nr[o]==0 && compareStr(s[i][o],s[j][o])==1 || nr[o]==1 && to_nr(s[i][o])>to_nr(s[j][o])) {
						a=s[i];
						s[i]=s[j];
						s[j]=a;
					}
		}
		else  {
			for (i=0;i<nrl-1;i++)
				for (j=i+1;j<nrl;j++)
					if (nr[o]==0 && compareStr(s[i][o],s[j][o])==-1 || nr[o]==1 && to_nr(s[i][o])<to_nr(s[j][o])) {
						a=s[i];
						s[i]=s[j];
						s[j]=a;
					}
		}
		return s;
	}
}

void addElementInTable(String[] a,tabel t) {
	t.s[t.nrl]=a;
	t.nrl++;
}

int to_nr(String s) {
	int nr=0,i;
	for (i=0;i<s.length();i++)
		if (s.charAt(i)=='\n') break;
		else
			nr=nr*10+int(s.charAt(i))-'0';
	return nr;
}

int compareStr(String a,String b) {
	int i,ok=0;
	for (i=0;i<min(a.length(),b.length());i++)
		if (a.charAt(i)<b.charAt(i)) {
			ok=-1;
			break;
		}
		else if (a.charAt(i)>b.charAt(i)) {
			ok=1;
			break;
		}
	if (ok==0) {
		if (a.length()<b.length())
			ok=-1;
		else if (a.length()>b.length())
			ok=1;
	}
	return ok;
}

void updateTabel(tabel t,int x) {
	int val=t.ramasC;
	String[] lin=new String[30];
	print(val,' ',nTeme,' ',nTeste + '\n');
	float[] w=new float[30];
	String[][] s=new String[30][30];
	String[] el=new String[30];
	int[] nr=new int[30];
  	w[0]=width/2;
  	nr[0]=0;
  	int nrc=1,nrl=0,i;
  	//print(t.ramasC,' ');
	if (x==-1) {
		if (t.ramasC>=5) {
			if (t.el[0]=="Teme") {
				//print("Teme-1");
  				el[0]="Teme";
				temeT.ramasC-=5;
				temeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
	  			for (i=val-5;i<val/*nTeme*/;i++) {
	    			lin=new String[30];
	    			lin[0]=teme[i];
	    			addElementInTable(lin,temeT);
	    		}
	    		temeT.ramasC=val-5;
		    	ssTemeT.t=temeT;
	    	}
	    	else if (t.el[0]=="Teste") {
				//print("Teste-1");
  				el[0]="Teste";
				testeT.ramasC-=5;
				testeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
	  			for (i=val-5;i<val/*nTeme*/;i++) {
	    			lin=new String[30];
	    			lin[0]=teste[i];
	    			addElementInTable(lin,testeT);
	    		}
	    		testeT.ramasC=val-5;
		    	ssTesteT.t=testeT;
	    	}
    	}
	}
	else  {
		if (t.el[0]=="Teme") {
			if (temeT.ramasC+5<nTeme) {
				//print("Teme1");
				temeT.ramasC+=5;
	  			el[0]="Teme";
				temeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
		  		for (i=val+5;i<min(val+10,nTeme)/*nTeme*/;i++) {
		    		lin=new String[30];
		    		lin[0]=teme[i];
		    		addElementInTable(lin,temeT);
		    	}
	    		temeT.ramasC=val+5;
		    	ssTemeT.t=temeT;
		    }
	    }
	    else if (t.el[0]=="Teste") {
			if (testeT.ramasC+5<nTeste) {
				//print("Teste1");
				testeT.ramasC+=5;
	  			el[0]="Teste";
				testeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
		  		for (i=val+5;i<min(val+10,nTeste)/*nTeme*/;i++) {
		    		lin=new String[30];
		    		lin[0]=teste[i];
		    		addElementInTable(lin,testeT);
		    	}
	    		testeT.ramasC=val+5;
		    	ssTesteT.t=testeT;
		    }
	    }
	}
}