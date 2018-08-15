class graf_ViewTema {
  float x,y,r;
  color cFill=c2,cStroke=c5;
  color cFill_o=c2_o,cStroke_o=c5_o;
  int number;
  int nr;
  boolean selected=false,active=true,or=false;

  graf_ViewTema(float x_,float y_,float r_,int nrr) {
    x=x_;
    y=y_;
    r=r_;
    nr=nrr;
    number=questions_ViewTema[nr].nGrafs;
    if (questions_ViewTema[nr].or==2) or=true;
  }
  
  void display() {
    if (dist(mouseX,mouseY,x,y)<r || isToMove_ViewTema==number-1) {
      if (r<(R_ViewTema+R_ViewTema/3)/2) r++; ///mareste nodul daca cursorul este pe el
      if (mousePressed)
        if (butonActive_ViewTema=="Move") { ///move
          if (isToMove_ViewTema==-1)
            isToMove_ViewTema=number-1;
        }
        else if (butonActive_ViewTema=="Add edge" && delay_ViewTema==0) { ///adauga muchie
          delay_ViewTema=DELAY_ViewTema;
          if (selected1_ViewTema!=-1)
            if (selected1_ViewTema!=number-1)
              add_edge_ViewTema(questions_ViewTema[nr].g[selected1_ViewTema],questions_ViewTema[nr].g[number-1],nr); 
            else selected1_ViewTema=-1;
          else selected1_ViewTema=number-1;
        }
        else if (butonActive_ViewTema=="Delete point") //sterge/dezactiveaza nodul si muchiile lui
          delete_point_ViewTema(questions_ViewTema[nr].g[number-1],nr);
      fill(cFill_o);
      stroke(cStroke_o);
    }
    else {
      fill(cFill);
      stroke(cStroke);
      if (r>R_ViewTema/2) r--; ///daca cursorul nu este pe el raza scade pana ajunge la forma initiala
    }
    
    if (butonActive_ViewTema=="Add edge") {
      if (selected1_ViewTema==number-1) ///daca nodul este primul nod selectat pentru o crea o muchie atunci el are conturul rosu
        stroke(256,0,0);
    }
    else if (selected1_ViewTema!=-1)
      selected1_ViewTema=-1;
    
    if (isToMove_ViewTema==number-1) {// && mouseX-R>margLeft+R && mouseY>margTop+R && mouseY+R<ex.y) { ///se muta nodul unde este cursorul
      x=mouseX;
      y=mouseY;
    }
    
    strokeWeight(r/5);
    ellipse(x,y,r*2,r*2);
    fill(-1);
    textAlign(CENTER,CENTER);
    textSize(r);
    text(str(number),x-r,y-r,r*2,r*2);
    
    if (butonActive_ViewTema=="Delete point" && active && dist(mouseX,mouseY,x,y)<r) { ///daca este pe cale sa fie sters, are un X rosu desenat peste
        stroke (256,0,0);
        line(x-r,y-r,x+r,y+r);
        line(x+r,y-r,x-r,y+r);
      }
  }
}

void delete_point_ViewTema(graf_ViewTema a,int nr) {
  a.active=false;
  for (int k=0;k<questions_ViewTema[nr].nEdges;k++)
    if (questions_ViewTema[nr].e[k].active && (questions_ViewTema[nr].e[k].a==a.number-1 || questions_ViewTema[nr].e[k].b==a.number-1))
      delete_edge_ViewTema(questions_ViewTema[nr].e[k],nr);
  while (questions_ViewTema[nr].nGrafs>=1 && !questions_ViewTema[nr].g[questions_ViewTema[nr].nGrafs-1].active)
    questions_ViewTema[nr].nGrafs--;
}

void add_graf_ViewTema(float x,float y,int nr) {
  int k,ok=-1;
  for (k=0;k<questions_ViewTema[nr].nGrafs;k++)
    if (!questions_ViewTema[nr].g[k].active) {
      ok=k;
      break;
    }
    
  if (ok==-1)
    questions_ViewTema[nr].g[questions_ViewTema[nr].nGrafs++]=new graf_ViewTema(x,y,R_ViewTema/2,nr);
  else {
    questions_ViewTema[nr].g[ok].active=true;
    questions_ViewTema[nr].g[ok].x=x;
    questions_ViewTema[nr].g[ok].y=y;
  }
  delay_ViewTema=DELAY_ViewTema;
}

void display_all_grafs_ViewTema(int nr) {
  int i;
  for (i=0;i<questions_ViewTema[nr].nGrafs;i++)
    if (questions_ViewTema[nr].g[i].active)
      questions_ViewTema[nr].g[i].display();
}