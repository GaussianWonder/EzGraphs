void modifCont() {
   	background(c7);
    float sc=scrollbarModif.decateori*scrollbarModif.h4;
   	//text("modif",200,200);
   	if (intraM10==0 || /*parola.s=="" || */numeUtilizator.y!=height/8+R*4 || parola.y!=height/8+R*13) {
      EROAREINREGISTRARE=false;
      if(compareStrings(nicknmUsr, "") || compareStrings(nmUsr, "") || compareStrings(surnmUsr, "") || compareStrings(emailUsr, "")){
        if(!db.connect())dbConnect();
        db.query("SELECT * FROM users WHERE userID = " + IDUSER);
        while(db.next()){
          IDUSER = db.getInt("userID");
          nmUsr = db.getString("name");
          surnmUsr = db.getString("surname");
          nicknmUsr = db.getString("nickname");
          emailUsr = db.getString("email");
          statutUsrCoded = db.getInt("isProfesor");
          if(statutUsrCoded==0){
            statutUsr = "Elev";
            statut.selectat = 1;
          }
          else {
            statutUsr ="Profesor";
            statut.selectat = 0;
          }
          clsUsr = db.getInt("classID");
        }
      }
   		PAROLA="";
   		parola.s=PAROLA;
   		parola2.s="";
   		numeUtilizator.s=nicknmUsr;
      email.s = emailUsr;
      nume.s = nmUsr;
      prenume.s = surnmUsr;
      numeUtilizator.y=height/8+R*4;
      parola.y=height/8+R*13;
      numeUtilizator.cursor=email.cursor=parola.cursor=parola2.cursor=0;
   		//scrollbarModif.y2=scrollbarModif.y;
      updateTextboxes();
   	}
    //if()
   	if (EROAREINREGISTRARE) {
        //fill(256,0,0);
        fill(255,97,0);
        textSize(R);
        textAlign(LEFT,CENTER);
        text("Asigura-te ca ai completat toate campurile corect!\nEmailul/Numele de utilizator poate sunt deja folosite!"+
            "\nParola trebuie sa aiba cel putin 6 caractere!",width/7,email.y+email.h+R*3-sc,width,R*6);
    }
    fill(-1);
    textSize(R*2);
    textAlign(CENTER,CENTER);
    text("MODIFICARE DATE CONT",0,height/8-sc,width,R*3);
    textSize(R);
    textAlign(LEFT,CENTER);
    text("Nume utilizator:",width/7,height/8+R*4-sc,width/5,R*2);
    text("Nume:",width/7,height/8+R*7-sc,width/5,R*2);
    text("Prenume:",width/7,height/8+R*10-sc,width/5,R*2);
    text("Parola:",width/7,height/8+R*13-sc,width/5,R*2);
    text("Parola confirmare:",width/7,height/8+R*16-sc,width/5,R*2);
    text("Email:",width/7,height/8+R*19-sc,width/5,R*2);
    numeUtilizator.display();
    nume.display();
    prenume.display();
    parola.display();
    parola2.display();
    email.display();
    //statut.display();
    modificare.display();
    scrollbarModif.display();
    intraM10=1;
}
