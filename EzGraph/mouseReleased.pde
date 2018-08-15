void mouseReleased() {
  okClasa = false;
  if(currentModule==14 && !stopTEMA){
    if (isToMove_ViewTema!=-1) ///daca am un nodul selectat pentru mutare, dar nu mai tin apasat pe el
      isToMove_ViewTema=-1;
  }
  if (isToMove!=-1) ///daca am un nodul selectat pentru mutare, dar nu mai tin apasat pe el
    isToMove=-1;
    
  if (isToScroll!=-1)
    isToScroll=-1;

  if((hub.gameSelected==1 || hub.gameSelected==2 || hub.gameSelected==6) && nodes!=null){
    indexPrev = -1;
    indexCurr = -1;
    muchiiGr = new MuchiiGR();

    for(Node n : nodes)
      n.toggle = false;
  }
}

void mousePressed(){
  if(currentModule == 13 && !stopTEST)
    mousePress_all_questions_TestView();
  if(currentModule == 14 && !stopTEMA)
    mousePress_all_questions_ViewTema();
  
  float sc=scrollbarCont.y2-scrollbarCont.y;
}