//System.gc(); //GARBAGE COLLECTOR REQUEST
import de.bezier.data.sql.*;

void setup() {
  fullScreen();
  pixelDensity(displayDensity());
  thisPapplet = this;
  cursorImg=loadImage("cr14-01.png");
  cursor(cursorImg, mouseX, mouseY);
  frameRate(60);
  steaPlina=loadImage("steaPlina-01.png");
  steaNeplina=loadImage("steaNeplina-01.png");
  initialize();
  if (fundal2.width*height/width>=height) //init
    fundal2.resize(width,fundal2.width*height/width);
  else 
    fundal2.resize(fundal2.height*width/height,height);
  dbConnect();

  /*      Passes in order: 1 - 14
  StringList lst = new StringList();
  lst.append("Teodor00");
  lst.append("123123");
  lst.append("cata3151");
  lst.append("Krystelnyta");
  lst.append("parola");
  lst.append("ParolaPass");
  lst.append("kastelus");
  lst.append("biricel");
  lst.append("niGror21");
  lst.append("passcode123");
  lst.append("123123");
  lst.append("123123");
  lst.append("barBut");
  lst.append("Casa2009Teo");

  for(String s : lst)
    println("crypt("+s+"): "+crypt(s));
  */
}

void draw() {
  if (delay!=0)
    delay--;

  if (currentModule!=8)
    intraM8=0;
  else if (currentModule!=10)
    intraM10=0;

  if (START) {
    if(hub.gameSelected!=0) {  //GAMES
      if(!OKSETUP){
        setupGame();
        OKSETUP = true;
      }
      drawGame();
    }
    else{   //TOTUL CA INAINTE
      int mm=1;   //KT
      if (currentModule==1) {
        if (nrLess<menu.bars[lessonActive-1].anim.length && menu.bars[lessonActive-1].anim[nrLess]==1)
          mm=menu.bars[lessonActive-1].b2[nrLess].tip2;
      }
      else if (currentModule==2) {
        if (nrLess<menuOrientate.bars[lessonActive-1].anim.length && menuOrientate.bars[lessonActive-1].anim[nrLess]==1)
          mm=menuOrientate.bars[lessonActive-1].b2[nrLess].tip2;
      }
      else if (currentModule==4) {
        if (nrLess<menuD.bars[lessonActive-1].anim.length && menuD.bars[lessonActive-1].anim[nrLess]==1)
          mm=menuD.bars[lessonActive-1].b2[nrLess].tip2;
      }
      if (timerAlg>0)
        timerAlg--;
      else if (alg && !stopAlg && timerAlg==0 && mm==1) {
        if (currentModule==1 && (lessonActive==4 || lessonActive==7/* || lessonActive==8*/) || currentModule==2 && lessonActive==3) {
          if (nrLess<4) {
            if (nrLantCurent<=nrLanturi2) {
              atribuireLant();
              timerAlg=TIMER2;
            }
          }
        }
        else if (ramas<nt2) {
          ramas++;
          timerAlg=TIMER2;
          if (ordine[ramas-1]==1)
            ramasG++;
          else ramasE++;
        }
      }

      if (alg)
        if (mm==1) {
          if (currentModule==1 && (lessonActive==4 || lessonActive==7/* || lessonActive==8*/) || currentModule==2 && lessonActive==3) {
            if (nrLess<4)
              if (nrLantCurent==nrLanturi2+1) {
                init();
                alg=false;
                stopAlg=true;
              }
          }
          else if (ramas==nt2 && timerAlg==0) {
            init();
            alg=false;
            stopAlg=true;
          }
        }
        else {
          if (currentModule==1 && (lessonActive==4 || lessonActive==7/* || lessonActive==8*/) || currentModule==2 && lessonActive==3) {
            if (nrLess<4)
              if (nrLantCurent==nrLanturi2+1) {
                init();
                alg=false;
                stopAlg=true;
              }
          }/*
          else if (currentModule==1 && lessonActive==5) {
            init();
            alg=false;
            stopAlg=true;
          }*/
          else if (ramas==nt2+1) {
            init();
            alg=false;
            stopAlg=true;
          }
        }         //KT

      if(OKSETUP==true){
        System.gc();
        OKSETUP = false;

        ellipseMode(CENTER);
      }

      if(!updatedScore && !compareStrings(nmUsr, "")){
        updatedScore = true;
        if(db.connect())dbConnect();
        db.query("SELECT gameID, userID, score FROM gameScores WHERE gameID="+gameMaxScore+" AND userID="+IDUSER);
        if(db.next()){
          int tempScr = db.getInt("score");
          if(tempScr<MAXSCOREGAINED)
            db.execute("UPDATE gameScores SET score="+round(MAXSCOREGAINED)+" WHERE gameID="+gameMaxScore+" AND userID="+IDUSER);
        }
        else{
          db.execute("INSERT INTO gameScores VALUE ("+gameMaxScore+", "+IDUSER+", "+MAXSCOREGAINED+")");
        }
      }

      background(c3);
      
      if(currentModule==1 || currentModule==2 || currentModule==4) {
        ex.display();
        margLeft = width/2;
        fill(c3);
        rect(margLeft,0,width-margLeft,ex.y);
        image(fundal2,margLeft,0+ex.y-fundal2.height);
      }
      else margLeft=width;
      
      noStroke();
      fill(c3);
      fill(-1);
      //text(mouseX + " , " + mouseY, mouseX, mouseY);
      
      if (delay!=0)
        delay--;
      
      if(currentModule!=13)testSetup=false;
      if(currentModule!=14)temaSetup=false;
      switch(currentModule) {
        case 1: { //neorientate*
          or=false;
          if(lessonActive==-1)
            lessonActive=1;
          menu.display();
          break;
        }
        case 2: { //orientate*
          or=true;
          if  (lessonActive==-1)
            lessonActive=1;
          menuOrientate.display();
          break;
        }
        case 3: { //jocuri
          margLeft = width;
          hub.update();
          hub.display();
          break;
        }
        case 4: { //definitie*
          if  (lessonActive==-1)
            lessonActive=1;
          menuD.display();
          break;
        }
        case 5: { //login
          logare();
          margLeft=width;
          break;
        }
        case 6: { //register
          register();
          margLeft=width;
          break;
        }
        case 7: break; //bonus
        case 8: { //profilul tau
          cont();
          break;
        }
        case 9: { //note
          note();
          break;
        }
        case 10: { //modificare cont
          modifCont();
          break;
        }
        case 11:{//deconectare
          currentModule = 5;
          LOGGED = false;
          menu2.tabs[0].sub = new SubMenu[2];
          menu2.tabs[0].sub[0] = new SubMenu("Conectare", 5, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
          menu2.tabs[0].sub[1] = new SubMenu("Inregistrare", 6, menu2.tabs[0].seekPos, menu2.tabs[0].seekCol, menu2.tabs[0].seekSize, menu2.tabs[0].animSpd, menu2.tabs[0].seekW, 2*menu2.tabs[0].h/3);
          menu2.tabs[2].sub = new SubMenu[1];
          menu2.tabs[2].sub[0] = new SubMenu("Jocuri", 3, menu2.tabs[2].seekPos, menu2.tabs[2].seekCol, menu2.tabs[2].seekSize, menu2.tabs[2].animSpd, menu2.tabs[2].seekW, 2*menu2.tabs[2].h/3);
          db.close();
          nicknmUsr = ""; nmUsr = ""; surnmUsr = ""; emailUsr = ""; profUsr = ""; statutUsr = "";
          clsNM = "";
          clasa_name.s = "";
          updateTextboxes();
          break;
        }
        case 12:{//clasa mea
          myClass();
          break;
        }
        case 13:{ //test
          if(usrProf && keyPressed && (key=='b' || key=='B')) currentModule = 4;
          FORCEQUIT = false;
          if(!testSetup){
            testSetup = true;
            initialize_TestView();
            if(FORCEQUIT) break;
            if(stopTEST) break;
          }
          if(nume_test_TestView.equals("{eRRinDb}")){
            if(keyPressed && (key=='b' || key=='B'))
              currentModule = 4;
          }
          else{
             if(questions_TestView[nQuestionsMax_TestView].b.ok && keyPressed && (key=='b' || key=='B'))
              currentModule = 4;
          }
          if(stopTEST) break;
          noStroke();
          if (delay_TestView!=0)
              delay_TestView--;
          if (STARTTEST_TestView) {
            background(c3);
            display_all_questions_TestView();
          }
          else {
            background(c7);
            textSize(R_TestView);
            fill(-1);
            textAlign(CENTER,CENTER);
            text(nume_test_TestView,0,height/4,width,R_TestView*2);
            drawStart();
            start_TestView.display();
            if (start_TestView.ok)
              STARTTEST_TestView=true;
          }
          break;
        }
        case 14:{ //teme
          if(usrProf && keyPressed && (key=='b' || key=='B')) currentModule = 4;
          FORCEQUIT = false;
          if(!temaSetup){
            temaSetup = true;
            initialize_ViewTema();
            if(FORCEQUIT) break;
            if(stopTEMA) break;
          }
          if(nume_test_ViewTema.equals("{eRRinDb}")){
            stopTEMA = true;
            if(keyPressed && (key=='b' || key=='B'))
              currentModule = 4;
          }
          else{
             if(questions_ViewTema[nQuestionsMax_ViewTema].b.ok && keyPressed && (key=='b' || key=='B'))
              currentModule = 4;
          }
          if(stopTEMA) {
            currentModule = 4;
            break;
          }
          //=>>>>>>>>>>>>>>>>>>
          noStroke();
          if (STARTTEST_ViewTema) {
            background(c3);
            display_all_questions_ViewTema();
          }
          else {
            background(c7);
            textSize(R_ViewTema);
            fill(-1);
            textAlign(CENTER,CENTER);
            text(nume_test_ViewTema,0,height/4,width,R_ViewTema*2);
            drawStart();
            start_ViewTema.display();
            if (start_ViewTema.ok)
              STARTTEST_ViewTema=true;
            nQuestions_ViewTema=6;
            nQuestionsMax_ViewTema=5;
          }
          break;
        }
        case 15:{ //creare test
          if(!testLaunch){
            testLaunch = true;
            PrintWriter output;
            output = createWriter("execute.bat");
            output.println("cd " + sketchPath("data"));
            output.println("start CreareTest.exe");
            output.flush();
            output.close();

            launch(sketchPath("execute.bat"));
          }
          fill(230);
          textAlign(CENTER, CENTER);
          textSize(30);
          text("APLICATIA VA FI DESCHISA INTR-O FEREASTRA NOUA\nVERIFICA CU (ALT+TAB)", width/2, height/2);
          break;
        }
        case 16:{ //creare tema
          if(!temaLaunch){
            temaLaunch = true;
            PrintWriter output;
            output = createWriter("execute.bat");
            output.println("cd " + sketchPath("data2"));
            output.println("start CreareTema.exe");
            output.flush();
            output.close();

            launch(sketchPath("execute.bat"));
          }
          fill(230);
          textAlign(CENTER, CENTER);
          textSize(30);
          text("APLICATIA VA FI DESCHISA INTR-O FEREASTRA NOUA\nVERIFICA CU (ALT+TAB)", width/2, height/2);
          break;
        }
        case 17:{ //history elev
          break;
        }
        case 18:{ //vizualizare teme
          break;
        }
        case 19:{ //game ranking
          if(rankingScore==null) rankingScore = new GameRanking(new PVector(0, 0), c6, 2*R, 0.2);
          rankingScore.update();
          rankingScore.display();
          break;
        }
        case 20:{ //note elevi dintr-o clasa
          noteEleviClasa();
          break;
        }
        case 21:{ //vizualizare + adaugare + atribuire test/tema
          temaTest();
          break;
        }
        case 22:{
          note2();
          break;
        }
        case 23: { //grafic note teme
          note3();
          break;
        }
        case 24: { //feedback
          feedback();
          break;
        }
        case 25: { //toate comentariile
          afisComentarii();
          break;
        }
        case 26: { //toate lectiile prof
          if(!getData26){
            getData26 = true;
            getLectii();
          }

          afisLectii();
          break;
        }
        case 27: { //o lectie prof
          afisLectie();
          break;
        }
        case 29: {
          if(!lectieLaunch){
            lectieLaunch = true;
            PrintWriter output;
            output = createWriter("execute.bat");
            output.println("cd " + sketchPath("data3"));
            output.println("start AdaugareLectie.exe");
            output.flush();
            output.close();

            launch(sketchPath("execute.bat"));
          }
          fill(230);
          textAlign(CENTER, CENTER);
          textSize(30);
          text("APLICATIA VA FI DESCHISA INTR-O FEREASTRA NOUA\nVERIFICA CU (ALT+TAB)", width/2, height/2);
          break;
        }
      }

      if(currentModule!=13 && currentModule!=14){
        menu2.show();
        sentData = false;
      }
      if(currentModule!=13){
        testSetup=false;
        stopTEST = false;
        STARTTEST_TestView = false;
      }
      if(currentModule!=14){
        temaSetup=false;
        stopTEMA=false;
        STARTTEST_ViewTema = false;
      }
      if(currentModule!=22)
        getData22 = false;
      if(currentModule!=23)
        getData23 = false;
      if(currentModule!=9)
        getData09 = false;
      if(currentModule!=20)
        getData20 = false;
      if(currentModule!=21)
        getData21 = false;
      if(currentModule!=26){
        getData26 = false;
      }
      if(currentModule!=15){
        testLaunch = false;
      }
      if(currentModule!=16){
        temaLaunch = false;
      }
      if(currentModule!=29){
        lectieLaunch = false;
      }

      if (currentModule==1 || currentModule==2 || currentModule==4) {
        if (mousePressed && delay==0 && butonActive=="Add point" && nGrafs<200 && isBetween(margLeft+R,width,mouseX) && isBetween(margTop+R,ex.y-R,mouseY))
          add_graf(mouseX, mouseY);

        if (lines) {
          float i,j;
          fill(256,0,0);
          strokeWeight(1);
          stroke(0,256,0);
          for (i=0;i<4;i++) {
            for (j=margLeft;j<width;j+=10)
              line(j,margTop+R+i*90,j+5,margTop+R+i*90);
            fill(0,256,0);
            textSize(R/2);
            text("Niv "+(int)i,width-R,margTop+R/2+i*90);
          }
        }
        else if (lines2) {
          float i,j;
          strokeWeight(1);
          stroke(0,256,0);
          for (i=margTop;i<ex.y-10;i+=10)
            line(width-(width/2-margLeft/2),i,width-(width/2-margLeft/2),i+5);
        }
        display_all_edges();
        display_all_grafs();
        display_all_butons();
        noStroke();
        scroll();
      }
    }
  }
  else {
    background(20, 0, 81);
    drawStart();
    fill(-1);
    textSize(R*2);
    textAlign(CENTER,CENTER);
    //text("EzGraphs",0,height/6,width,R*5);
    start.display();
    image(logo,width/2-700/2,R*3/2,700,700*2035/3249);
  }
  //lista1.display();
  
  if(error == true && millis() - ERRtime <= 8000){
    textSize(50);
    text("PROBLEME TEHNICE, INCERCATI MAI TARZIU \n DATABASE IS NOT WORKING", width/2, 3*height/4);
  }
}

void mouseClicked(MouseEvent evt){
  if (evt.getCount() == 2)doubleClicked();
  if(hub.gameSelected==3){
    mouseClickedHex();
  } 
}

void doubleClicked(){
  if(mouseX>width/2){
    margLeft=width;
  }
}

void keyReleased(){
  if(hub.gameSelected==4){
    if(key!='R' && key!='r')
      movePlayers();
  }
  if( (key=='E' || key=='e') && (hub.gameSelected==1 || hub.gameSelected==2 || hub.gameSelected==6) ){
    hub.gameSelected=0;
  }

  if(keyCode==UP){
    if(UP_ARR)UP_ARR=false;
  }
  else if(keyCode==DOWN){
    if(DOWN_ARR)DOWN_ARR=false;
  }
  else if(keyCode==RIGHT){
    if(RIGHT_ARR)RIGHT_ARR=false;
  }
  else if(keyCode==LEFT){
    if(LEFT_ARR)LEFT_ARR=false;
  }
  UP_ARR = false;DOWN_ARR = false;LEFT_ARR = false;RIGHT_ARR = false;
}

void mouseDragged() {
  if(grafLectie!=null)grafLectie.mouseDrag();
  if(hub.gameSelected==5){
    int i,j;
    for (i=0;i<nmax;i++)
      for (j=0;j<mmax;j++)
        if (dist(hexagons[i][j].x,hexagons[i][j].y,mouseX,mouseY)<=R && use[i][j]==0 && (omax==0 || (isNeighbourHC(hexagons[i][j],hexagons[orderx[omax-1]][ordery[omax-1]])==1)
         && hexagons[i][j].c==hexagons[orderx[omax-1]][ordery[omax-1]].c) && hexagons[i][j].ok==1) {
          orderx[omax]=i;
          ordery[omax]=j;
          omax++;
          use[i][j]=1;
          break;
        }
  }
  if(hub.gameSelected==1 || hub.gameSelected==2 || hub.gameSelected==6){
    if(mouseButton==LEFT && nodes!=null){
      for(Node n : nodes){
        if(n.isHovered(mouseX, mouseY)){
          if(indexCurr==-1) indexCurr = n.index;
          else{
            if(validMuchieGR(n.index, indexCurr) && !muchiiGr.exists(n.index, indexCurr)){
              indexPrev = indexCurr;
              indexCurr = n.index;
            }
          }
        }
      }

      if(indexPrev!=-1 && !muchiiGr.exists(indexPrev, indexCurr) && validMuchieGR(indexPrev, indexCurr)){
        nodes.get(indexPrev).toggle = true;
        nodes.get(indexCurr).toggle = true;

        muchiiGr.add(indexPrev, indexCurr);
      }
    }
    else if(mouseButton==RIGHT && nodes!=null){
      for(Node n : nodes){
        if(n.isHovered(mouseX, mouseY)){
          n.seekPosition(new PVector(mouseX, mouseY));
          n.basePos = new PVector(mouseX, mouseY);
          break;
        }
      }
    }
  }
}

void drawGame(){
  if(hub.gameSelected==1 || hub.gameSelected==2 || hub.gameSelected==6){
    drawGPath();
    gameMaxScore = hub.gameSelected;
  }
  if(hub.gameSelected==3){
    drawHex();
    int scr = round(CORRECT*2 + FLAG*5 - HINT*7 - WRONG*10);
    if(MAXSCOREGAINED<scr){
      MAXSCOREGAINED = scr;
      gameMaxScore = hub.gameSelected;
    }
  }
  if(hub.gameSelected==4){
    drawFillTheLand();
    int scr = round(MOVES * playerCount);
    if(MAXSCOREGAINED<scr){
      MAXSCOREGAINED = scr;
      gameMaxScore = hub.gameSelected;
    }
  }
  if(hub.gameSelected==5){
    //score1,score2,score3
    int scr = (score1 * score2 * score3) / 3;
    if(MAXSCOREGAINED<scr){
      MAXSCOREGAINED = scr;
      gameMaxScore = hub.gameSelected;
    }
    drawHexCollector();
  }
}

void setupGame(){
  System.gc();
  updatedScore = false;
  MAXSCOREGAINED = -9999;
  if(hub.gameSelected==1 || hub.gameSelected==2 || hub.gameSelected==6){
    if(hub.gameSelected==6)tabSelected=0;
    else tabSelected = hub.gameSelected;

    setupGPath();
  }
  if(hub.gameSelected==3)setupHex();
  if(hub.gameSelected==4)setupFillTheLand();
  if(hub.gameSelected==5)setupHexCollector();
}

void showGameInfo(float x, float y, int i){
  if(menu2.mainTabHovered())return;
  
  fill(c2);
  if(x>width/2){
    rect(x - width/2, y, width/2, height/2);
    fill(42, 42, 42);
    if(i==1)
      text("Scopul jocului este de a parcurge un drum Eulerian\npentru graful respectiv\n\nCOMENZI\nTinand apasat click dreapta muti nodurile\nTinand apasat click stanga poti parcurge graful\nApasand E se iese din joc\nOdata ce ai dat drumul mouse-ului jocul revine la inceput\nApasand pe butonul de scroll se genereaza un nou graf",x - width/2 + width/4, y + height/4);
    if(i==2)
      text("Scopul jocului este de a parcurge un drum Hamiltonian\npentru graful respectiv\n\nCOMENZI\nTinand apasat click dreapta muti nodurile\nTinand apasat click stanga poti parcurge graful\nApasand E se iese din joc\nOdata ce ai dat drumul mouse-ului jocul revine la inceput\nApasand pe butonul de scroll se genereaza un nou graf",x - width/2 + width/4, y + height/4);
    if(i==3)
      text("HexSweeper seamana cu minesweeper-ul original\nScopul este sa acoperi toate minele cu steaguri\n\nCOMENZI\nQ->Afiseaza vecinii fara steag ai unei celule active\nH->Afieaza celula inactiva\n(daca este bomba pierzi mai putine puncte)\nS->Afiseaza scorul\nClick dreapta->Pune steag\nClick stanga->Afiseaza celula\nClick buton scroll->Nivel nou\nE->Iesire joc",x - width/2 + width/4, y + height/4);
    if(i==4)
      text("Scopul jocului este de a acoperi tot terenul\nfolosind culorile patratelor\nToate se misca in acelasi timp folosind sagetile\n\nCOMENZI\nR->Reseteaza nivelul\nClick buton scroll->Nivel nou\nE->Iesire joc",x - width/2 + width/4, y + height/4);
    if(i==5)
      text("Scopul jocului este sa colectezi cat mai multe hexagoane\nOdata ce ai terminat un camp intreg, altul va fi generat\nPentru a colecta hexagoane trebuie sa unesti cel putin 3\n\nCOMENZI\nR->Restart\nE->Iesire Joc",x - width/2 + width/4, y + height/4);
    if(i==6)
      text("Scopul jocului este sa iti antreneze memoria vizuala si atentia\nEste simplu, gaseste toate lanturile dintre\nnodurile afisate (stanga sus)\nScrie raspunsul si apasa ENTER\n\nCOMENZI\nClick Dreapta->Muta nodurile\n(vezi Euler / Hamilton)",x - width/2 + width/4, y + height/4);      

  }
  else{
    rect(x, y, width/2, height/2);
    fill(42, 42, 42);
    if(i==1)
      text("Scopul jocului este de a parcurge un drum Eulerian\npentru graful respectiv\n\nCOMENZI\nTinand apasat click dreapta muti nodurile\nTinand apasat click stanga poti parcurge graful\nApasand E se iese din joc\nOdata ce ai dat drumul mouse-ului jocul revine la inceput\nApasand pe butonul de scroll se genereaza un nou graf",x + width/4, y + height/4);
    if(i==2)
      text("Scopul jocului este de a parcurge un drum Hamiltonian\npentru graful respectiv\n\nCOMENZI\nTinand apasat click dreapta muti nodurile\nTinand apasat click stanga poti parcurge graful\nApasand E se iese din joc\nOdata ce ai dat drumul mouse-ului jocul revine la inceput\nApasand pe butonul de scroll se genereaza un nou graf",x + width/4, y + height/4);
    if(i==3)
      text("HexSweeper seamana cu minesweeper-ul original\nScopul este sa acoperi toate minele cu steaguri\n\nCOMENZI\nQ->Afiseaza vecinii fara steag ai unei celule active\nH->Afieaza celula inactiva\n(daca este bomba pierzi mai putine puncte)\nS->Afiseaza scorul\nClick dreapta->Pune steag\nClick stanga->Afiseaza celula\nClick buton scroll->Nivel nou\nE->Iesire joc",x + width/4, y + height/4);
    if(i==4)
      text("Scopul jocului este de a acoperi tot terenul\nfolosind oricare din culorile patratelor\nToate se misca in acelasi timp folosind sagetile\n\nCOMENZI\nR->Reseteaza nivelul\nClick buton scroll->Nivel nou\nE->Iesire joc",x + width/4, y + height/4);
    if(i==5)
      text("Scopul jocului este sa spargi toate hexagoanele\nSpargerea hexagoanelor se realizeaza trasand cu mouse-ul\nun lant peste hexagoanele de aceeasi culoare\nce au o muchie in comun\n\nCOMENZI\nR->Restart\nE->Iesire Joc",x + width/4, y + height/4);
    if(i==6)
      text("Scopul jocului este sa iti antreneze memoria vizuala si atentia\nEste simplu, gaseste toate lanturile dintre\nnodurile afisate (stanga sus)\nScrie raspunsul si apasa ENTER\n\nCOMENZI\nClick Dreapta->Muta nodurile\n(vezi Euler / Hamilton)",x + width/4, y + height/4);      
  }

}