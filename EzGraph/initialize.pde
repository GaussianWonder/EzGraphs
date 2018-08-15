void initialize() {
  icon = loadImage("plin_mov_albastru2.png");
  logo=loadImage("full_logo_ez2.png");
  fundal1=loadImage("backgroundEzGr8-01.png");
  fundal2=loadImage("backgr5-01.png");
  backgr2=fundal2;
  if (backgr2.width*height/width/2>=height) backgr2.resize(width/2,backgr2.width*height/width*2);
  else backgr2.resize(backgr2.height*width/2/height,height);
  //icon.resize(16,16);
  surface.setIcon(icon);
  
  int i;
  
  R=min(width,height)/25;
  
  margLeft=width/2;
  margTop=R*5;
  
  nGrafs=0;
  nEdges=0;
  nBars=0;
  nLessons=0;
  
  speed=10;
  
  start=new buton2(width/2-R*6,height/2+R*4,R*12,R*4,"  Incepe procesul de invatare si exersare  ");

  float x=width-margLeft;
  x=x/6-2*R;
  x=x*2;
  move=new buton(width-x/2,2*R,R,"Move");
  deleteEdge=new buton(width-x/2*3,2*R,R,"Delete edge");
  deletePoint=new buton(width-x/2*5,2*R,R,"Delete point");
  addEdge=new buton(width-x/2*7,2*R,R,"Add edge");
  addPoint=new buton(width-x/2*9,2*R,R,"Add point");
  deleteGraf=new buton(width-x/2*11,2*R,R,"Delete graph");

  menuD = new menu(0,0,margLeft, height);
  menu = new menu(0,0,margLeft, height);
  menuOrientate = new menu(0, 0, margLeft, height);
  //menu2 = new ModuleSelector();
  menu2 = new DropDown(new PVector(0, 0), c6, 2*R, 0.2);
  
  numeUtilizator=new textbox(width/7+width/5,height/8+R*4,width/8*3,R*2,R,1,0);
  nume=new textbox(width/7+width/5,height/8+R*7,width/8*3,R*2,R,1,0);
  prenume=new textbox(width/7+width/5,height/8+R*10,width/8*3,R*2,R,1,0);
  parola=new textbox(width/7+width/5,height/8+R*13,width/8*3,R*2,R,1,1);
  parola2=new textbox(width/7+width/5,height/8+R*16,width/8*3,R*2,R,1,1);
  email=new textbox(width/7+width/5,height/8+R*19,width/8*3,R*2,R,1,0);
  //text(clsUsr + "",width/7 + width/5,height/8+R*19-sc,width/2,R*2);
  //clasa_name = new textbox(width/7 + width/5,height/8+R*22,width/8*3,R*2,R,1,0);
  //clasa_pass = new textbox(width/7 + width/5,height/8+R*25,width/8*3,R*2,R,1,0);
  clasa_name = new textbox(-width/8*4,height/8+R*22,width/8*3,R*2,R,1,0);
  clasa_pass = new textbox(-width/8*4,height/8+R*25,width/8*3,R*2,R,1,0);
  inapoiButon1=new inapoiButon(width+R,height/8+R*23.5,R*2,R*2);

  intraClasa=new buton2(width/7,height/8+R*22,width/7,R*2,"Intra intr-o clasa");
  conectareClasa=new buton2(width/7,height/8+R*25,width/7,R*2,"Conectare la o clasa");
  login=new buton2(width/2-R*3,height/5+R*7+R*4,R*6,parola.h,"Login");
  inregistrare=new buton2(width/4*3,parola.y+email.h+R*7+R*6,R*6,parola.h,"Register");
  modifCont=new buton2(width/7,height/8+R*28+3*R,R*6,parola.h,"Modificare date");
  note=new buton2(width/7+R*8,height/8+R*28+3*R,R*6,parola.h,"Note");
  //clasa = new buton2(width/7+R*16,height/8+R*28+3*R,R*6,parola.h,"Conectare clasa");
  //clasa2 = new buton2(clasa.x+clasa.w+R*2,height/8+R*28+3*R,R*6,parola.h,"Creare clasa");
  clasa = new buton2(width/7,height/8+R*22,R*6,parola.h,"Conectare clasa");
  clasa2 = new buton2(width/7,height/8+R*25,R*6,parola.h,"Creare clasa");
  modificare=new buton2(width/4*3,parola.y+email.h+R*7+R*6,R*6,parola.h,"Salveaza");

  scrollbarModif=new scrollbar2(width-R/2,R*2,R/2,height-R*2,2);
  scrollbarInreg=new scrollbar2(width-R/2,R*2,R/2,height-R*2,2);
  scrollbarCont=new scrollbar2(width-R/2,R*2,R/2,height-R*2,2);
  scrollbarNoteElevi=new scrollbar2(width-R/2,R*2,R/2,height-R*2,2);

  grafs=new graf[200];
  edges=new edge[200];

  float[] w=new float[2000];
  String[][] s=new String[2000][2000];
  String[] el=new String[2000];
  int[] nr=new int[2000];
  int nrc=0,nrl=0;
  String[] lin = new String[2000];

  /*s[0][0]="Mihaela";
  s[1][0]="Ion";
  s[2][0]="Teo";
  s[3][0]="Matei";
  s[4][0]="Pistruiatul";

  s[0][1]="7";
  s[1][1]="5";
  s[2][1]="8";
  s[3][1]="10";
  s[4][1]="9";*/

  nrc=2;
  w[1]=R*5; //  nrl=5;
  w[0]=width-R*11-R*2;
  w[1]=R*10;

  w[0]=width-R*6-R*2;
  w[1]=R*5;

  el[0]="Nume elev";
  el[1]="Nota test";

  nr[0]=0;
  nr[1]=1;

  //sunt variabile de test, in realitate sunt extrase din database
  noteElevi=new tabel(R*3/2,R*3,R*2,nrl,nrc,w,s,el,nr);
  for (i=0;i<nElevi;i++) {
    lin=new String[2000];
    lin[0]=elevi[i];
    lin[1]=noteEleviTest[i];
    addElementInTable(lin,noteElevi);
  }

  w=new float[2000];
  s=new String[2000][2000];
  el=new String[2000];
  nr=new int[2000];
  nrc=0;nrl=0;
  lin=new String[2000];

  nrc=2;

  w[0]=width-R*11-R*2;
  w[1]=R*10;

  el[0]="Nume elev";
  el[1]="Nota tema";

  nr[0]=0;
  nr[1]=1;

  //sunt variabile de test, in realitate sunt extrase din database
  noteElevi2=new tabel(R*3/2,R*3,R*2,nrl,nrc,w,s,el,nr);
  for (i=0;i<nElevi;i++) {
    lin=new String[2000];
    lin[0]=elevi[i];
    lin[1]=noteEleviTema[i];
    addElementInTable(lin,noteElevi2);
  }
  ///////////

  w=new float[30];
  s=new String[30][30];
  el=new String[30];
  nr=new int[30];
  nrc=0;nrl=0;
  lin=new String[30];

  nrc=2;

  w[0]=(width-R*11-R*2)/2;
  w[1]=R*5;

  el[0]="Tema";
  el[1]="Nota";

  nr[0]=0;
  nr[1]=1;

  //sunt variabile de test, in realitate sunt extrase din database
  noteElevTemaa=new tabel(R*3/2-R/2,R*6,R*2,nrl,nrc,w,s,el,nr);
  for (i=0;i<nrNoteTema;i++) {
    lin=new String[30];
    lin[0]=teme[i];
    lin[1]=str(noteTema[i]);
    addElementInTable(lin,noteElevTemaa);
  }

////////////

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

  //sunt variabile de test, in realitate sunt extrase din database
  noteElevTestt=new tabel(noteElevTemaa.x+noteElevTemaa.sum(nrc)+R/2,R*6,R*2,nrl,nrc,w,s,el,nr);
  for (i=0;i<nrNoteTest;i++) {
    lin=new String[30];
    lin[0]=teste[i];
    lin[1]=str(noteTest[i]);
    addElementInTable(lin,noteElevTestt);
  }

/////

  nClase=4;

  lin=new String[2000];
  w=new float[2000];
  s=new String[2000][2000];
  el=new String[2000];
  nr=new int[2000];
  /*for (i=0;i<nTeste;i++)
    s[i][0]=teste[i];*/
  el[0]="Teme";
  w[0]=width/2;
  nr[0]=0;
  nrc=1;
  nrl=0;

  //sunt variabile de test, in realitate sunt extrase din database
  temeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
  for (i=0;i<5;i++) {
    lin=new String[2000];
    lin[0]=teme[i];
    addElementInTable(lin,temeT);
  }
  ssTemeT=new sagetiSchimb(R*6,temeT.y+temeT.h*7,R,temeT);

  lin=new String[2000];
  w=new float[2000];
  s=new String[2000][2000];
  el=new String[2000];
  nr=new int[2000];
  /*for (i=0;i<nTeste;i++)
    s[i][0]=teste[i];*/
  el[0]="Teste";
  w[0]=width/2;
  nr[0]=0;
  nrc=1;
  nrl=0;

  //sunt variabile de test, in realitate sunt extrase din database
  testeT=new tabel(R*3/2,R*9,R*2,nrl,nrc,w,s,el,nr);
  for (i=0;i<5;i++) {
    lin=new String[2000];
    lin[0]=teste[i];
    addElementInTable(lin,testeT);
  }
  ssTesteT=new sagetiSchimb(R*6,testeT.y+testeT.h*7,R,testeT);

  statut=new list(width/7+width/5,height/8+R*22,width/5,R*2,R*2*4/6,"Statut");
  addElement("Profesor",statut);
  addElement("Elev",statut);

  alegeTema=new list(R*3/2,noteElevi2.y+noteElevi2.h*(noteElevi2.nrl+1)+R,R*8,R*2,R*3/2,"Alege tema");
  for (i=0;i<nTeme;i++)
    addElement(teme[i],alegeTema);

  alegeTest=new list(R*3/2,noteElevi.y+noteElevi.h*(noteElevi.nrl+1)+R,R*8,R*2,R*3/2,"Alege test");
  for (i=0;i<nTeste;i++)
    addElement(teste[i],alegeTest);

  alegeTemasauTest=new list(R*3/2,R*3,R*10,alegeTest.h,alegeTest.h2,"Vizualizare");
  addElement("Teste",alegeTemasauTest);
  addElement("Teme",alegeTemasauTest);

  adaugaTest=new buton2(alegeTemasauTest.x+alegeTemasauTest.w+R,alegeTemasauTest.y,alegeTemasauTest.w,alegeTemasauTest.h,"Creare Test");
  adaugaTema=new buton2(alegeTemasauTest.x+alegeTemasauTest.w+R,alegeTemasauTest.y,alegeTemasauTest.w,alegeTemasauTest.h,"Creare Tema");

  atribsivizTeme=new perecheButoane[100];
  atribsivizTeste=new perecheButoane[100];

  for (i=0;i<nTeme;i++) {
    atribsivizTeme[i]=new perecheButoane(temeT.x+temeT.sum(temeT.nrc)+R,temeT.y+temeT.h*(i%5+1)+i%5+1,
                          temeT.x+temeT.sum(temeT.nrc)+R+R*5+1,temeT.y+temeT.h*(i%5+1)+i%5+1,R*5,R*2,"Atribuire","Vizualizare",i);
    atribsivizTeme[i].atribuire=atribuireAnulareTeme[i];
  }
  for (i=0;i<nTeste;i++) {
    atribsivizTeste[i]=new perecheButoane(testeT.x+testeT.sum(testeT.nrc)+R,testeT.y+testeT.h*(i%5+1)+i%5+1,
                           testeT.x+testeT.sum(testeT.nrc)+R+R*5+1,testeT.y+testeT.h*(i%5+1)+i%5+1,R*5,R*2,"Atribuire","Vizualizare",i);
    atribsivizTeste[i].atribuire=atribuireAnulareTeste[i];
  }

  scrollbarNoteElev=new scrollbar2(width-R/2,R*2,R/2,height-R*2,3);//int(lungimeNoteElev()/4/R/3+1));
  scrollbarModif=new scrollbar2(width-R/2,R*2,R/2,height-R*2,2);
  scrollbarInreg=new scrollbar2(width-R/2,R*2,R/2,height-R*2,2);
  scrollbarCont=new scrollbar2(width-R/2,R*2,R/2,height-R*2,2);
  scrollbarNoteElevi=new scrollbar2(width-R/2,R*2,R/2,height-R*2,int(lungimeNoteElevi()/4/R/3+1));

  lectiiProf=new lectieProf[200];         //LECTII LECTIE
  for (i=0;i<nLectii;i++)
    if (i==0) lectiiProf[i]=new lectieProf(R*3,R*9,width-R*6,R*13,lectii[i],numeLectii[i],numeAutorLectii[i],noteLectiiVot[i],0);
    else lectiiProf[i]=new lectieProf(R*3,lectiiProf[i-1].y+lectiiProf[i-1].h+R*3,width-R*6,R*13,lectii[i],numeLectii[i],numeAutorLectii[i],noteLectiiVot[i],0);
  scrollbarLectii=new scrollbar2(width-R/2,R*2,R/2,height-R*2,int(lungimeLectii()/4/R/3+1));

  notePanou=new panouDr(width-R*7,R*6,R*7,R*7,"");
  butGrTeme=new butonGrafic(R*6,R*4,R*6,R*2,"Evolutie","Teme");
  butGrTeste=new butonGrafic(width/2+R*6,R*4,R*6,R*2,"Evolutie","Teste");
  votSt=new votStele(R*6,R*10,0);
  opinie=new textbox(R*3,R*12,width-R*9,R*9,R*2/3,0,0);
  trimitereFeedback=new buton2(R*3,R*22,R*6,R*2,"Trimite");
  comentarii=new comentariu[200];
  for (i=0;i<nComentarii;i++)
    if (i==0) comentarii[i]=new comentariu(R*3,R*6,width-R*6,R*17,com[i],numeCom[i],notaCom[i]);
    else comentarii[i]=new comentariu(R*3,comentarii[i-1].y+comentarii[i-1].h+R*3,width-R*6,R*17,com[i],numeCom[i],notaCom[i]);
  scrollbarComentarii=new scrollbar2(width-R/2,R*2,R/2,height-R*2,int(lungimeCom()/4/R/3+1));

  ex=new example(margLeft,height/3*2,width-margLeft,height/3);
  
  
  /**/int[] awa=new int[0];
  /**/String[] aw=new String[0];
  add_bar("1","Teoria grafurilor",txt("Teoria grafurilor"), menuD, n0Bars,aw,awa);n0Bars++;
  add_bar("2","Cuprins",txt("Cuprins"), menuD, n0Bars,aw,awa);n0Bars++;
  nrMenu=1;

  /**/String[] aw3={"Grad"};
  add_bar("1","Adiacenta. Incidenta. Grad",txt("Adiacenta. Incidenta. Grad"), menu, nBars,aw3,awa);nBars++;
  /**/String[] aw2={"Matrice de adiacenta","Lista de adiacenta","Vector de muchii"};
  add_bar("2","Reprezentare",txt("Reprezentare"), menu, nBars,aw2,awa);nBars++;
  /**/String[] aw8={"DF","BF"};
  /**/int[] aw8a={1,1};
  add_bar("3","Parcurgeri - DF si BF",txt("Parcurgeri - DF si BF"), menu, nBars,aw8,aw8a);nBars++;
  /**/String[] aw14={"Lant","Ciclu"};
  /**/int[] aw14a={1,1};
  add_bar("4","Lant. Ciclu",txt("Lant. Ciclu"), menu, nBars,aw14,aw14a);nBars++;
  /**/String[] aw7={"Componente conexe"};
  /**/int[] aw7a={1};
  add_bar("5","Conexitate",txt("Conexitate"), menu, nBars,aw7,aw7a);nBars++;
  /**/String[] aw6={"Bipartit"};
  add_bar("6","Graf bipartit",txt("Graf bipartit"), menu, nBars,aw6,awa);nBars++;
  /**/int[] aw10a={1};
  /**/String[] aw10={"Ciclu Hamiltonian"};
  add_bar("7","Graf hamiltonian",txt("Graf hamiltonian"), menu, nBars,aw10,aw10a);nBars++;
  /**/String[] aw9={"Ciclu Eulerian"};
  /**/int[] aw9a={1};
  add_bar("8","Graf eulerian",txt("Graf eulerian"), menu, nBars,aw9,aw9a);nBars++;
  add_bar("9","Arbori",txt("Arbori"), menu, nBars,aw,awa);nBars++;
  add_bar("10","Arbori cu radacina",txt("Arbori cu radacina"), menu, nBars,aw,awa);nBars++;
  /**/String[] aw5={"RSD","SRD","SDR","Adancime(inaltime) arbore binar"};
  add_bar("11","Arbori binari",txt("Arbori binari"), menu, nBars,aw5,awa);nBars++;
  add_bar("?","Cum folosesc butoanele",txt("Cum folosesc butoanele"), menu, nBars,aw,awa);nBars++;
  nrMenu=2;

  /**/String[] aw11={"Grad-or"};
  add_bar("1","Adiacenta. Incidenta. Grad interior si exterior",txt("Adiacenta. Incidenta. Grad interior si exterior"),menuOrientate,n2Bars,aw11,awa);n2Bars++;
  /**/String[] aw12={"Matrice de adiacenta-or","Lista de adiacenta-or","Matrice de incidenta","Vector de arce","Matricea drumurilor"};
  add_bar("2","Reprezentare-or",txt("Reprezentare-or"),menuOrientate,n2Bars,aw12,awa);n2Bars++;
  /**/String[] aw15={"Lant-or","Ciclu-or","Drum","Circuit"};
  /**/int[] aw15a={1,1,1,1};
  add_bar("3","Lant. Ciclu. Drum. Circuit",txt("Lant. Ciclu. Drum. Circuit"),menuOrientate,n2Bars,aw15,aw15a);n2Bars++; 
  /**/String[] aw13={"Componente conexe-or","Componente tare conexe"};
  /**/int[] aw13a={1};
  add_bar("4","Conexitate si tare conexitate",txt("Conexitate si tare conexitate"),menuOrientate,n2Bars,aw13,aw13a);n2Bars++;
  /**/String[] aw16={"Graf turneu"};
  add_bar("5","Graf turneu-or",txt("Graf turneu-or"),menuOrientate,n2Bars,aw16,awa);n2Bars++;
  add_bar("?","Cum folosesc butoanele-or",txt("Cum folosesc butoanele-or"),menuOrientate,n2Bars,aw,awa);n2Bars++;
  nrMenu = 3;
  
  hub = new gameHub(50, 100, width - 100, height - 150);
  veziFeedback=new buton2(trimitereFeedback.x+trimitereFeedback.w+R,R*22,R*14,R*2,"Vezi toate feedback-urile");
  updateTextboxes();
  
}

void updateTextboxes(){
  textboxes.clear();
  textboxes.add(numeUtilizator);
  textboxes.add(nume);
  textboxes.add(prenume);
  textboxes.add(parola);
  textboxes.add(parola2);
  textboxes.add(email);
  textboxes.add(clasa_pass);
  textboxes.add(clasa_name);
  textboxes.add(opinie);
}