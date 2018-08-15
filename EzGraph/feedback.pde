void feedback() {
	int i;
	background(c7);
   	image(fundal1,0,0);
   	fill(-1);
    textSize(R*2);
    textAlign(CENTER,CENTER);
    text("FEEDBACK",0,height/8,width,R*3);
    textAlign(LEFT,CENTER);
    textSize(R*2/3);
    text("Da-ne o nota si lasa-ne o ideea de imbunatatire a aplicatiei EzGraphs! Pentru ca opinia ta conteaza!",R*3,height/4,width-R*6,R*3);
   	votSt.display();
    opinie.display();
    trimitereFeedback.display();
    veziFeedback.display();
    textSize(R*2/3);
    fill(-1);
    textAlign(CENTER,CENTER);
    if (trimis>0) {
      text("Feedback trimis!",veziFeedback.x+veziFeedback.w+R,veziFeedback.y,R*10,veziFeedback.h);
      trimis--;
    }
}