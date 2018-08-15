class textbox {
	float x,y,w,h,sz;
	String s;
	color c=c6,c_o=c6_o;
	int cursor,randuri,rand,cursor2;
	boolean ok;

	textbox(float xx,float yy,float ww,float hh,float szz) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		sz=szz;
		s="";
		ok = false;
		cursor=0; //global
		cursor2=0; //linie
		randuri=1;
		rand=0;
	}

	void display() {
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			fill(c_o);
			fill(-1,60);
			if (mousePressed)
				ok=true;
		}
		else {
			if (!ok) {
				fill(c);
				fill(-1,30);
			}
			else { 
				fill(c_o);
				fill(-1,60);
			}
			if (mousePressed)
				ok=false;
		}
		stroke(-1);
		strokeWeight(2);
		rect(x,y,w,h);
		textSize(sz);
		fill(-1);
		if (ok){
			textAlign(LEFT,LEFT);
			if (s.length()>=1)
				if (s.charAt(cursor-1)=='\n')
					cursor--;
			String ss1="";
			int ll=0,rr=0;
			for (int i=0;i<cursor;i++)
				if (s.charAt(i)=='\n') {
					rr++;
					ll=i;
				}
			for (int i=ll;i<cursor;i++)
				ss1=ss1+s.charAt(i);
			if (ll>0) ll++;
			stroke(-1);
			if (frameCount%60>30)
				line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
		}
		else textAlign(CENTER,CENTER);
		text(s,x,y,w,h);
	}

	void keyPress(){
		if(key==CODED && keyCode == SHIFT) return;
		textSize(sz);
		if (ok) {
			textAlign(LEFT,LEFT);
			if (s.length()>=1)
				if (s.charAt(cursor-1)=='\n')
					cursor--;
			String ss1="";
			int ll=0,rr=0;
			for (int i=0;i<cursor;i++)
				if (s.charAt(i)=='\n') {
					rr++;
					ll=i;
				}
			for (int i=ll;i<cursor;i++)
				ss1=ss1+s.charAt(i);
			if (ll>0) ll++;
			stroke(-1);
			if (frameCount%60>30)
				line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
				delay=DELAY;
				if (key==8) {
					if (cursor>=1) {
						int i;
						String ss="",ss2;
						for (i=0;i<cursor-1;i++)
							ss+=s.charAt(i);
						for (i=cursor;i<s.length();i++)
							if (s.charAt(i)!='\n')
								ss+=s.charAt(i);
						s=ss;
						ss=ss2="";
						for (i=0;i<ll;i++)
							ss+=s.charAt(i);
						for (i=ll;i<s.length();i++) {
							ss2+=s.charAt(i);
							if (textWidth(ss2)>w) {
								ss+='\n';
								ss2="";
							}
							ss+=s.charAt(i);
						}
						s=ss;
						cursor--;
					}
				}
				else if (keyCode==LEFT) {
					if (cursor-1>=0) {
						cursor--;
					}
				}
				else if (keyCode==RIGHT) {
					if (cursor+1<=s.length()) {
						cursor++;
					}
				}
				else {
					int i;
					String ss="",ss2="";
					
					for (i=0;i<cursor;i++)
						ss+=s.charAt(i);
					ss+=key;
					for (i=cursor;i<s.length();i++)
						if (s.charAt(i)!='\n')
							ss+=s.charAt(i);
					s=ss;
					ss=ss2="";
					for (i=0;i<ll;i++)
						ss+=s.charAt(i);
					for (i=ll;i<s.length();i++) {
						ss2+=s.charAt(i);
						if (textWidth(ss2)>w) {
							ss+='\n';
							ss2="";
							if (i==cursor) cursor++;
						}
						ss+=s.charAt(i);
					}
					s=ss;
					cursor++;
				}
		}
		else textAlign(CENTER,CENTER);
	}
}
