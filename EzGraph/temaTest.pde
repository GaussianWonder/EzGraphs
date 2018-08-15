//Module 21 =======>
void temaTest() {
	if(!getData21){
		getData21 = true;
		float[] w=new float[30];
		  String[][] s=new String[30][30];
		  String[] el=new String[30];
		  int[] nr=new int[30];
		  int nrc=0,nrl=0;
		  String[] lin=new String[30];
		lin=new String[30];				//TEME NAME
		w=new float[30];
		s=new String[30][30];
		el=new String[30];
		nr=new int[30];
		el[0]="Teme";
		w[0]=width/2;
		nr[0]=0;
		nrc=1;
		nrl=0;
		teme = getTemeCreatedByProfId(IDUSER);
		nTeme = teme.length;
		temeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
		for (int i=0;i<min(5,nTeme);i++) {
		    lin=new String[30];
		    lin[0]=teme[i];
		    addElementInTable(lin,temeT);
		}
		ssTemeT=new sagetiSchimb(R*6,temeT.y+temeT.h*7,R,temeT);

		lin=new String[30];
		  w=new float[30];
		  s=new String[30][30];
		  el=new String[30];
		  nr=new int[30];
		  el[0]="Teste";
		  w[0]=width/2;
		  nr[0]=0;
		  nrc=1;
		  nrl=0;

		  teste = getTestsCreatedByProfId(IDUSER);
		  nTeste = teste.length;
		  testeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
		  for (int i=0;i<min(5,nTeste);i++) {
		    lin=new String[30];
		    lin[0]=teste[i];
		    addElementInTable(lin,testeT);
		  }
		  ssTesteT=new sagetiSchimb(R*6,testeT.y+testeT.h*7,R,testeT);

		  atribsivizTeme=new perecheButoane[nTeme];
		  atribsivizTeste=new perecheButoane[nTeste];

		  updateAtribuireVizualizareByProfId(IDUSER, clsUsr);

		  for (int i=0;i<nTeme;i++) {
		    atribsivizTeme[i]=new perecheButoane(temeT.x+temeT.sum(temeT.nrc)+R,temeT.y+temeT.h*(i%5+1)+i%5+1,
		                          temeT.x+temeT.sum(temeT.nrc)+R+R*5+1,temeT.y+temeT.h*(i%5+1)+i%5+1,R*5,R*2,"Atribuire","Vizualizare",i);
		    atribsivizTeme[i].atribuire=atribuireAnulareTeme[i];
		  }
		  for (int i=0;i<nTeste;i++) {
		    atribsivizTeste[i]=new perecheButoane(testeT.x+testeT.sum(testeT.nrc)+R,testeT.y+testeT.h*(i%5+1)+i%5+1,
		                           testeT.x+testeT.sum(testeT.nrc)+R+R*5+1,testeT.y+testeT.h*(i%5+1)+i%5+1,R*5,R*2,"Atribuire","Vizualizare",i);
		    atribsivizTeste[i].atribuire=atribuireAnulareTeste[i];
		  }
	}
	int i;
	background(c7);
	image(fundal1,0,0);
	if (alegeTemasauTest.selectat==0) {			//Test
		adaugaTest.display();
		testeT.display();		//tabel
		for (i=testeT.ramasC;i<min(nTeste,testeT.ramasC+5);i++)
			atribsivizTeste[i].display();
		ssTesteT.display();		//sageti
	}
	else if (alegeTemasauTest.selectat==1) {	//Tema
		adaugaTema.display();
		temeT.display();
		for (i=temeT.ramasC;i<min(nTeme,temeT.ramasC+5);i++)
			atribsivizTeme[i].display();
		ssTemeT.display();
	}
	alegeTemasauTest.display();
}