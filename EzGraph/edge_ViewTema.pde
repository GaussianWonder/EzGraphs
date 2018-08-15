class edge_ViewTema {
  float x,y,x2,y2,w1,w2,l=20,w3,w11,w22,q;
  color cStroke=c1;
  color cStroke_o=c1_o;
  int number;
  int a,b,nr;
  boolean active=true;
  graf_ViewTema a1,b1;
  
  edge_ViewTema(int a_,int b_,int nrr) {
    a=a_; ///nodul 1
    b=b_; ///nodul2
    nr=nrr;
    number=questions_ViewTema[nr].nEdges;
  }
  
  void display() {
    x=questions_ViewTema[nr].g[a].x;
    y=questions_ViewTema[nr].g[a].y;
    x2=questions_ViewTema[nr].g[b].x;
    y2=questions_ViewTema[nr].g[b].y;
    
    if (a==isToMove_ViewTema || b==isToMove_ViewTema) ///daca nodul se misca, muchiile sunt rosii
      stroke(256,0,0);
    else if (abs(dist(mouseX,mouseY,x,y)+dist(mouseX,mouseY,x2,y2)-dist(x,y,x2,y2))<0.5) { ///daca muchia are cursorul peste ea
      stroke(cStroke_o);
      if (butonActive_ViewTema=="Delete edge") { ///stergere muchie
        stroke(256,0,0); ///daca muchia are cursorul peste ea si este pe cale sa fie stearsa este rosie
        if (mousePressed)
           delete_edge_ViewTema(questions_ViewTema[nr].e[number-1],nr);///dezactivarea/stergerea muchiei
      }
    }
    else
      stroke(cStroke);
    
    if (butonActive_ViewTema=="Delete point") { ///daca nodul este pe cale sa fie sters, muchia este rosie
      if (active && (dist(mouseX,mouseY,questions_ViewTema[nr].g[a].x,questions_ViewTema[nr].g[a].y)<questions_ViewTema[nr].g[a].r ||
          dist(mouseX,mouseY,questions_ViewTema[nr].g[b].x,questions_ViewTema[nr].g[b].y)<questions_ViewTema[nr].g[b].r))
        stroke(256,0,0);
    }
    
    strokeWeight(R_ViewTema/10);
    //line(x,y,x2,y2);
    noFill();
    if (questions_ViewTema[nr].or==2) {
      if (x!=x2)
        w3=atan((y-y2)/(x-x2));
      else w3=PI/2;
      if (y2<y) w3=-w3;
      PVector v1=new PVector(x2-x,y2-y);
      PVector v2=new PVector(width,0);
      w3=radians(PVector.angleBetween(v2, v1));
      if (y2<y) w3=-w3;
      w3=w3*180/PI;
      q=dist(x,y,x2,y2)/3;
      w1=q*cos(w3-PI/8);
      w2=q*sin(w3-PI/8);
      w11=q*cos(w3+PI/8+PI);
      w22=q*sin(w3+PI/8+PI);
      /*line(x,y,x+w1,y+w2);
      line(x+w1,y+w2,x2+w11,y2+w22);
      line(x2,y2,x2+w11,y2+w22);
      //*/bezier(x,y,x+w1,y+w2,x2+w11,y2+w22,x2,y2);
    }
    else line(x,y,x2,y2);
    fill(256,0,0);
    a1=questions_ViewTema[nr].g[a];
    b1=questions_ViewTema[nr].g[b];
    if (questions_ViewTema[nr].or==2) {
      //noStroke();
      //stroke(0,256,0);
      //fill(0,256,0);
      q=R_ViewTema/2;
      //w1=R*(x2-x)/dist(x,y,x2,y2);
      //w2=R*(y2-y)/dist(x,y,x2,y2);
      w1=q*cos(w3+PI+PI/8);
      w2=q*sin(w3+PI+PI/8);
      w11=R_ViewTema*cos(w3+PI/10+PI+PI/8);
      w22=R_ViewTema*sin(w3+PI/10+PI+PI/8);
      line(x2+w1,y2+w2,x2+w1+w11/2,y2+w2+w22/2);
      //ellipse(x2+w1,y2+w2,20,20);
      w11=R_ViewTema*cos(w3-PI/5+PI+PI/8);
      w22=R_ViewTema*sin(w3-PI/5+PI+PI/8);
      line(x2+w1,y2+w2,x2+w1+w11/2,y2+w2+w22/2);
      /*q=R+10;
      w11=q*cos(w3+PI+PI/8);
      w22=q*sin(w3+PI+PI/8);
      ellipse(x2+w11,y2+w22,20,20);*/
    }
    if (butonActive_ViewTema=="Delete edge" && questions_ViewTema[nr].or==2) {
      noStroke();
      int j=(int)(dist(x,y,x2,y2)/5);
      for (int i=1;i<=j;i++)
        ellipse(x+(x2-x)/j*i,y+(y2-y)/j*i,2,2);
    }
  }
  
}

void delete_edge_ViewTema(edge_ViewTema a,int nr) {
  a.active=false;
}

void add_edge_ViewTema(graf_ViewTema a,graf_ViewTema b,int nr) {
  int k=1;
  for (int kk=0;kk<questions_ViewTema[nr].nEdges;kk++) ///verifica daca muchia este deja existenta
    if (questions_ViewTema[nr].e[kk].active) {
      if (questions_ViewTema[nr].or==1) {
        if (questions_ViewTema[nr].e[kk].a==a.number-1 && questions_ViewTema[nr].e[kk].b==b.number-1 || questions_ViewTema[nr].e[kk].a==b.number-1 &&
           questions_ViewTema[nr].e[kk].b==a.number-1) {
          k=0;
          break;
        }
      }
      else if (questions_ViewTema[nr].e[kk].a==a.number-1 && questions_ViewTema[nr].e[kk].b==b.number-1) {
          k=0;
          break;
      }
    }
    else {
      questions_ViewTema[nr].e[kk].active=true; ///daca exista o muchie inactiva, aceea devine noua muchie
      questions_ViewTema[nr].e[kk].a=a.number-1;
      questions_ViewTema[nr].e[kk].b=b.number-1;
      k=-1;
      break;
    }
  if (k==1) { ///daca muchia nu exista, o adauga
    questions_ViewTema[nr].e[questions_ViewTema[nr].nEdges++]=new edge_ViewTema(a.number-1,b.number-1,nr);
    selected1_ViewTema=-1;
  }
}

void display_all_edges_ViewTema(int nr) {
  int i;
  for (i=0;i<questions_ViewTema[nr].nEdges;i++)
    if (questions_ViewTema[nr].e[i].active)
      questions_ViewTema[nr].e[i].display();
}