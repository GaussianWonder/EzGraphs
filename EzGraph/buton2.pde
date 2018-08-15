class buton2 { //db
	float x,y,w,h,r,r2;
	float xc,yc,wc,hc;
	String s;
	boolean ok=false, ok2 = false;
	color c=c6,c_o=c8;
	int timer=0;

	buton2(float xx,float yy,float ww,float hh,String ss) {
		x=xc=xx;
		y=yc=yy;
		w=wc=ww;
		h=hc=hh;
		s=ss;
		r=0;
		r2=h/7;
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
		noStroke();
		if (currentModule==8) {
			if (okIntraClasa==0)
				if (statutUsrCoded==0) {
					if (compareStrings(s, "Creare clasa") || compareStrings(s, "Conectare Clasa"))
						x=lerp(x,width+R,0.2);
					else if (compareStrings(s,"Intra intr-o clasa"))
						x=lerp(x,width/7,0.2);
				}
				else {
					if (compareStrings(s, "Creare clasa") || compareStrings(s, "Conectare Clasa"))
						x=lerp(x,width/7,0.2);
					else if (compareStrings(s,"Intra intr-o clasa"))
						x=lerp(x,width+R,0.2);
				}
			if ((compareStrings(s, "Intra intr-o clasa")) && okIntraClasa==1) {
				x=lerp(x,width+R,0.2);
			}
			if (compareStrings(s, "Conectare Clasa") && okIntraClasa==1 || (compareStrings(s, "Creare clasa") && okIntraClasa==2)) {
				x=lerp(x,width/7 + width/5+width/8*3+R,0.2);
			}
			if (compareStrings(s, "Conectare Clasa") && okIntraClasa==2 || compareStrings(s, "Creare clasa") && okIntraClasa==1) {
				x=lerp(x,width+R,0.2);
			}
		}
		//text(okIntraClasa,mouseX,mouseY);

		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			if (r<r2) r++;
			if (timer==0) {
				if (!ok2) {
					timer=21;
					ok2=true;
				}
			}
			if (mousePressed) {
				ok=true;
				if (START==false)
					START=true;
				else if (currentModule==5) {//login
					if (numeUtilizator.s!="" && parola.s!="") {
						boolean OKLOGIN = false;
						String usrrr = "";

						if(!db.connect())dbConnect();
						db.query("SELECT userID, name, surname, nickname, email, pass, classID, isProfessor FROM users");
						while(db.next()){
							int id = db.getInt("userID");
							usrrr = db.getString("name");
							String surname = db.getString("surname");
							String nume = db.getString("nickname");
							String email = db.getString("email");
							String pass = db.getString("pass");
							clsUsr = db.getInt("classID");
							int tmpisprf = db.getInt("isProfessor");
							
							//checkCrypted(String pass, String hash)
							if(checkCrypted(parola.s, pass) && (compareStrings(numeUtilizator.s, nume) || compareStrings(numeUtilizator.s, email))){
								OKLOGIN = true;
								nmUsr = usrrr;
								currentModule=1;
								EROARELOGARE=false;
								IDUSER = id;
								CONTACTIV=surname;
								numeUtilizator.s=parola.s="";
								parola.pass=1;
								numeUtilizator.cursor=parola.cursor=0;
								if(tmpisprf==1) usrProf = true;
								else usrProf = false;
								break;
							}
							else EROARELOGARE=true;
						}
						if(!OKLOGIN){
							EROARELOGARE=true;
							clsUsr = 0;
						}
						else{
							LOGGED = true;
							if(clsUsr>0){
								menu2.tabs[0].sub = new SubMenu[5];	//myAcc
								menu2.tabs[0].sub[0] = new SubMenu(usrrr, 8, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								menu2.tabs[0].sub[1] = new SubMenu("Clasa mea", 12, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								if(usrProf) menu2.tabs[0].sub[2] = new SubMenu("Note Elevi", 20, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								else menu2.tabs[0].sub[2] = new SubMenu("Note", 22, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								menu2.tabs[0].sub[3] = new SubMenu("Feedback", 24, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								menu2.tabs[0].sub[4] = new SubMenu("Deconectare", 11, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								membriiClasa = new ClassMembers(clsUsr, IDUSER, statutUsrCoded, clsNM, nmUsr, surnmUsr);
							}
							else{	//gameranking 19
								menu2.tabs[0].sub = new SubMenu[3];	//myAcc
								menu2.tabs[0].sub[0] = new SubMenu(usrrr, 8, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								menu2.tabs[0].sub[1] = new SubMenu("Feedback", 24, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
								menu2.tabs[0].sub[2] = new SubMenu("Deconectare", 11, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
							}

							if(!usrProf){
								menu2.tabs[2].sub = new SubMenu[5];
								menu2.tabs[2].sub[0] = new SubMenu("Lectii", 26, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[1] = new SubMenu("Teste", 13, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[2] = new SubMenu("Teme", 14, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[3] = new SubMenu("Clasament jocuri", 19, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[4] = new SubMenu("Jocuri", 3, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
							}
							else{
								menu2.tabs[2].sub = new SubMenu[6];
								menu2.tabs[2].sub[0] = new SubMenu("Lectii", 26, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[1] = new SubMenu("Creare Test", 15, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[2] = new SubMenu("Creare Tema", 16, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[3] = new SubMenu("Creare Lectie", 29, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[4] = new SubMenu("Atribuire Teme/Teste", 21, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
								menu2.tabs[2].sub[5] = new SubMenu("Jocuri", 3, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
							}
						}
					}
					else
						EROARELOGARE=true;
				}
				else if (currentModule==6) {//register
					EROAREINREGISTRARE = false;
					if (nume.s!="" && prenume.s!="" && numeUtilizator.s!="" && parola.s!="" &&  parola2.s!="" && email.s!=""
							&& compareStrings(parola.s,parola2.s) && statut.selectat!=-1 && parola.s.length()>=6) {
						int isProf;
						if(statut.selectat == 1) isProf = 0;
						else isProf = 1;

						if(!db.connect())dbConnect();
						db.query("SELECT nickname, email FROM users");
						while(db.next()){
							String tempName = db.getString("nickname");
							String tempEmail = db.getString("email");
							if(compareStrings(tempName, numeUtilizator.s) || compareStrings(tempEmail, email.s))
								EROAREINREGISTRARE = true;
						}

						if(!EROAREINREGISTRARE){
							db.execute("INSERT INTO users VALUE (NULL, '"+nume.s+"', '"+prenume.s+"', '"+numeUtilizator.s+"', '"+email.s+"', '"+crypt(parola.s)+"', "+isProf+", NULL)");
							currentModule=1;
							EROAREINREGISTRARE=false;
							numeUtilizator.s=parola.s=parola2.s=email.s="";
							numeUtilizator.cursor=parola.cursor=parola2.cursor=email.cursor=0;
							parola.pass=parola2.pass=1;
							statut.selectat=-1;
						}
					}
					else{
						EROAREINREGISTRARE=true;
					}

				}
				else if (currentModule==8) {
					if (compareStrings(s, "Note")) currentModule=22;
					else if(compareStrings(s, "Modificare date")) currentModule=10;
					else if (compareStrings(s, "Intra intr-o clasa"))
						okIntraClasa=1;
					else if (compareStrings(s, "Conectare Clasa"))
						okIntraClasa=1;
					else if (compareStrings(s, "Creare clasa"))
						okIntraClasa=2;
				
				}
				else if (currentModule==10) {//IDUSER
					EROAREINREGISTRARE=false;
					if(nume.s!="" && prenume.s!="" && numeUtilizator.s!="" && parola.s!="" &&  parola2.s!="" && email.s!=""
							&& compareStrings(parola.s,parola2.s)){
						int isProf;
						if(statut.selectat == 1) isProf = 0;
						else isProf = 1;

						if(!db.connect())dbConnect();
						db.query("SELECT nickname, email FROM users");
						while(db.next()){
							String tempName = db.getString("nickname");
							String tempEmail = db.getString("email");

							if(parola.s.length()<6 || (compareStrings(tempName, numeUtilizator.s) && !compareStrings(tempName, nicknmUsr))
									|| (compareStrings(tempEmail, email.s) && !compareStrings(tempEmail, emailUsr)))
								EROAREINREGISTRARE = true;
						}
						if(!EROAREINREGISTRARE){
							db.execute("UPDATE users SET name='"+nume.s+"', surname='"+prenume.s+"', nickname='"+numeUtilizator.s+"', email='"+email.s+"', pass='"+crypt(parola.s)+"' WHERE userID="+IDUSER+"");
							menu2.tabs[0].sub[0] = new SubMenu(nume.s, 8, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
							nmUsr = nume.s;
							surnmUsr = prenume.s;
							nicknmUsr = numeUtilizator.s;
							emailUsr = email.s;
							EROAREINREGISTRARE=false;
							//numeUtilizator.s=parola.s=parola2.s=email.s="";
							numeUtilizator.cursor=parola.cursor=parola2.cursor=email.cursor=0;
							parola.pass=parola2.pass=1;
							//statut.selectat=-1;
						}
					}
					else
						EROAREINREGISTRARE=true;
				} else if(currentModule==24) {
					if (s=="Vezi toate feedback-urile") {
						getCommData();
						currentModule = 25;
					}else if (opinie.s.length()>0 && s=="Trimite") {
						submitCommData(opinie.s, votSt.val);
						votSt=new votStele(R*6,R*10,0);
	  					opinie=new textbox(R*3,R*12,width-R*9,R*9,R*2/3,0,0);
	  					updateTextboxes();
	  					trimis=TRIMIS;
	  				}
				}
			}
			fill(c_o);
		}
		else {
			fill(c);
			ok2=false;
			if (r>0) r--;
		}

		rect(x+r/2,y,w-r,h);
		
		rect(x-r2/2-r/2,y+(r2-r)/2,r,r);
		rect(x-r2/2-r/2,y+(r2-r)/2+r2*2,r,r);
		rect(x-r2/2-r/2,y+(r2-r)/2+r2*4,r,r);
		rect(x-r2/2-r/2,y+(r2-r)/2+r2*6,r,r);

		rect(x+r/2+w-r+r2/2,y+(r2-r)/2,r,r);
		rect(x+r/2+w-r+r2/2,y+(r2-r)/2+r2*2,r,r);
		rect(x+r/2+w-r+r2/2,y+(r2-r)/2+r2*4,r,r);
		rect(x+r/2+w-r+r2/2,y+(r2-r)/2+r2*6,r,r);
		
		textSize(R*2/3);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x+r/2,y,w-r,h);

		y=yc;
	}
}