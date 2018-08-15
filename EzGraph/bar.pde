class bar {
  float baseBorder = 50, seekBorder = 50;
  float xf;
  float x,y,w,w1,h,w2=menu.w/2,wf;
  color cFill=c6,cFill_o=c6_o;
  int number;
  int[] anim=new int[10];
  String s,s1,s2,s3;
  String[] s4=new String[10];
  lesson lesson=new lesson(0,0,0,0,"");
  butonAlg[] b1=new butonAlg[10],b2=new butonAlg[10],b3=new butonAlg[10];
  
  bar(int numberr,float xx,float yy,float ww,float hh,String ss1,String ss2,String ss3,String[] ss4,int[] animm) {
    number=numberr;
    x=xx;
    xf=x;
    y=yy;
    w=ww;
    w1=w;
    h=hh;
    s1=ss1;
    s=s1;
    s2=ss2;
    s3=ss3;
    s4=ss4;
    //w2=s2.length()*w1/2;
    w2=textWidth(s2)*2;
    anim=animm;
    int i;
    for (i=0;i<anim.length;i++)
      if(anim[i]==1) {
        b1[i]=new butonAlg(x+w+menu.w2+menu.w/2.5+1,R*i+menu.w2+R*3/2,menu.w/2.5/2,R,1,i);
        b2[i]=new butonAlg(b1[i].x+b1[i].w+1,R*i+menu.w2+R*3/2,menu.w/2.5/2,R,2,i);
        b3[i]=new butonAlg(b1[i].x+b1[i].w+1,R*i+menu.w2+R*3/2,menu.w/2.5/2,R,3,i);
      }
      else b1[i]=b2[i]=b3[i]=null;
  }
  
  void update() {
    x=-2*R;
  }

  void display() {
    int i,j;
    x=lerp(x,xf,0.2);
    if (lesson.s=="") {
      if(currentModule==1){
        add_lesson(number-1,s3, menu);
      }
      else if(currentModule==2){
        add_lesson(number-1,s3, menuOrientate);
      }
      else if (currentModule==4) {
        add_lesson(number-1,s3, menuD);
      }
      else add_lesson(number-1, s3, menu);
      
    }
      
    if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && !menu2.mainTabHovered()) {
      fill(cFill_o);
      /*if (w<w2) w+=speed;
      else s=s2;*/
      //w=w1+w2;
      w=lerp(w,w1+w2,0.2);
      s=s2;
      if (mousePressed) {
        menu m=menu;
        if (currentModule==1) m=menu;
        else if (currentModule==2) m=menuOrientate;
        else if (currentModule==4) m=menuD;
        if (lessonActive!=-1 && lessonActive!=number)
          m.bars[lessonActive-1].lesson.active=false;
        lessonActive=number;
        if (currentModule==1)
          if (s2=="Arbori binari" || s2=="Arbori cu radacina")
            lines=true;
          else if (s2=="Graf bipartit")
            lines2=true;
          else lines=lines2=false;
        lesson.active=true;
        lesson.scrolled=0;
        m.bars[lessonActive-1].lesson.scrollbar.scrolled=0;
        m.bars[lessonActive-1].lesson.scrollbar.linesScrolled=0;
        //int i,j;
        for (i=0;i<nGrafs;i++)
          delete_point(grafs[i]);      
        String[] lines = loadStrings(s2 + ".txt");
        for(i=0;i<lines.length; i++) {
          if (lines[i].length()>3 && lines[i].charAt(0)=='+' && lines[i].charAt(1)=='+' && lines[i].charAt(2)=='e' && lines[i].charAt(3)=='x') {
            createExample(lines,i+1);
            break;
          }
          ex.s=getExample(lessonActive);
        }
        ex.scrollbar.scrolled=0;
        ex.scrolled=0;
        ex.scrollbar.linesScrolled=0;
      }
      seekBorder = 0;
    }
    else {
      fill(cFill);
      seekBorder = 50;
      s=s1;
      w=w1;
    }
    baseBorder = lerp(baseBorder, seekBorder, 0.25);
    if (lessonActive==number)
      fill(menu.cFill2);
    noStroke();
    rect(x, y, w, h, baseBorder);
    fill(-1);
    textSize(h/3);
    if (lessonActive==number)
      fill(0,256,0);
    textAlign(CENTER,CENTER);
    /*if (delay>DELAY)
      text(s1,x-delay+DELAY,y,w1,h);
    else */text(s1,x,y,w1,h);
    if (s==s2) text(s,x+w1,y,w-w1,h);
  }
}

void add_bar(String s1,String s2,String s3, menu jap, int barnum,String[] s4,int[] anim) {
  if (barnum>0)
    jap.bars[barnum]=new bar(barnum+1,0,jap.bars[barnum-1].y+jap.bars[barnum-1].h+jap.bars[barnum-1].h/10,jap.w2,jap.w2,s1,s2,s3,s4,anim);
  else 
    jap.bars[barnum]=new bar(barnum+1,0,2*R,jap.w2,jap.w2,s1,s2,s3,s4,anim);
}

void update_all_bars(menu jap,int barnum) {
  int i;
  for (i=0;i<barnum;i++) {
    jap.bars[i].update();
  }  
}

void display_all_bars(menu jap, int barnum) {
  int i;
  for (i=0;i<barnum;i++) {
    jap.bars[i].display();
  }
}