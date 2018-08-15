class buton {
	float x,y,w,h;
	String s;
	boolean ok=false;
	color c=c6,c_o=c6_o;
	ToggleBtn privBtn;
	TextBoxTeo usrName, usrPass;

	buton(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
	}

	void display() {
		if (s=="Adauga test"){		//new Btn + Txt for credentials + public / class test
			if(privBtn==null)privBtn = new ToggleBtn(new PVector(width/2, 2*height/5), c, w, h, 0.2, color(129, 27, 247), c_o, "PUBLIC", 1);
			else {
				privBtn.update();
				privBtn.display();				
			}
			//PVector pos, color c, float w, float h, float anim, color hov, color act, float lead, float sz, int i
			if(usrName==null){
				usrName = new TextBoxTeo(new PVector(width/2 + w + 50, 2*height/5), color(102, 102, 102), w, h, 0.2, color(138, 136, 140), color(166, 161, 173), 20, 20, 1);
				usrName.data = "Username / Email";
			}
			else {
				usrName.update();
				if(usrName.focus)textAlign(LEFT);
				else textAlign(CENTER, CENTER);
				usrName.display();
			}

			if(usrPass==null){
				usrPass = new TextBoxTeo(new PVector(width/2 + w + 50, 2*height/5 + h + 50), color(102, 102, 102), w, h, 0.2, color(138, 136, 140), color(166, 161, 173), 20, 20, 1);
				usrPass.data = "Password";
			}
			else {
				usrPass.update();
				if(usrPass.focus)textAlign(LEFT);
				else textAlign(CENTER, CENTER);
				usrPass.display();
			}
		}
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) {
			if (mousePressed && !ok) {
				ok=true;
				if (s=="Adauga test") {
					int i;
					db = new MySQL(thisPapplet, "localhost", "ezgraphs", "root", "");    //localhost
					if(db.connect() && (!usrPass.data.equals("Password") && !usrPass.data.equals("")) && (!usrName.data.equals("Username / Email") && !usrName.data.equals("")) ){		//INSERT THE TEST
						ok=true;
						PrintWriter output;
						output = createWriter(questions[nQuestionsMax].s+".txt");
						output.println(questions[nQuestionsMax].s);
						temaFinala+=questions[nQuestionsMax].s;
						temaFinala+="+++sf";

						for (i=0;i<nQuestionsMax;i++) {		//temaFinala == testData
							output.println(questions[i].s);
							output.println(questions[i].r1);
							output.println(questions[i].r2);
							output.println(questions[i].r3);
							output.println(questions[i].rc);
							output.println();

							temaFinala+=questions[i].s;
							temaFinala+="+++sf";
							temaFinala+=questions[i].r1;
							temaFinala+="+++sf";
							temaFinala+=questions[i].r2;
							temaFinala+="+++sf";
							temaFinala+=questions[i].r3;
							temaFinala+="+++sf";
							temaFinala+=questions[i].rc;
							temaFinala+="+++sf";
							temaFinala+="+++sf";
						}
						output.flush();
						output.close();
						temaFinala=elimEndl(temaFinala);
						// VERIF LOGIN + GET USER DATA
						db.query("SELECT userID, nickname, email, pass, classID FROM users WHERE (nickname='"+usrName.data+"' OR email='"+usrName.data+"')");
						while(db.next()){
							String tmpPass = db.getString("pass");
							if(checkCrypted(usrPass.data, tmpPass)){
								int usrID = db.getInt("userID");
								int clsID = (!privBtn.toggle) ? db.getInt("classID") : -1;
								db.execute("INSERT INTO testdata VALUES(NULL, "+usrID+", "+clsID+", '"+temaFinala+"', '"+questions[nQuestionsMax].t.s+"', NOW())");
							}
						}
					}
					else{	//output DaTing cuz u no hv wifi
						ok=true;
					    PrintWriter output;
						output = createWriter(questions[nQuestionsMax].s+".txt");
						output.println(questions[nQuestionsMax].s);

						for (i=0;i<nQuestionsMax;i++) {
							output.println(questions[i].s);
							output.println(questions[i].r1);
							output.println(questions[i].r2);
							output.println(questions[i].r3);
							output.println(questions[i].rc);
							output.println();
						}
						output.flush();
						output.close();
					}
					
				}
			}
			fill(c_o);
		}
		else fill(c);
		rect(x,y,w,h);
		textSize(R/4);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);
	}

}

String elimEndl(String s) {
	int i,n=0;
	String ss="";
	for (i=0;i<s.length();i++)
		if (s.charAt(i)!='\n')
			ss+=s.charAt(i);
	println(ss);
	return ss;
}