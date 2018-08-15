void initialize() {
	int i;
	float x;
	logo = loadImage("icon2_1-01.png");
	surface.setIcon(logo);

	graf[] g=new graf[200];
	edge[] e=new edge[200];

	//add_test("tema1");

	R=width/20;

	add_question("1","","","",0,0,0,g,e,0,0,0);
	graf[] g1=new graf[200];
	edge[] e1=new edge[200];
	add_question("2","","","",0,0,0,g1,e1,0,0,0);
	graf[] g2=new graf[200];
	edge[] e2=new edge[200];
	add_question("3","","","",0,0,0,g2,e2,0,0,0);
	graf[] g3=new graf[200];
	edge[] e3=new edge[200];
	add_question("4","","","",0,0,0,g3,e3,0,0,0);
	graf[] g4=new graf[200];
	edge[] e4=new edge[200];
	add_question("5","","","",0,0,0,g4,e4,0,0,0);
	graf[] g5=new graf[200];
	edge[] e5=new edge[200];
	add_question("Nume tema","","","",0,0,0,g5,e5,0,0,0);
	graf[] g6=new graf[200];
	edge[] e6=new edge[200];
	add_question("Submit","","","",0,0,0,g6,e6,0,0,0);

	questionActive=0;
	nQuestions=0;
	nQuestionsMax=6;
	nnGrafs=5;

	start=new buton2(width/2-R*2,height/2-R/2,R*4,R,"Incepe crearea temei");
	nQuestions=5;
	
	isToMove=-1;


	margLeft=width/2;
    margTop=R*5;
    x=width-margLeft;
	x=x/6-2*R;
  	x=x*2;
    move=new buton(width/2+R,3*R,R/2,"Move");
    deleteEdge=new buton(width/2+R*3/2+R,3*R,R/2,"Delete edge");
    deletePoint=new buton(width/2+R*2*3/2+R,3*R,R/2,"Delete point");
    addEdge=new buton(width/2+R*3*3/2+R,3*R,R/2,"Add edge");
    addPoint=new buton(width/2+R*4*3/2+R,3*R,R/2,"Add point");
    deleteGraf=new buton(width/2+R*5*3/2+R,3*R,R/2,"Delete graph");

    fundal2=loadImage("backgr5-01.png");
    if (fundal2.width*height/width>=height)
		fundal2.resize(width,fundal2.width*height/width);
	else 
		fundal2.resize(fundal2.height*width/height,height);
}

/*

tip1:
1. Cu graf
2. Deseneaza graf
3. Fara graf

tip2:
1. Cu textbox
2. Doar desenare (pentru 2)
3. Cu variante a,b,c

numar intrebari

tip1
intrebare
tip2
tip2==1: varianta raspuns
tip2==2: nimic
tip2==3: var1,var2,var3,varianta corecta

*/