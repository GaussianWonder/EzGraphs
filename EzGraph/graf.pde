class graf {
  float x,y,r;
  color cFill=c2,cStroke=c5;
  color cFill_o=c2_o,cStroke_o=c5_o;
  int number=nGrafs;
  boolean selected=false,active=true,or=false;
  graf(float x_,float y_,float r_) {
    x=x_;
    y=y_;
    r=r_;
  }
  
  void display() {
    if (dist(mouseX,mouseY,x,y)<r || isToMove==number-1) {
      if (r<R+R/3) r++; ///mareste nodul daca cursorul este pe el
      if (mousePressed) {
        if (butonActive=="Move") { ///move
          if (isToMove==-1)
            isToMove=number-1;
        }
        nod=number-1;
      }
        else if (butonActive=="Add edge" && delay==0) { ///adauga muchie
          delay=DELAY;
          if (selected1!=-1)
            if (selected1!=number-1)
              add_edge(grafs[selected1],grafs[number-1]); 
            else selected1=-1;
          else selected1=number-1;
        }
        else if (butonActive=="Delete point") //sterge/dezactiveaza nodul si muchiile lui
          delete_point(grafs[number-1]);
      fill(cFill_o);
      stroke(cStroke_o);
    }
    else {
      fill(cFill);
      stroke(cStroke);
      if (r>R) r--; ///daca cursorul nu este pe el raza scade pana ajunge la forma initiala
    }
    
    if (butonActive=="Add edge") {
      if (selected1==number-1) ///daca nodul este primul nod selectat pentru o crea o muchie atunci el are conturul rosu
        stroke(256,0,0);
    }
    else if (selected1!=-1)
      selected1=-1;
    
    if (isToMove==number-1 && mouseX-R>margLeft+R && mouseY>margTop+R && mouseY+R<ex.y) { ///se muta nodul unde este cursorul
      x=mouseX;
      y=mouseY;
      ex.s=getExample(lessonActive);
    }

    if (currentModule==1 && lessonActive==5 || currentModule==2 && lessonActive==4) {
      for (int i=0;i<nrCompConexe;i++)
        for (int j=1;j<=compConexe[i][0];j++)
          if (compConexe[i][j]==number-1)
            stroke(culoriComp[i]);
    }
    else
      for (int i=0;i<ramasG;i++)
        if (number-1==noduri[i])
          stroke(256,256,0);
    
    strokeWeight(r/5);
    ellipse(x,y,r*2,r*2);
    fill(-1);
    textAlign(CENTER,CENTER);
    textSize(r);

    if (butonActive=="Add edge")
      if (selected1==number-1)
        fill(256,0,0);

    text(str(number),x-r,y-r,r*2,r*2);
    
    if (butonActive=="Delete point" && active && dist(mouseX,mouseY,x,y)<r) { ///daca este pe cale sa fie sters, are un X rosu desenat peste
        stroke (256,0,0);
        line(x-r,y-r,x+r,y+r);
        line(x+r,y-r,x-r,y+r);
      }
  }
}

void delete_point(graf a) {
  a.active=false;
  for (int k=0;k<nEdges;k++)
    if (edges[k].active && (edges[k].a==a.number-1 || edges[k].b==a.number-1))
      delete_edge(edges[k]);
  while (nGrafs>=1 && !grafs[nGrafs-1].active)
    nGrafs--;
  ex.s=getExample(lessonActive);
  if (alg) animatieAlg();
}

void add_graf(float x,float y) {
  int k,ok=-1;
  for (k=0;k<nGrafs;k++)
    if (!grafs[k].active) {
      ok=k;
      break;
    }
    
  if (ok==-1)
    grafs[nGrafs++]=new graf(x,y,R);
  else {
    grafs[ok].active=true;
    grafs[ok].x=x;
    grafs[ok].y=y;
  }
  delay=DELAY;
  ex.s=getExample(lessonActive);
  if (alg) animatieAlg();
}

void display_all_grafs() {
  int i;
  for (i=0;i<nGrafs;i++)
    if (grafs[i].active)
      grafs[i].display();
}

int realNrNoduri() {
  int i,n=0;
  for (i=0;i<nGrafs;i++)
    if (grafs[i].active)
      n++;
  return n;
} 
