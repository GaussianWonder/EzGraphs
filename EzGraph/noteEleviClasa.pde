void noteEleviClasa() {
    if(!getData20){
        getData20 = true;
        alegeTema=new list(R*3/2,noteElevi2.y+noteElevi2.h*(noteElevi2.nrl+1)+R,R*8,R*2,R*3/2,"Alege tema");
        teme = getTemeCreatedByProfId(IDUSER);
        nTeme = teme.length;
        for (int i=0;i<nTeme;i++)
            addElement(teme[i], alegeTema);

        alegeTest=new list(R*3/2,noteElevi.y+noteElevi.h*(noteElevi.nrl+1)+R,R*8,R*2,R*3/2,"Alege test");
        teste = getTestsCreatedByProfId(IDUSER);
        nTeste = teste.length;
        for (int i=0;i<nTeste;i++)
                addElement(teste[i], alegeTest);
    }

	background(c7);
    image(fundal1,0,0);
    scrollbarNoteElevi.display();
    alegeTest.y=alegeTemasauTest.y;
    alegeTema.y=alegeTemasauTest.y;
    alegeTema.x=alegeTest.x=alegeTemasauTest.x+alegeTemasauTest.w+R;

    if (alegeTemasauTest.selectat==0) {
    	alegeTest.display();
    	if (alegeTest.selectat>=0) {
    		alegeTemasauTest.y=noteElevi.y+noteElevi.h*(noteElevi.nrl+1)+R;
    		noteElevi.el[1]="Nota "+alegeTest.elemente[alegeTest.selectat];
    		noteElevi.display();

    	}
    	else
    		alegeTemasauTest.y=R*3;
    }
    else if (alegeTemasauTest.selectat==1) {
    	alegeTema.display();
    	if (alegeTema.selectat>=0) {
    		alegeTemasauTest.y=noteElevi2.y+noteElevi2.h*(noteElevi2.nrl+1)+R;
    		noteElevi2.el[1]="Nota "+alegeTema.elemente[alegeTema.selectat];
    		noteElevi2.display();
    	}
    	else
    		alegeTemasauTest.y=R*3;
    }
    alegeTemasauTest.display();
}


float lungimeNoteElevi() {
    return noteElevi.y+noteElevi.h*(nElevi+1)+R+alegeTest.h*(max(nTeste,nTeme)+1);
}