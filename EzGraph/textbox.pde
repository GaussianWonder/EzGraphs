class textbox {
	float x,y,w,h,sz;
	String s,sP;
	color c=c6,c_o=c6_o;
	int cursor,randuri,rand,cursor2;
	boolean ok;
	int unRand,pass,pass2;

	textbox(float xx,float yy,float ww,float hh,float szz,int unRRand,int passs) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		sz=szz;
		s=sP="";
		ok = false;
		cursor=0; //global
		cursor2=0; //linie
		randuri=1;
		rand=0;
		unRand=unRRand;
		pass2=pass=passs;
	}

	void display() {
		if (currentModule==8)
			if (okIntraClasa>0) {
				x=lerp(x,width/7 + width/5,0.2);
				if (abs(x-width/7 - width/5)<0.2)
					x=width/7 + width/5;
			}
			else 
				x=lerp(x,-width/8*4,0.2);
		strokeWeight(2);
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
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			fill(c_o);
			fill(-1,60);
			if (mousePressed)
				ok=true;
		}
		else {
			if (!ok){
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
		noStroke();
		fill(-1);
		if (ok) textAlign(LEFT,LEFT);
		else textAlign(CENTER,CENTER);
		textSize(R*2/3);
		if (pass==0)
			text(s,x,y,w,h);
		else 
			text(pass(s),x,y,w,h);
		if (pass2==1) {
			if (isBetween(x+w+R,x+w+R+R*3,mouseX) && isBetween(y,y+h,mouseY)) {
				fill(c_o);
				if (mousePressed && frameCount%4==0)
					pass=(pass==1)?0:1;
			}
			else 
				fill(c);
			rect(x+w+R,y,R*3,h);
			fill(-1);
			textSize(R*2/3);
			textAlign(CENTER,CENTER);
			if (pass==0)
				text("Hide",x+w+R,y,R*3,h);
			else 
				text("Show",x+w+R,y,R*3,h);
		}
		if (ok) {//} && delay==0) {
			/*delay=10;
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
			strokeWeight(1);
			textSize(R*2/3);*/
			/*if (!keyPressed && frameCount%60>30)
				if (pass==0)
					line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
				else 
					line(x+textWidth(pass(ss1)),y+sz*rr+rr*sz/2,x+textWidth(pass(ss1)),y+sz*rr+sz+rr*sz/2);*/
		}
		y=yc;
		noStroke();
	}
	
	void PressKeyProperly(){
		float sc=0,yc=0;
		if (currentModule==10)
			sc=scrollbarModif.y2-scrollbarModif.y;
		else if (currentModule==6)
			sc=scrollbarInreg.y2-scrollbarInreg.y;
		else if (currentModule==8)
			sc=scrollbarCont.y2-scrollbarCont.y;
		yc=y;
		y=yc-sc;

		textSize(sz);
		if (ok) {//} && delay==0) {
			if (s.length()>=1 && cursor>=1)
				if (s.charAt(cursor-1)=='\n')
					cursor--;
			delay=10;
			textSize(R*2/3);
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
			if (keyCode!=LEFT && keyCode!=RIGHT)//frameCount%60>30
				if (pass==0)
					line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
				else 
					line(x+textWidth(pass(ss1)),y+sz*rr+rr*sz/2,x+textWidth(pass(ss1)),y+sz*rr+sz+rr*sz/2);
			if (keyPressed) {//} && delay==0) { && frameCount%10==0
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
						if (unRand==0) {
							ss=ss2="";
							for (i=0;i<ll;i++)
								ss+=s.charAt(i);
							for (i=ll;i<s.length();i++) {
								ss2+=s.charAt(i);
								if (pass==0 && textWidth(ss2)>w || pass==1 && textWidth(pass(ss2))>w) {
									ss+='\n';
									ss2="";
								}
								ss+=s.charAt(i);
							}
							s=ss;
						}
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
				else  if (textWidth(key)>0) {
					//(keyCode!=UP && keyCode!=DOWN && (key>='0' && key<='9' || key>='a' && key<'z' || key>='A' && key<='Z')) {
					int i;
					String ss="",ss2="";
					for (i=0;i<cursor;i++)
						ss+=s.charAt(i);
					ss+=key;
					for (i=cursor;i<s.length();i++)
						if (s.charAt(i)!='\n')
							ss+=s.charAt(i);
					if (unRand==0) {
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
					else 
						if ((pass==0 && textWidth(ss)<w || pass==1 && textWidth(pass(ss))<w) && key!='\n') {
							s=ss;
							cursor++;
						}
				}
			}
		}
		y=yc;
	}

}

String pass(String s) {
	int i;
	String ss="";
	for (i=0;i<s.length();i++)
		if (textWidth(s.charAt(i))>0)
			ss+="*";
	return ss;
}