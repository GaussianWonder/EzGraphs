class lesson {
  float x,y,w,h,scrolled=0;
  float x2,y2,w2,h2;
  color cFill=c7;
  String s;
  boolean active=false;
  scrollbar scrollbar;
  int q=0;
  
  lesson(float xx,float yy,float ww,float hh,String ss) {
    int i;
    x=xx;
    y=yy;
    w=ww;
    h=hh;
    s=ss;
    scrollbar=new scrollbar(x+w-menu.w2/4,y+2*R,menu.w2/4,h-2*R,1);
    scrollbar.nrlines=max(0,s.length()/15-10);
    scrollbar.h2=(h-2*R)/scrollbar.nrlines;
    x2=x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4-R;
    y2=y+menu.w2+R*3/2;
    w2=R;
    h2=R;
  }

  void display() {
    int i,j;
    if (q==0) {
      q=1;
      //s="\n"+s;
      if (lessonActive!=1)
        if (currentModule==1) {
            for (i=0;i<menu.bars[lessonActive-1].s4.length;i++)
              s="\n"+s;
        }
        else if (currentModule==2)
          for (i=0;i<menuOrientate.bars[lessonActive-1].s4.length;i++)
            s="\n"+s;
    }
    noStroke();
    fill(cFill);
    rect(x,y,w,h);
    fill(-1);
    textSize(menu.w2/4*2/1.7);
    textAlign(LEFT,LEFT);
    text(s,x+menu.w2,y+menu.w2+scrolled,w-menu.w2*3/2,h+h*scrollbar.nrlines);
    fill(c8);
    if (currentModule==1) {
      for (i=0;i<menu.bars[lessonActive-1].s4.length;i++) {
        fill(-1);
        if (!menu2.mainTabHovered() && isBetween(x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4-R,x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4,mouseX) &&
                  isBetween(R*i+y+menu.w2+scrolled+R*3/2,R*i+y+menu.w2+scrolled+R*3/2+R,mouseY)) {
          if (mousePressed && delay==0) {
            delay=DELAY;
            if (currentModule==1);        //WHAAAAAAT????
              link(transf(formatString(sketchPath("data2/"+transf(menu.bars[lessonActive-1].s4[i])+".html"))));
          }
          fill(c8_o);
        }
        else fill(c8);
        rect(x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4-R,R*i+y+menu.w2+scrolled+R*3/2,R,R);
        strokeWeight(w2/8);
        stroke(-1);
        line(x2+w2/2,R*i+scrolled+y2+w2/8,x2+w2/2,R*i+scrolled+y2+h2-w2/8*4); 
        line(x2+w2/2,R*i+scrolled+y2+h2-w2/8*4,x2+w2/2-w2/4,R*i+scrolled+y2+h2-w2/8*4-w2/4);
        line(x2+w2/2,R*i+scrolled+y2+h2-w2/8*4,x2+w2/2+w2/4,R*i+scrolled+y2+h2-w2/8*4-w2/4);
        line(x2+w2/2+w2/4,R*i+scrolled+y2+h2-w2/8*2,x2+w2/2-w2/4,R*i+scrolled+y2+h2-w2/8*2);
        noStroke();

        if (i<menu.bars[lessonActive-1].anim.length && menu.bars[lessonActive-1].anim[i]==1) {
          /*if (!menu2.mainTabHovered() && isBetween(x+menu.w2+menu.w/2.5+1,x+menu.w2+menu.w/2.5+menu.w/2.5+1,mouseX) &&
                  isBetween(R*i+y+menu.w2+scrolled+R*3/2,R*i+y+menu.w2+scrolled+R*3/2+R,mouseY)) {
            if (mousePressed && !menu2.mainTabHovered() && delay==0) {
              delay=DELAY;
              animatieAlg();
            }
            fill(c8_o);
          }
          else fill(c8);
          rect(x+menu.w2+menu.w/2.5+1,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5,R);*/
          menu.bars[lessonActive-1].b1[i].display();
          menu.bars[lessonActive-1].b2[i].display();
          menu.bars[lessonActive-1].b3[i].display();
        }
      }
    }
    else if (currentModule==2) {
      for (i=0;i<menuOrientate.bars[lessonActive-1].s4.length;i++) {
        if (!menu2.mainTabHovered() && isBetween(x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4-R,x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4,mouseX) &&
        isBetween(R*i+y+menuOrientate.w2+scrolled+R*3/2,R*i+y+menuOrientate.w2+scrolled+R*3/2+R,mouseY)) {
          if (mousePressed && !menu2.mainTabHovered() && delay==0) {
            delay=DELAY;
              link(transf(formatString(sketchPath("data2/"+transf(menuOrientate.bars[lessonActive-1].s4[i])+".html"))));
          }
          fill(c8_o);
        }
        else fill(c8);
        rect(x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4-R,R*i+y+menu.w2+scrolled+R*3/2,R,R);strokeWeight(w2/8);
        stroke(-1);
        line(x2+w2/2,R*i+scrolled+y2+w2/8,x2+w2/2,R*i+scrolled+y2+h2-w2/8*4); 
        line(x2+w2/2,R*i+scrolled+y2+h2-w2/8*4,x2+w2/2-w2/4,R*i+scrolled+y2+h2-w2/8*4-w2/4);
        line(x2+w2/2,R*i+scrolled+y2+h2-w2/8*4,x2+w2/2+w2/4,R*i+scrolled+y2+h2-w2/8*4-w2/4);
        line(x2+w2/2+w2/4,R*i+scrolled+y2+h2-w2/8*2,x2+w2/2-w2/4,R*i+scrolled+y2+h2-w2/8*2);
        noStroke();


        if (i<menuOrientate.bars[lessonActive-1].anim.length && menuOrientate.bars[lessonActive-1].anim[i]==1) {
          /*if (!menu2.mainTabHovered() && isBetween(x+menuOrientate.w2+menu.w/2.5+1,x+menuOrientate.w2+menuOrientate.w/2.5+menu.w/2.5+1,mouseX) &&
                  isBetween(R*i+y+menuOrientate.w2+scrolled+R*3/2,R*i+y+menuOrientate.w2+scrolled+R*3/2+R,mouseY)) {
            if (mousePressed && !menu2.mainTabHovered() && delay==0) {
              delay=DELAY;
              animatieAlg();
            }
            fill(c8_o);
          }
          else fill(c8);
          rect(x+menuOrientate.w2+menu.w/2.5+1,R*i+y+menuOrientate.w2+scrolled+R*3/2,menu.w/2.5,R);*/
          menuOrientate.bars[lessonActive-1].b1[i].display();
          menuOrientate.bars[lessonActive-1].b2[i].display();
          menuOrientate.bars[lessonActive-1].b3[i].display();
        }
      }
    }
    else if (currentModule==4) {
      for (i=0;i<menuD.bars[lessonActive-1].s4.length;i++) {
        if (!menu2.mainTabHovered() && isBetween(x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4-R,x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4,mouseX) &&
                isBetween(R*i+y+menuD.w2+scrolled+R*3/2,R*i+y+menuD.w2+scrolled+R*3/2+R,mouseY)) {
          if (mousePressed && !menu2.mainTabHovered() && delay==0) {
            delay=DELAY;
            link(transf(formatString(sketchPath("data2/"+transf(menuD.bars[lessonActive-1].s4[i])+".html"))));
          }
          fill(c8_o);
        }
        else fill(c8);
        rect(x+menu.w2+menu.w/4+menu.w/2.5-menu.w/4-R,R*i+y+menu.w2+scrolled+R*3/2,R,R);
        strokeWeight(w2/8);
        stroke(-1);
        line(x2+w2/2,R*i+scrolled+y2+w2/8,x2+w2/2,R*i+scrolled+y2+h2-w2/8*4); 
        line(x2+w2/2,R*i+scrolled+y2+h2-w2/8*4,x2+w2/2-w2/4,R*i+scrolled+y2+h2-w2/8*4-w2/4);
        line(x2+w2/2,R*i+scrolled+y2+h2-w2/8*4,x2+w2/2+w2/4,R*i+scrolled+y2+h2-w2/8*4-w2/4);
        line(x2+w2/2+w2/4,R*i+scrolled+y2+h2-w2/8*2,x2+w2/2-w2/4,R*i+scrolled+y2+h2-w2/8*2);
        noStroke();


        if (i<menuD.bars[lessonActive-1].anim.length && menuD.bars[lessonActive-1].anim[i]==1) {
          /*if (!menu2.mainTabHovered() && isBetween(x+menuD.w2+menu.w/2.5+1,x+menuD.w2+menuD.w/2.5+menu.w/2.5+1,mouseX) &&
                  isBetween(R*i+y+menuD.w2+scrolled+R*3/2,R*i+y+menuD.w2+scrolled+R*3/2+R,mouseY)) {
            if (mousePressed && !menu2.mainTabHovered() && delay==0) {
              delay=DELAY;
              animatieAlg();
            }
            fill(c8_o);
          }
          else fill(c8);
          rect(x+menuD.w2+menu.w/2.5+1,R*i+y+menuD.w2+scrolled+R*3/2,menu.w/2.5,R);*/
          menuD.bars[lessonActive-1].b1[i].display();
          menuD.bars[lessonActive-1].b2[i].display();
          menuD.bars[lessonActive-1].b3[i].display();
        }
      }
    }
    fill(-1);
    textAlign(CENTER,CENTER);
    if (currentModule==1) 
      for (i=0;i<menu.bars[lessonActive-1].s4.length;i++) {
        text(menu.bars[lessonActive-1].s4[i]+":",x+menu.w2,R*i+y+menu.w2+scrolled+R*3/2,menu.w/4,R);
        text("Download:",x+menu.w2+menu.w/4-R/2-3,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5-menu.w/4,R);
        //text("Download "+menu.bars[lessonActive-1].s4[i],x+menu.w2,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5,R);
        /*if (i<menu.bars[lessonActive-1].anim.length && menu.bars[lessonActive-1].anim[i]==1)
          text("Vezi parcurgerea "+menu.bars[lessonActive-1].s4[i],x+menu.w2+menu.w/2.5,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5,R);
      */}
    else if (currentModule==2)
      for (i=0;i<menuOrientate.bars[lessonActive-1].s4.length;i++) {
        text(menuOrientate.bars[lessonActive-1].s4[i]+":",x+menu.w2,R*i+y+menu.w2+scrolled+R*3/2,menu.w/4,R);
        text("Download:",x+menu.w2+menu.w/4-R/2-3,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5-menu.w/4,R);
        /*if (i<menuOrientate.bars[lessonActive-1].anim.length && menuOrientate.bars[lessonActive-1].anim[i]==1)
          text("Vezi parcurgerea "+menuOrientate.bars[lessonActive-1].s4[i],x+menu.w2+menu.w/2.5,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5,R);
      */}
    else if (currentModule==4)
      for (i=0;i<menuD.bars[lessonActive-1].s4.length;i++) {
        text(menuD.bars[lessonActive-1].s4[i]+":",x+menu.w2,R*i+y+menu.w2+scrolled+R*3/2,menu.w/4,R);
        text("Download:",x+menu.w2+menu.w/4-R/2-3,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5-menu.w/4,R);
        /*if (i<menuD.bars[lessonActive-1].anim.length && menuD.bars[lessonActive-1].anim[i]==1)
          text("Vezi parcurgerea "+menuD.bars[lessonActive-1].s4[i],x+menu.w2+menu.w/2.5,R*i+y+menu.w2+scrolled+R*3/2,menu.w/2.5,R);
      */}
    scrollbar.display();
  }
}

String transf(String s) {
  String s2="";
  int i;
  for (i=0;i<s.length();i++)
    if (s.charAt(i)==' ') s2+="%20";
    else s2+=s.charAt(i);
  return s2;
}

void add_lesson(int k,String s, menu jap) {
  jap.bars[k].lesson=new lesson(jap.x+jap.w2,jap.y,jap.w-jap.w2,jap.h,s);
}

String formatString(String s){
  String s2 = "";
  for(int i=0;i<s.length();i++)
    if(s.charAt(i)=='\\')s2+='/';
    else s2+=s.charAt(i);
  return ("file:///" + s2);
}