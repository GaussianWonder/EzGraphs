void drawHexCollector(){
  background(color4);
  
  if (keyPressed && key=='r' && number==0)
    number=1;
  if(keyPressed && key=='e')hub.gameSelected = 0;
  
  if (number>0) {
    number=-5;
    initializeHC();
  }
  else if (number<0) number++;
  
  int i,j;

  fill(0);    
  for (i=0;i<nmax;i++)
    for (j=0;j<mmax;j++) 
      if (hexagons[i][j].ok==1)
        hexagons[i][j].draw_hex();
      else  
        if (hexagons[i][j].time>0) {
          hexagons[i][j].time--;
          Time=hexagons[i][j].time;
          hexagons[i][j].r-=(RR/TIME);
          hexagons[i][j].draw_hex();
        }
  
  if (!mousePressed)
    if (omax!=0)
      destroyHC();
    else if (Time==0) 
      if (FALL==0) fallHC();
      else realFallHC();
  
    for (i=1;i<omax;i++) {
      stroke(-1);
      line(hexagons[orderx[i]][ordery[i]].x,hexagons[orderx[i]][ordery[i]].y,hexagons[orderx[i-1]][ordery[i-1]].x,hexagons[orderx[i-1]][ordery[i-1]].y);
    }
  
  restart.draw_buton();
  
  s1.draw_hex();
  s2.draw_hex();
  s3.draw_hex();
  fill(0);
  textAlign(CENTER,CENTER);
  text(score1+" / "+mscore1,margin+s1.r,0,margin*2,margin);
  text(score2+" / "+mscore2,margin*4+s2.r,0,margin*2,margin);
  text(score3+" / "+mscore3,margin*7+s3.r,0,margin*2,margin);

}

void setupHexCollector(){
  RR=min(height,width)/20;
  margin=min(width,height)/10;
  restart=new butonHC(margin/3,height-margin/6*5,margin*2,margin/6*4,"RESTART");
}

class butonHC{
  float x,y,w,h;
  String s;
  color cc=color(256,40,40),c=color(246,0,0);
  
  butonHC(float xx,float yy,float ww,float hh,String ss) {
    x=xx;
    y=yy;
    w=ww;
    h=hh;
    s=ss;
  }
  
  void draw_buton() {
    fill(c);
    if (mouseX - 2*SCL>=x && mouseX - 2*SCL<=x+w && mouseY - 2*SCL>=y && mouseY - 2*SCL<=y+h) {
      fill(cc);
      if (mousePressed && number==0)
        number=5;
    }
    stroke(0);
    strokeWeight(RR/12);
    rect(x,y,w,h);
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(h/2);
    text(s,x,y,w,h);
  }
}

void destroyHC() {
  int i;
  for (i=0;i<omax;i++) {
      use[orderx[i]][ordery[i]]=0;
      if (omax>=3) {
        hexagons[orderx[i]][ordery[i]].ok=0;
        Time=TIME;
      }
  }
  if (omax>=3)
  if (hexagons[orderx[0]][ordery[0]].c==color1) score1-=omax;
  else if (hexagons[orderx[0]][ordery[0]].c==color2) score2-=omax;
  else if (hexagons[orderx[0]][ordery[0]].c==color3) score3-=omax;
  omax=0;
}

void fallHC() {
  int i,j,k,ok;
  for (i=0;i<nmax;i++)
    for (j=0;j<mmax;j++) {
      target[i][j]=0;
      target2[i][j]=j;
    }
  for (i=0;i<nmax;i++)
      for (j=mmax-1;j>=0;j--) {
          for (k=j;k>=0;k--)
            if (hexagons[i][k].ok==1 && target[i][j]==0) {
              target[i][k]=(j-k)*vel;
              target2[i][k]=j;
              break;
            }
      }
  FALL=1;
}


void fall2HC() {
  int i,j,k,ok;
  for (i=0;i<nmax;i++)
      for (j=mmax-1;j>=0;j--) {
        ok=0;
        for (k=j;k>=0;k--)
          if (hexagons[i][k].ok==1) {
            hexagons[i][j].ok=1;
            hexagons[i][j].r=RR;
            hexagons[i][j].time=TIME;
            hexagons[i][j].c=hexagons[i][k].c;
            hexagons[i][j].cc=hexagons[i][k].cc;
            if (k!=j) {
              hexagons[i][k].ok=0;
              hexagons[i][k].time=0;
            }
            ok=1;
            break;
          }
        if (ok==0) break;
      }
}

class hexHC{
  float x,y,r;
  int i,j,ok=1,time=TIME;
  //color c=(random(0,1)<0.5)?color1:color2;
  color c=(random(0,1)<0.33333)?color1:((random(0,1)<0.666666)?color2:color3);
  color cc=(c==color1)?c12:((c==color2)?c22:c32);
  
  hexHC(float xx,float yy,float rr,int ii,int jj) {
    x=xx;
    y=yy;
    r=rr;
    i=ii;
    j=jj;
  }
  
