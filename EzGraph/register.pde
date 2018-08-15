void register() {
    float sc=scrollbarInreg.decateori*scrollbarInreg.h4;// float sc=scrollbarInreg.y2-scrollbarInreg.y
	if (numeUtilizator.y!=height/8+R*4 || parola.y!=height/8+R*13) {
		numeUtilizator.y=height/8+R*4;
        parola.y=height/8+R*13;
		numeUtilizator.s=parola.s=parola2.s=email.s="";
        numeUtilizator.cursor=parola.cursor=parola2.cursor=email.cursor=0;
        parola.pass=parola2.pass=1;
        statut.selectat=-1;
        scrollbarInreg.y2=scrollbarInreg.y;
        updateTextboxes();
	}
    background(c7);
    image(fundal1,0,0);
    if (EROAREINREGISTRARE) {   //ERR
        //fill(256,0,0);
        fill(255,97,0);
        textSize(R);
        textAlign(LEFT,CENTER);
        text("Asigura-te ca ai completat toate campurile corect!\nEmailul/Numele de utilizator poate sunt deja folosite!"+
            "\nParola trebuie sa aiba cel putin 6 caractere!",width/7,email.y+email.h+R*6-sc,width,R*6);
    }
    fill(-1);
    textSize(R*2);
    textAlign(CENTER,CENTER);
    text("INREGISTRARE",0,height/8-sc,width,R*3);
    textSize(R);
    textAlign(LEFT,CENTER);
    text("Nume utilizator:",width/7,height/8+R*4-sc,width/5,R*2);
    text("Nume:",width/7,height/8+R*7-sc,width/5,R*2);
    text("Prenume:",width/7,height/8+R*10-sc,width/5,R*2);
    text("Parola:",width/7,height/8+R*13-sc,width/5,R*2);
    text("Parola confirmare:",width/7,height/8+R*16-sc,width/5,R*2);
    text("Email:",width/7,height/8+R*19-sc,width/5,R*2);
    text("Statut:",width/7,height/8+R*22-sc,width/5,R*2);
    numeUtilizator.display();
    nume.display();
    prenume.display();
    parola.display();
    parola2.display();
    email.display();
    inregistrare.display();
    statut.display();
    scrollbarInreg.display();
}