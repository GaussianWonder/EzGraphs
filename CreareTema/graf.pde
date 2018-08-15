class graf {
  float x,y,r;
  color cFill=c2,cStroke=c5;
  color cFill_o=c2_o,cStroke_o=c5_o;
  int number;
  int nr;
  boolean selected=false,active=true,or=false;
  graf(float x_,float y_,float r_,int nrr) {
    x=x_;
    y=y_;
    r=r_;
    nr=nrr;
    number=questions[nr].nGrafs+1;
  }
  
  void display() {
    if (questionActive==nr) {
      if (dist(mouseX,mouseY,x,y)<r || isToMove==number-1) {
        if (r<(R+R/3)/2) r++; ///mareste nodul daca cursorul este pe el
        if (mousePressed)
          if (butonActive=="Move") { ///move
            if (isToMove==-1)
              isToMove=number-1;
          }
          else if (butonActive=="Add edge" && delay==0) { ///adauga muchie
            delay=DELAY;
            if (selected1!=-1)
              if (selected1!=number-1)
                add_edge(questions[nr].g[selected1],questions[nr].g[number-1],nr);
              else selected1=-1;
            else selected1=number-1;
          }
          else if (butonActive=="Delete point") //sterge/dezactiveaza nodul si muchiile lui
            delete_point(questions[nr].g[number-1],nr);
        fill(cFill_o);
        stroke(cStroke_o);
      }
      else {
        fill(cFill);
        stroke(cStroke);
        if (r>R/2) r--; ///daca cursorul nu este pe el raza scade pana ajunge la forma initiala
      }
      
      if (butonActive=="Add edge") {
        if (selected1==number-1) ///daca nodul este primul nod selectat pentru o crea o muchie atunci el are conturul rosu
          stroke(256,0,0);
      }
      else if (selected1!=-1)
        selected1=-1;
      
      if (isToMove==number-1 && isBetween(width/2+r,width-r,mouseX) && isBetween(move.y+R*2,height-r,mouseY)) {// && mouseX-R>margLeft+R && mouseY>margTop+R && mouseY+R<ex.y) { ///se muta nodul unde este cursorul
        x=mouseX;
        y=mouseY;
      }
      
      strokeWeight(r/5);
      ellipse(x,y,r*2,r*2);
      fill(-1);
      textAlign(CENTER,CENTER);
      textSize(r);
      text(str(number),x-r,y-r,r*2,r*2);
      
      if (butonActive=="Delete point" && active && dist(mouseX,mouseY,x,y)<r) { ///daca este pe cale sa fie sters, are un X rosu desenat peste
          stroke (256,0,0);
          line(x-r,y-r,x+r,y+r);
          line(x+r,y-r,x-r,y+r);
      }
    }
  }
}

void delete_point(graf a,int nr) {
  a.active=false;
  if (questionActive==nr) {
    for (int k=0;k<questions[nr].nEdges;k++)
      if (questions[nr].e[k].active && (questions[nr].e[k].a==a.number-1 || questions[nr].e[k].b==a.number-1))
        delete_edge(questions[nr].e[k],nr);
    while (questions[nr].nGrafs>=1 && !questions[nr].g[questions[nr].nGrafs-1].active)
      questions[nr].nGrafs--;
  }
}

void add_graf(float x,float y,int nr) {
  int k,ok=-1;
  if (questionActive==nr) {
    for (k=0;k<questions[nr].nGrafs;k++)
      if (!questions[nr].g[k].active) {
        ok=k;
        break;
      }
      
    if (ok==-1) {
      questions[nr].g[questions[nr].nGrafs]=new graf(x,y,R/2,nr);
      questions[nr].nGrafs++;
    }
    else {
      questions[nr].g[ok].active=true;
      questions[nr].g[ok].x=x;
      questions[nr].g[ok].y=y;
    }
    delay=DELAY;
  }
}

void display_all_grafs(int nr) {
  int i;
  if (questionActive==nr) {
    for (i=0;i<questions[questionActive].nGrafs;i++)
      if (questions[questionActive].g[i].active)
        questions[questionActive].g[i].display();
    }
}

void mouseReleased() {
  if (isToMove!=-1) ///daca am un nodul selectat pentru mutare, dar nu mai tin apasat pe el
    isToMove=-1;
}