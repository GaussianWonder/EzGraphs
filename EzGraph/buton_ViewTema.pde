class buton_ViewTema {
  float x,y,r;
  String s;
  color cFill=c1,cFill_o=c1_o;
  boolean pressed=false;
  
  buton_ViewTema(float x_,float y_,float r_,String s_) {
    x=x_;
    y=y_;
    r=r_;
    s=s_;
  }
  
  void display() {
    if (s=="Delete graph") {
      if (dist(mouseX,mouseY,x,y)<r) {
        if (r<R_ViewTema+R_ViewTema/4) r+=2;
        /*if (mousePressed && delay==0) {
          delay=DELAY;
          for (int i=questions[questionActive].nGrafs-1;i>=0;i--)
            delete_point(questions[questionActive].g[i],questionActive);
        }*/
        fill(cFill_o);
      }
      else {
        fill(cFill);
        if (r>R_ViewTema) r-=2;
      }
    }
    else
      if (dist(mouseX,mouseY,x,y)<r || butonActive_ViewTema==s) {
        fill(cFill_o);
        if (r<R_ViewTema+R_ViewTema/4) r+=2;
        /*if (mousePressed)
          butonActive=s;*/
      }
      else {
        fill(cFill);
        if (r>R_ViewTema) r-=2;
      }
    
    noStroke();
    ellipse(x,y,r*2,r*2);
    
    fill(-1);
    textAlign(CENTER,CENTER);
    textSize(r/2);
    text(s,x-2*r,y+r,r*4,r);
    fill(128,128,128);
    textSize(R_ViewTema/2);
  }

  void mousePress(){
    if (s=="Delete graph") {
      if (dist(mouseX,mouseY,x,y)<r) {
        if (r<R_ViewTema+R_ViewTema/4) r+=2;
        if (delay_ViewTema==0) {
          delay_ViewTema=DELAY_ViewTema;
          for (int i=questions_ViewTema[questionActive_ViewTema].nGrafs-1;i>=0;i--)
            delete_point_ViewTema(questions_ViewTema[questionActive_ViewTema].g[i],questionActive_ViewTema);
        }
      }
      else if (r>R_ViewTema) r-=2;
    }
    else if (dist(mouseX,mouseY,x,y)<r || butonActive_ViewTema==s) {
        if (r<R_ViewTema+R_ViewTema/4) r+=2;
        butonActive_ViewTema=s;
      }
      else if (r>R_ViewTema) r-=2;
  }
}

void display_all_butons_ViewTema() {
  move_ViewTema.display();
  deleteEdge_ViewTema.display();
  deletePoint_ViewTema.display();
  addEdge_ViewTema.display();
  addPoint_ViewTema.display();
  deleteGraf_ViewTema.display();
}