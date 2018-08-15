void note2() {
	if(!getData22){
		getData22 = true;
		float[] w=new float[30];
		String[][] s=new String[30][30];
		String[] el=new String[30];
		int[] nr=new int[30];
		int nrc=0,nrl=0, i;
		String[] lin=new String[30];
		getTestElev(IDUSER);
		getTemaElev(IDUSER);
		nrc=2;
		w[0]=(width-R*11-R*2)/2;
		w[1]=R*5;
		el[0]="Tema";
		el[1]="Nota";
		nr[0]=0;
		nr[1]=1;
		nrNoteTema = noteTema.length;
		nrNoteTest = noteTest.length;
		noteElevTemaa = new tabel(R*3/2-R/2,R*6,R*2,nrl,nrc,w,s,el,nr);
		for (i=0;i<nrNoteTema;i++) {
			lin=new String[30];
			lin[0]=teme[i];
			lin[1]=str(noteTema[i]);
			addElementInTable(lin,noteElevTemaa);
		}
		w=new float[30];
		s=new String[30][30];
		el=new String[30];
		nr=new int[30];
		nrc=0;nrl=0;
		lin=new String[30];
		nrc=2;
		w[0]=(width-R*11-R*2)/2;
		w[1]=R*5;
		el[0]="Test";
		el[1]="Nota";
		nr[0]=0;
		nr[1]=1;
		noteElevTestt = new tabel(noteElevTemaa.x+noteElevTemaa.sum(nrc)+R/2,R*6,R*2,nrl,nrc,w,s,el,nr);
		for (i=0;i<nrNoteTest;i++) {
			lin=new String[30];
		    lin[0]=teste[i];
		    lin[1]=str(noteTest[i]);
		    addElementInTable(lin,noteElevTestt);
		}

	}
   	background(c7);
   	image(fundal1,0,0);
	noteElevTemaa.display();
	noteElevTestt.display();
	butGrTeme.display();
	butGrTeste.display();
	scrollbarNoteElev.display();
}

float lungimeNoteElev() {
    print(max(noteElevTemaa.y+noteElevTemaa.h*(nrNoteTema+1),noteElevTestt.y+noteElevTestt.h*(nrNoteTest+1)));
    return max(noteElevTemaa.y+noteElevTemaa.h*(nrNoteTema+1),noteElevTestt.y+noteElevTestt.h*(nrNoteTest+1));
}