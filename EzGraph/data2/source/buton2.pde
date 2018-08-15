class buton2 {
	float x,y,w,h;
	String s;
	boolean ok=false;
	color c=c6,c_o=c6_o;
	ToggleBtn privBtn;
	TextBoxTeo usrName, usrPass;

	buton2(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
	}

	void display() {
		if (s=="Adauga tema"){
			if(privBtn==null)privBtn = new ToggleBtn(new PVector(width/2, 2*height/5), c, w, h, 0.2, color(129, 27, 247), c_o, "PUBLIC", 1);
			else {
				privBtn.update();
				privBtn.display();				
			}
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
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) fill(c_o);
		else fill(c);
		rect(x,y,w,h);
		textSize(R/4);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);
	}

	void mousePress(){
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) {
			if (!ok) {
				ok=true;
				if (s=="Adauga tema") {		//INSERT INTO DB OR CREATE FILE
					temaFinala="";
					int i,j;
					db = new MySQL(thisPapplet, "localhost", "ezgraphs", "root", "");    //localhost

					if(db.connect() && (!usrPass.data.equals("Password") && !usrPass.data.equals("")) && (!usrName.data.equals("Username / Email") && !usrName.data.equals("")) ){
						temaFinala=questions[nQuestionsMax-1].t.s;
						temaFinala+="+++sf";
						temaFinala+="+++sf";

						for (i=0;i<nQuestionsMax-1;i++) {
							temaFinala+=questions[i].tip1;
							temaFinala+="+++sf";
							temaFinala+=questions[i].t.s;
							temaFinala+="+++sf";
							temaFinala+=questions[i].tip2;
							temaFinala+="+++sf";

							if (questions[i].tip1==1) {
								temaFinala+=questions[i].or;
								temaFinala+="+++sf";
								temaFinala+=questions[i].nGrafs;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nGrafs;j++) {
									temaFinala+=int(questions[i].g[j].x) + " " + int(questions[i].g[j].y) + " "
											+ act(questions[i].g[j].active);
									temaFinala+="+++sf";

								}
								temaFinala+=questions[i].nEdges;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nEdges;j++) {
									temaFinala+=int(questions[i].e[j].a+1) + " " + int(questions[i].e[j].b+1) + " "
											+ act(questions[i].e[j].active);
									temaFinala+="+++sf";

								}
							}
							if (questions[i].tip2==1) {
								temaFinala+=questions[i].textb.s;
								temaFinala+="+++sf";

							}
							else if (questions[i].tip2==3) {
								temaFinala+=questions[i].raspunsuri[0].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[1].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[2].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].rasp;
								temaFinala+="+++sf";

							}
							temaFinala+="+++sf";
						}
						//DONE
						temaFinala=elimEndl(temaFinala);
						db.query("SELECT userID, nickname, email, pass, classID FROM users WHERE (nickname='"+usrName.data+"' OR email='"+usrName.data+"')");
						while(db.next()){
							String tmpPass = db.getString("pass");
							if(checkCrypted(usrPass.data, tmpPass)){
								int usrID = db.getInt("userID");
								int clsID = (!privBtn.toggle) ? db.getInt("classID") : -1;
								db.execute("INSERT INTO temadata VALUES(NULL, "+usrID+", "+clsID+", '"+temaFinala+"', '"+questions[nQuestionsMax-1].t.s+"', NOW())");
							}
						}
					}
					else{	//print to file
						PrintWriter output;
						output = createWriter("TEMA.txt");
						temaFinala=questions[nQuestionsMax-1].t.s;
						temaFinala+="+++sf";
						temaFinala+="+++sf";

						for (i=0;i<nQuestionsMax-1;i++) {
							temaFinala+=questions[i].tip1;
							temaFinala+="+++sf";
							temaFinala+=questions[i].t.s;
							temaFinala+="+++sf";
							temaFinala+=questions[i].tip2;
							temaFinala+="+++sf";

							if (questions[i].tip1==1) {
								temaFinala+=questions[i].or;
								temaFinala+="+++sf";
								temaFinala+=questions[i].nGrafs;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nGrafs;j++) {
									temaFinala+=int(questions[i].g[j].x) + " " + int(questions[i].g[j].y) + " "
											+ act(questions[i].g[j].active);
									temaFinala+="+++sf";

								}

								temaFinala+=questions[i].nEdges;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nEdges;j++) {
									temaFinala+=int(questions[i].e[j].a+1) + " " + int(questions[i].e[j].b+1) + " "
											+ act(questions[i].e[j].active);
									temaFinala+="+++sf";

								}
							}
							if (questions[i].tip2==1) {
								temaFinala+=questions[i].textb.s;
								temaFinala+="+++sf";

							}
							else if (questions[i].tip2==3) {
								temaFinala+=questions[i].raspunsuri[0].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[1].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[2].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].rasp;
								temaFinala+="+++sf";

							}
							temaFinala+="+++sf";
						}
						output.print(temaFinala);
						output.flush();
						output.close();
					}
				}
			}
			fill(c_o);
		}
	}

}

int act(boolean a) {
	if (a) return 1;
	else return 0;
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
