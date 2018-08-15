class scrollbar {
  float x,y,w,h,nrlines,y2,h2=0,scrolled=0,linesScrolled=0;
  color c1=c6,c2=c8,c2_o=c8_o;
  int number;
  
  scrollbar(float xx,float yy,float ww,float hh,int numberr) {
    x=xx;
    y=yy;
    y2=y;
    w=ww;
    h=hh;
    number=numberr;
  }
  
  void display() {
    noStroke();
    fill(c1);
    rect(x,y,w,h);
    
    if (isBetween(x,x+w,mouseX) && isBetween(y2+scrolled,y2+scrolled+h2,mouseY)) {
      fill(c2_o);
      if (mousePressed)
        isToScroll=number;
    }
    else fill(c2);
    rect(x,y2+scrolled,w,h2);
    fill(256,0,0);
  }
}

void scroll() {
  int i;
  if (isToScroll!=-1) {
    if (isToScroll==2) {
      if (ex.scrollbar.nrlines>ex.scrollbar.linesScrolled && isBetween(ex.scrollbar.y2+ex.scrollbar.scrolled+ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,ex.scrollbar.y2+
      ex.scrollbar.scrolled+ex.scrollbar.h2+ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,mouseY)) {
        ex.scrollbar.scrolled+=(ex.scrollbar.scrolled/ex.scrollbar.linesScrolled);
        ex.scrollbar.linesScrolled++;
        ex.scrolled-=vit;
      }
      else
        if (0<ex.scrollbar.linesScrolled && isBetween(ex.scrollbar.y2+ex.scrollbar.scrolled-ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,ex.scrollbar.y2+ex.scrollbar.scrolled+
        ex.scrollbar.h2-ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,mouseY)) {
          ex.scrollbar.scrolled-=(ex.scrollbar.scrolled/ex.scrollbar.linesScrolled);
          ex.scrollbar.linesScrolled--;
          ex.scrolled+=vit;
        }
    }
    else if (isToScroll==1) {
      int w=0;
      if (currentModule==1) w=nBars;
      else if (currentModule==2) w=n2Bars;
      else if (currentModule==4) w=n0Bars;
      for (i=0;i<w;i++) {
        lesson ex=menu.bars[0].lesson;
        if (currentModule==1) ex=menu.bars[i].lesson;
        else if (currentModule==2) ex=menuOrientate.bars[i].lesson;
        else if (currentModule==4) ex=menuD.bars[i].lesson;
        if (ex.scrollbar.nrlines>ex.scrollbar.linesScrolled && isBetween(ex.scrollbar.y2+ex.scrollbar.scrolled+ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,ex.scrollbar.y2+
          ex.scrollbar.scrolled+ex.scrollbar.h2+ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,mouseY)) {
          ex.scrollbar.scrolled+=(ex.scrollbar.scrolled/ex.scrollbar.linesScrolled);
          ex.scrollbar.linesScrolled++;
          ex.scrolled-=vit;
        }
        else
          if (0<ex.scrollbar.linesScrolled && isBetween(ex.scrollbar.y2+ex.scrollbar.scrolled-ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,ex.scrollbar.y2+ex.scrollbar.scrolled+
          ex.scrollbar.h2-ex.scrollbar.scrolled/ex.scrollbar.linesScrolled,mouseY)) {
            ex.scrollbar.scrolled-=(ex.scrollbar.scrolled/ex.scrollbar.linesScrolled);
            ex.scrollbar.linesScrolled--;
            ex.scrolled+=vit;
          }
      }
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  if(membriiClasa!=null && currentModule==12){
    membriiClasa.scroolOffset+=e;
    if(e==1 && (membriiClasa.membersOnScreen() - 1 ) * 2.5 * R < membriiClasa.scroolOffset * R)
      membriiClasa.scroolOffset-=e;
  }
  if(rankingScore!=null && rankingScore.rankScores!=null && currentModule==19){
    rankingScore.scroolOffset+=e;
    if(e==1 && (rankingScore.rankScores.membersOnScreen() - 1 ) * 2.5 * R < rankingScore.scroolOffset * R)
      rankingScore.scroolOffset-=e;
  }

  if (currentModule==10) {
    if (isBetween(scrollbarModif.y,scrollbarModif.y+scrollbarModif.h-scrollbarModif.h2,scrollbarModif.y2+e*scrollbarModif.h3)) {
      scrollbarModif.y2+=e*scrollbarModif.h3;
      scrollbarModif.decateori+=e;
      //scrollbarModif.y3+=e*scrollbarModif.y2;
    }
  }
  else if (currentModule==6) {
    if (isBetween(scrollbarInreg.y,scrollbarInreg.y+scrollbarInreg.h-scrollbarInreg.h2,scrollbarInreg.y2+e*scrollbarInreg.h3)) {
      scrollbarInreg.y2+=e*scrollbarInreg.h3;
      scrollbarInreg.decateori+=e;
      //scrollbarInreg.y3+=e*scrollbarInreg.y2;
    }
  }
  else if (currentModule==8) {
    if (isBetween(scrollbarCont.y,scrollbarCont.y+scrollbarCont.h-scrollbarCont.h2,scrollbarCont.y2+e*scrollbarCont.h3)) {
      scrollbarCont.y2+=e*scrollbarCont.h3;
      scrollbarCont.decateori+=e;
      //scrollbarCont.y3+=e*scrollbarCont.y2;
    }
  }
  else if (currentModule==20) {
    //print(scrollbarNoteElevi.y,' ',scrollbarNoteElevi.y+scrollbarNoteElevi.h-scrollbarNoteElevi.h2,' ',scrollbarNoteElevi.y2+e*scrollbarNoteElevi.h3,'\n');
    if (isBetween(scrollbarNoteElevi.y,scrollbarNoteElevi.y+scrollbarNoteElevi.h-scrollbarNoteElevi.h2,scrollbarNoteElevi.y2+e*scrollbarNoteElevi.h3)) {
      scrollbarNoteElevi.y2+=e*scrollbarNoteElevi.h3;
      scrollbarNoteElevi.decateori+=e;
      //scrollbarCont.y3+=e*scrollbarCont.y2;
    }
  }
  else if (currentModule==22) {
    //print(scrollbarNoteElev.y,' ',scrollbarNoteElev.y+scrollbarNoteElev.h-scrollbarNoteElev.h2,' ',scrollbarNoteElev.y2+e*scrollbarNoteElev.h3,'\n');
    if (isBetween(scrollbarNoteElev.y,scrollbarNoteElev.y+scrollbarNoteElev.h-scrollbarNoteElev.h2,scrollbarNoteElev.y2+e*scrollbarNoteElev.h3)) {
      scrollbarNoteElev.y2+=e*scrollbarNoteElev.h3;
      scrollbarNoteElev.decateori+=e;
      //scrollbarCont.y3+=e*scrollbarCont.y2;
    }
  }
  else if (currentModule==25) {
    //print(scrollbarNoteElev.y,' ',scrollbarNoteElev.y+scrollbarNoteElev.h-scrollbarNoteElev.h2,' ',scrollbarNoteElev.y2+e*scrollbarNoteElev.h3,'\n');
    if (isBetween(scrollbarComentarii.y,scrollbarComentarii.y+scrollbarComentarii.h-scrollbarComentarii.h2,scrollbarComentarii.y2+e*scrollbarComentarii.h3)) {
      scrollbarComentarii.y2+=e*scrollbarComentarii.h3;
      scrollbarComentarii.decateori+=e;
      //scrollbarCont.y3+=e*scrollbarCont.y2;
    }
  }
  else if (currentModule==26) {
    //print(scrollbarNoteElev.y,' ',scrollbarNoteElev.y+scrollbarNoteElev.h-scrollbarNoteElev.h2,' ',scrollbarNoteElev.y2+e*scrollbarNoteElev.h3,'\n');
    if (isBetween(scrollbarLectii.y,scrollbarLectii.y+scrollbarLectii.h-scrollbarLectii.h2,scrollbarLectii.y2+e*scrollbarLectii.h3)) {
      scrollbarLectii.y2+=e*scrollbarLectii.h3;
      scrollbarLectii.decateori+=e;
      //scrollbarCont.y3+=e*scrollbarCont.y2;
    }
  }
  else if (currentModule==27) {
    //print(scrollbarNoteElev.y,' ',scrollbarNoteElev.y+scrollbarNoteElev.h-scrollbarNoteElev.h2,' ',scrollbarNoteElev.y2+e*scrollbarNoteElev.h3,'\n');
    if (isBetween(scrollbarLectie.y,scrollbarLectie.y+scrollbarLectie.h-scrollbarLectie.h2,scrollbarLectie.y2+e*scrollbarLectie.h3)) {
      scrollbarLectie.y2+=e*scrollbarLectie.h3;
      scrollbarLectie.decateori+=e;
      //scrollbarCont.y3+=e*scrollbarCont.y2;
    }
  }
  else if (lessonActive!=-1)
    if (currentModule==1) {
      if (isBetween(menu.x,menu.x+menu.w,mouseX) && isBetween(menu.y,menu.y+menu.h,mouseY)) {
        if (isBetween(0,menu.bars[lessonActive-1].lesson.scrollbar.nrlines-2,menu.bars[lessonActive-1].lesson.scrollbar.linesScrolled+e)) {
          menu.bars[lessonActive-1].lesson.scrolled-=e*vit;
          menu.bars[lessonActive-1].lesson.scrollbar.scrolled+=e*menu.bars[lessonActive-1].lesson.scrollbar.h2;
          menu.bars[lessonActive-1].lesson.scrollbar.linesScrolled+=e;
        }
      }
      else 
        if (isBetween(ex.x,ex.x+ex.w,mouseX) && isBetween(ex.y,ex.y+ex.h,mouseY))
          if (isBetween(0,ex.scrollbar.nrlines-1,ex.scrollbar.linesScrolled+e)) {
            ex.scrolled-=e*vit;
            ex.scrollbar.scrolled+=e*ex.scrollbar.h2;
            ex.scrollbar.linesScrolled+=e;
          }
    }
    else if (currentModule==2) {
      if (isBetween(menuOrientate.x,menuOrientate.x+menuOrientate.w,mouseX) && isBetween(menuOrientate.y,menuOrientate.y+menuOrientate.h,mouseY)) {
        if (isBetween(0,menuOrientate.bars[lessonActive-1].lesson.scrollbar.nrlines-2,menuOrientate.bars[lessonActive-1].lesson.scrollbar.linesScrolled+e)) {
          menuOrientate.bars[lessonActive-1].lesson.scrolled-=e*vit;
          menuOrientate.bars[lessonActive-1].lesson.scrollbar.scrolled+=e*menuOrientate.bars[lessonActive-1].lesson.scrollbar.h2;
          menuOrientate.bars[lessonActive-1].lesson.scrollbar.linesScrolled+=e;
        }
      }
      else if (isBetween(ex.x,ex.x+ex.w,mouseX) && isBetween(ex.y,ex.y+ex.h,mouseY))
        if (isBetween(0,ex.scrollbar.nrlines-2,ex.scrollbar.linesScrolled+e)) {
          ex.scrolled-=e*vit;
          ex.scrollbar.scrolled+=e*ex.scrollbar.h2;
          ex.scrollbar.linesScrolled+=e;
        }
    }
    else if (currentModule==4) {
      if (isBetween(menuD.x,menuD.x+menuD.w,mouseX) && isBetween(menuD.y,menuD.y+menuD.h,mouseY)) {
        if (isBetween(0,menuD.bars[lessonActive-1].lesson.scrollbar.nrlines-2,menuD.bars[lessonActive-1].lesson.scrollbar.linesScrolled+e)) {
          menuD.bars[lessonActive-1].lesson.scrolled-=e*vit;
          menuD.bars[lessonActive-1].lesson.scrollbar.scrolled+=e*menuD.bars[lessonActive-1].lesson.scrollbar.h2;
          menuD.bars[lessonActive-1].lesson.scrollbar.linesScrolled+=e;
        }
      }
      else if (isBetween(ex.x,ex.x+ex.w,mouseX) && isBetween(ex.y,ex.y+ex.h,mouseY))
        if (isBetween(0,ex.scrollbar.nrlines-2,ex.scrollbar.linesScrolled+e)) {
          ex.scrolled-=e*vit;
          ex.scrollbar.scrolled+=e*ex.scrollbar.h2;
          ex.scrollbar.linesScrolled+=e;
        }
    }
    else if (currentModule==20) {
    if (isBetween(scrollbarNoteElevi.y,scrollbarNoteElevi.y+scrollbarNoteElevi.h-scrollbarNoteElevi.h2,scrollbarNoteElevi.y2+e*scrollbarNoteElevi.h3)) {
      scrollbarNoteElevi.y2+=e*scrollbarNoteElevi.h3;
      //scrollbarCont.y3+=e*scrollbarCont.y2;
    }
  }
}

void keyPressed() {
  if(currentModule==14)keyPress_all_questions_ViewTema();
  int e=0;
  if (keyCode==UP) e=-1;
  else if(keyCode==DOWN) e=1;
  if (lessonActive!=-1)
    if (currentModule==1) {
      if (isBetween(menu.x,menu.x+menu.w,mouseX) && isBetween(menu.y,menu.y+menu.h,mouseY)) {
        if (isBetween(0,menu.bars[lessonActive-1].lesson.scrollbar.nrlines-1,menu.bars[lessonActive-1].lesson.scrollbar.linesScrolled+e)) {
          menu.bars[lessonActive-1].lesson.scrolled-=e*vit;
          menu.bars[lessonActive-1].lesson.scrollbar.scrolled+=e*menu.bars[lessonActive-1].lesson.scrollbar.h2;
          menu.bars[lessonActive-1].lesson.scrollbar.linesScrolled+=e;
        }
      }
      else 
        if (isBetween(ex.x,ex.x+ex.w,mouseX) && isBetween(ex.y,ex.y+ex.h,mouseY))
          if (isBetween(0,ex.scrollbar.nrlines-1,ex.scrollbar.linesScrolled+e)) {
            ex.scrolled-=e*vit;
            ex.scrollbar.scrolled+=e*ex.scrollbar.h2;
            ex.scrollbar.linesScrolled+=e;
          }
    }
    else if (currentModule==2) {
      if (isBetween(menuOrientate.x,menuOrientate.x+menuOrientate.w,mouseX) && isBetween(menuOrientate.y,menuOrientate.y+menuOrientate.h,mouseY)) {
        if (isBetween(0,menuOrientate.bars[lessonActive-1].lesson.scrollbar.nrlines-1,menuOrientate.bars[lessonActive-1].lesson.scrollbar.linesScrolled+e)) {
          menuOrientate.bars[lessonActive-1].lesson.scrolled-=e*vit;
          menuOrientate.bars[lessonActive-1].lesson.scrollbar.scrolled+=e*menuOrientate.bars[lessonActive-1].lesson.scrollbar.h2;
          menuOrientate.bars[lessonActive-1].lesson.scrollbar.linesScrolled+=e;
        }
      }
      else if (isBetween(ex.x,ex.x+ex.w,mouseX) && isBetween(ex.y,ex.y+ex.h,mouseY))
        if (isBetween(0,ex.scrollbar.nrlines-1,ex.scrollbar.linesScrolled+e)) {
          ex.scrolled-=e*vit;
          ex.scrollbar.scrolled+=e*ex.scrollbar.h2;
          ex.scrollbar.linesScrolled+=e;
        }
    }
    else if (currentModule==4) {
      if (isBetween(menuD.x,menuD.x+menuD.w,mouseX) && isBetween(menuD.y,menuD.y+menuD.h,mouseY)) {
        if (isBetween(0,menuD.bars[lessonActive-1].lesson.scrollbar.nrlines-1,menuD.bars[lessonActive-1].lesson.scrollbar.linesScrolled+e)) {
          menuD.bars[lessonActive-1].lesson.scrolled-=e*vit;
          menuD.bars[lessonActive-1].lesson.scrollbar.scrolled+=e*menuD.bars[lessonActive-1].lesson.scrollbar.h2;
          menuD.bars[lessonActive-1].lesson.scrollbar.linesScrolled+=e;
        }
      }
      else if (isBetween(ex.x,ex.x+ex.w,mouseX) && isBetween(ex.y,ex.y+ex.h,mouseY))
        if (isBetween(0,ex.scrollbar.nrlines-1,ex.scrollbar.linesScrolled+e)) {
          ex.scrolled-=e*vit;
          ex.scrollbar.scrolled+=e*ex.scrollbar.h2;
          ex.scrollbar.linesScrolled+=e;
        }
    }

  if(hub.gameSelected==4){
    if(key=='R' || key=='r'){
      gameRestartFTB();
      return;
    }
  }

  if(keyCode==UP){
    if(!UP_ARR)UP_ARR=true;
  }
  else if(keyCode==DOWN){
    if(!DOWN_ARR)DOWN_ARR=true;
  }
  else if(keyCode==RIGHT){
    if(!RIGHT_ARR)RIGHT_ARR=true;
  }
  else if(keyCode==LEFT){
    if(!LEFT_ARR)LEFT_ARR=true;
  }

  if(hub.gameSelected==6){
    if(key>='0' && key<='9' && delay==0){
      delay = round(DELAY/2);
      
      REZ*=10;
      REZ+=int(key) - int('0');
    }
    if(key=='\n' && delay==0){
      delay = round(DELAY/2);

      if(REZ==nrLanturi){
        background(0, 255, 0);
        SCORE += nodeNum * muchiiGr.st.size();
        MAXSCOREGAINED += nodeNum * muchiiGr.st.size();
        gameResetGR();
      }
      else{
        background(255, 0 ,0);
        REZ = 0;
      }
    }
  }


  //FUCKING TEXTBOXES
  for(textbox t : textboxes){
    t.PressKeyProperly();
  }
}