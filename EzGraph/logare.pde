void logare() {
    if (numeUtilizator.y!=height/5+R*4 || parola.y!=height/5+R*7) {
        numeUtilizator=new textbox(width/7+width/5,height/5+R*4,width/8*3,R*2,R,1,0);
        parola=new textbox(width/7+width/5,height/5+R*7,width/8*3,R*2,R,1,1);
        CONTACTIV=numeUtilizator.s;
        numeUtilizator.s=parola.s="";
        parola.pass=1;
        numeUtilizator.cursor=parola.cursor=0;
        EROARELOGARE=false;
        updateTextboxes();
    }
    background(c7);
    image(fundal1,0,0);
    if (EROARELOGARE) {
        //fill(256,0,0);
        fill(255,97,0);
        textSize(R);
        textAlign(LEFT,CENTER);
        text("Asigura-te ca ai completat toate campurile corect!",width/7,login.y+login.h+R,width,R*2);
    }
    fill(-1);
    textSize(R*2);
    textAlign(CENTER,CENTER);
    text("Logare",0,height/7,width,R*3);
    textSize(R);
    textAlign(LEFT,CENTER);
    text("Nume / Email:",width/7,height/5+R*4,width/5,R*2);
    text("Parola:",width/7,height/5+R*7,width/5,R*2);
    numeUtilizator.display();
    parola.display();
    login.display();
}