class textbox_ViewTema {
	float x,y,w,h,sz;
	String s,sP;
	color c=c6,c_o=c6_o;
	int cursor,randuri,rand,cursor2,ok2;
	boolean ok,freeze;
	int unRand,pass,pass2,number;

	textbox_ViewTema(float xx,float yy,float ww,float hh,float szz,int unRRand,int passs,int numberr) {
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
		freeze=false;
		number=numberr;
		ok2=0;
	}

	void display() {
		textSize(sz);
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
		if (ok2==1) {
			fill(256,0,0);
			fill(256,0,0,30);
		}	
		else if (ok2==2) {
			fill(0,256,0);
			fill(0,256,0,30);
		}
		rect(x,y,w,h);
		fill(-1);
		if (ok)
			textAlign(LEFT,LEFT);
		else textAlign(CENTER,CENTER);
		if (pass==1)
			text(pass_ViewTema(s),x,y,w,h);
		else {
			if (questions_ViewTema[nQuestionsMax_ViewTema].b.ok) {
				freeze=true;
				if (compareStrings(s,questions_ViewTema[number].rcc)==false) {
					text(s+" -> Raspuns gresit! Raspunsul corect este "+questions_ViewTema[number].rcc,x,y,w,h);
					ok2=1;
				}
				else {
					text(s+" -> Raspuns corect",x,y,w,h);
					ok2=2;
				}
			}
			else
				text(s,x,y,w,h);
		}
		if (pass2==1) {
			if (isBetween(x+w+R_ViewTema,x+w+R_ViewTema+R_ViewTema*3,mouseX) && isBetween(y,y+h,mouseY)) {
				fill(c_o);
				if (mousePressed && frameCount%4==0)
					pass=(pass==1)?0:1;
			}
			else 
				fill(c);
			rect(x+w+R_ViewTema,y,R_ViewTema*3,h);
			fill(-1);
			textSize(R_ViewTema*2/3);
			textAlign(CENTER,CENTER);
			if (pass==0)
				text("Hide",x+w+R_ViewTema,y,R_ViewTema*3,h);
			else 
				text("Show",x+w+R_ViewTema,y,R_ViewTema*3,h);
		}
	}

	void keyPress(){
		strokeWeight(1);
		textSize(sz);
		if (ok && !freeze) {
			delay_ViewTema=10;
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
				if (pass==0)
					line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
				else 
					line(x+textWidth(pass_ViewTema(ss1)),y+sz*rr+rr*sz/2,x+textWidth(pass_ViewTema(ss1)),y+sz*rr+sz+rr*sz/2);
			if (keyPressed) {
				delay_ViewTema=DELAY_ViewTema;
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
								if (pass==0 && textWidth(ss2)>w || pass==1 && textWidth(pass_ViewTema(ss2))>w) {
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
					int i;
					String ss="",ss2="";
					for (i=0;i<cursor;i++)
						ss+=s.charAt(i);
					ss+=key;
					for (i=cursor;i<s.length();i++)
						if (s.charAt(i)!='\n')
							ss+=s.charAt(i);
					if (unRand==0) {
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
					else if ((pass==0 && textWidth(ss)<w || pass==1 && textWidth(pass_ViewTema(ss))<w) && key!='\n') {
							s=ss;
							cursor++;
					}
				}
			}
		}
	}
}

String pass_ViewTema(String s) {
	int i;
	String ss="";
	for (i=0;i<s.length();i++)
		if (textWidth(s.charAt(i))>0)
			ss+="*";
	return ss;
}


boolean compareStrings(String a,String b) {
	String aa="",bb="";
	int i;
	boolean ok=true;
	for (i=0;i<a.length();i++)
		if (textWidth(a.charAt(i))>0)
			aa+=a.charAt(i);
	for (i=0;i<b.length();i++)
		if (textWidth(b.charAt(i))>0)
			bb+=b.charAt(i);
	if (aa.length()!=bb.length()) ok=false;
	else
		for (i=0;i<aa.length();i++)
			if (aa.charAt(i)!=bb.charAt(i)) {
				ok=false;
				break;
			}
	return ok;
}