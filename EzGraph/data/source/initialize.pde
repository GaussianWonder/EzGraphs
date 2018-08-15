void initialize() {
	R=width/20;

	logo = loadImage("icon2-3-01.png");
	surface.setIcon(logo);

	questionActive=0;
	nQuestions=0;
	nQuestionsMax=10;

	delay=0;
	DELAY=7;

	start=new buton(width/2-R*2,height/2-R/2,R*4,R,"Incepe crearea testului");

	add_test();
	add_question("","","","",1);
	add_question("","","","",1);

	fundal2=loadImage("backgr5-01.png");
	if (fundal2.width*height/width>=height) //init
		fundal2.resize(width,fundal2.width*height/width);
	else 
		fundal2.resize(fundal2.height*width/height,height);

}
