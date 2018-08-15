class edge {
  float x,y,x2,y2,w1,w2,l=20,w3,w11,w22,q;
  color cStroke=c1;
  color cStroke_o=c1_o;
  int number;
  int a,b,nr;
  boolean active=true;
  graf a1,b1;
  
  edge(int a_,int b_,int nrr) {
    a=a_; ///nodul 1
    b=b_; ///nodul2
    nr=nrr;
    number=questions[nr].nEdges+1;
  }
  
  void display() {
    number=questions[nr].nEdges;
    x=questions[nr].g[a].x;
    y=questions[nr].g[a].y;
    x2=questions[nr].g[b].x;
    y2=questions[nr].g[b].y;
    
    if (a==isToMove || b==isToMove) ///daca nodul se misca, muchiile sunt rosii
      stroke(256,0,0);
    else if (abs(dist(mouseX,mouseY,x,y)+dist(mouseX,mouseY,x2,y2)-dist(x,y,x2,y2))<0.5) { ///daca muchia are cursorul peste ea
      stroke(cStroke_o);
      if (butonActive=="Delete edge") { ///stergere muchie
        stroke(256,0,0); ///daca muchia are cursorul peste ea si este pe cale sa fie stearsa este rosie
        if (mousePressed)
           delete_edge(this,nr);///dezactivarea/stergerea muchiei
      }
    }
    else
      stroke(cStroke);
    
    if (butonActive=="Delete point") { ///daca nodul este pe cale sa fie sters, muchia este rosie
      if (active && (dist(mouseX,mouseY,questions[nr].g[a].x,questions[nr].g[a].y)<questions[nr].g[a].r ||
          dist(mouseX,mouseY,questions[nr].g[b].x,questions[nr].g[b].y)<questions[nr].g[b].r))
        stroke(256,0,0);
    }
    
    strokeWeight(R/10);
    //line(x,y,x2,y2);
    noFill();
    if (questions[nr].or==2) {
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
    a1=questions[nr].g[a];
    b1=questions[nr].g[b];
    if (questions[nr].or==2) {
      //noStroke();
      //stroke(0,256,0);
      //fill(0,256,0);
      q=R/2;
      //w1=R*(x2-x)/dist(x,y,x2,y2);
      //w2=R*(y2-y)/dist(x,y,x2,y2);
      w1=q*cos(w3+PI+PI/8);
      w2=q*sin(w3+PI+PI/8);
      w11=R*cos(w3+PI/10+PI+PI/8);
      w22=R*sin(w3+PI/10+PI+PI/8);
      line(x2+w1,y2+w2,x2+w1+w11/2,y2+w2+w22/2);
      //ellipse(x2+w1,y2+w2,20,20);
      w11=R*cos(w3-PI/5+PI+PI/8);
      w22=R*sin(w3-PI/5+PI+PI/8);
      line(x2+w1,y2+w2,x2+w1+w11/2,y2+w2+w22/2);
      /*q=R+10;
      w11=q*cos(w3+PI+PI/8);
      w22=q*sin(w3+PI+PI/8);
      ellipse(x2+w11,y2+w22,20,20);*/
    }
    if (butonActive=="Delete edge" && questions[nr].or==2) {
      noStroke();
      int j=(int)(dist(x,y,x2,y2)/5);
      for (int i=1;i<=j;i++)
        ellipse(x+(x2-x)/j*i,y+(y2-y)/j*i,2,2);
    }
  }
  
}

void delete_edge(edge a,int nr) {
  a.active=false;
}

void add_edge(graf a,graf b,int nr) {
  int k=1;
  for (int kk=0;kk<questions[nr].nEdges;kk++) ///verifica daca muchia este deja existenta
    if (questions[nr].e[kk].active) {
      if (questions[nr].or==1) {
        if (questions[nr].e[kk].a==a.number-1 && questions[nr].e[kk].b==b.number-1 || questions[nr].e[kk].a==b.number-1 &&
           questions[nr].e[kk].b==a.number-1) {
          k=0;
          break;
        }
      }
      else 
        if (questions[nr].or==2)
          if (questions[nr].e[kk].a==a.number-1 && questions[nr].e[kk].b==b.number-1) {
            k=0;
            break;
          }
    }
    else {
      questions[nr].e[kk].active=true; ///daca exista o muchie inactiva, aceea devine noua muchie
      questions[nr].e[kk].a=a.number-1;
      questions[nr].e[kk].b=b.number-1;
      k=-1;
      break;
    }
  if (k==1) { ///daca muchia nu exista, o adauga
    questions[nr].e[questions[nr].nEdges++]=new edge(a.number-1,b.number-1,nr);
    selected1=-1;
  }
}

void display_all_edges(int nr) {
  int i;
  for (i=0;i<questions[nr].nEdges;i++)
    if (questions[nr].e[i].active)
      questions[nr].e[i].display();
}