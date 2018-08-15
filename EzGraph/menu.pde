class menu {
  float x,y,w,h,w2=R*1.7;
  color cFill1=c7,cFill2=c8;
  bar[] bars=new bar[200];
  
  menu(float xx,float yy,float ww,float hh) {
    x=xx;
    y=yy;
    w=ww;
    h=hh;
  }
  
  void display() {
    fill(cFill1);
    noStroke();
    rect(x,y,w,h);
    
    fill(cFill2);
    rect(x,y,w2,h);
    
    if (lessonActive!=-1)
        bars[lessonActive-1].lesson.display();
      
    if(currentModule==1){
      display_all_bars(menu, nBars);
    }
    else if(currentModule==2){
      display_all_bars(menuOrientate, n2Bars);
    }
    else if(currentModule==4){
      display_all_bars(menuD, n0Bars);
    }
  
  }
}