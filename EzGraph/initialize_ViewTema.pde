void initialize_ViewTema() {
	int i;
	graf_ViewTema[] g=null;
	edge_ViewTema[] e=null;

	if(!stopTEMA)add_test_ViewTema("dataTema");

	R_ViewTema=width/20;

	questionActive_ViewTema=0;
	nQuestions_ViewTema=0;
	nQuestionsMax_ViewTema=5;
	nnGrafs_ViewTema=5;

	start_ViewTema=new buton2_ViewTema(width/2-R_ViewTema*2,height/2-R_ViewTema/2,R_ViewTema*4,R_ViewTema,"Incepe tema");
	nQuestions_ViewTema=5;
	if(!stopTEMA)add_question_ViewTema("Submit","","","",0,0,0,g,e,0,0,0,0,"");
	
	isToMove_ViewTema=-1;
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