  void draw_hex() {
    if (use[i][j]==0)
      fill(c);
    else fill(cc);
    stroke(0);
    strokeWeight(RR/12);
    beginShape();
    vertex(x-r/2,y-r*sqrt(3)/2);
    vertex(x+r/2,y-r*sqrt(3)/2);
    vertex(x+r,y);
    vertex(x+r/2,y+r*sqrt(3)/2);
    vertex(x-r/2,y+r*sqrt(3)/2);
    vertex(x-r,y);
    vertex(x-r/2,y-r*sqrt(3)/2);
    endShape();
  }
}

int isBetweenHC(int x,int a,int b) {
  int i;
  if (a<=x && x<=b)
    return 1;
  else return 0;
}

int isNeighbourHC(hexHC a,hexHC b) {
  int w,ok=0;
  if (a.i%2==0) {
    for (w=0;w<6 && ok==0;w++)
      if (isBetweenHC(a.i+DX[w],0,nmax-1)==1 && isBetweenHC(a.j+DY[w],0,mmax-1)==1 && a.i+DX[w]==b.i && a.j+DY[w]==b.j)
        ok=1;
  }
  else {
    for (w=0;w<6 && ok==0;w++)
      if (isBetweenHC(a.i+DX2[w],0,nmax-1)==1 && isBetweenHC(a.j+DY2[w],0,mmax-1)==1 && a.i+DX2[w]==b.i && a.j+DY2[w]==b.j)
        ok=1;
  }  
  return ok;
}

void realFallHC() {
  int i,j,ok=0;
  for (i=0;i<nmax;i++)
    for (j=mmax-1;j>=0;j--)
      if (target[i][j]>0) {
        target[i][j]-=vel;
        hexagons[i][j].y+=vel;
        ok=1;
      }
      else if (target2[i][j]!=j) {
        hexagons[i][target2[i][j]].c=hexagons[i][j].c;
        hexagons[i][target2[i][j]].cc=hexagons[i][j].cc;
        hexagons[i][target2[i][j]].ok=1;
        hexagons[i][target2[i][j]].time=TIME;
        hexagons[i][target2[i][j]].r=RR;
        hexagons[i][j].ok=0;
        hexagons[i][j].time=0;
      }
  if (ok==0) FALL=0;
}

void initializeHC() {
  
  if (color1==color(42,157,143)) {
    color1=color(219, 50, 77);
    color2=color(42, 30, 92);
    color3=color(255, 200, 87);
    color4=color(24, 200, 215);
    c12=color(189, 20, 47);
    c22=color(12, 0, 62);
    c32=color(225, 170, 57);
  }
  else {
    color1=color(42,157,143);
    color2=color(255,222,114);
    color3=color(231,111,81);
    color4=color(244,162,97);
    c12=color(12,127,113);
    c22=color(225,182,84);
    c32=color(201,81,51);
  }

  s1=new hexHC(margin,margin/2,margin/6,nmax,mmax);
  s1.c=color1;
  s1.cc=c12;
  s1.r=margin/6*4/2;
  s2=new hexHC(margin*4,margin/2,margin/6,nmax,mmax);
  s2.c=color2;
  s2.cc=c22;
  s2.r=margin/6*4/2;
  s3=new hexHC(margin*7,margin/2,margin/6,nmax,mmax);
  s3.c=color3;
  s3.cc=c32;
  s3.r=margin/6*4/2;
  
  score1=0;
  score2=0;
  score3=0;
  
  mscore1=0;
  mscore2=0;
  mscore3=0;
  
  nmax=int((width-2*margin-2*RR)/RR*2/3)+1;
  mmax=int((height-2*margin-2*RR)/RR/sqrt(3)+1);
  if (margin+RR+(nmax-1)*RR*3/2+margin+RR+RR/2<width) nmax++;
  
  DX[0]=-1; DY[0]=-1;
  DX[1]=0;  DY[1]=-1;
  DX[2]=1;  DY[2]=-1;
  DX[3]=1; DY[3]=0;
  DX[4]=0;  DY[4]=1;
  DX[5]=-1;  DY[5]=0;
  
  DX2[0]=-1; DY2[0]=1;
  DX2[1]=-1;  DY2[1]=0;
  DX2[2]=0;  DY2[2]=-1;
  DX2[3]=1; DY2[3]=0;
  DX2[4]=1;  DY2[4]=1;
  DX2[5]=0;  DY2[5]=1;
  
  int i,j;
  
  for (i=0;i<nmax;i++)
    for (j=0;j<mmax;j++) {
      if (i%2==0)
        hexagons[i][j]=new hexHC(margin+RR+i*RR*3/2,margin+RR+j*RR*sqrt(3),RR,i,j);
      else
        hexagons[i][j]=new hexHC(margin+RR+i*RR*3/2,margin+RR+j*RR*sqrt(3)+RR*sqrt(3)/2,RR,i,j);
      use[i][j]=0;
      if (hexagons[i][j].c==color1) mscore1++;
      else if (hexagons[i][j].c==color2) mscore2++;
      else if (hexagons[i][j].c==color3) mscore3++;
    }
    score1=mscore1;
    score2=mscore2;
    score3=mscore3;
    
}