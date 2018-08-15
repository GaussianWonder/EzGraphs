void bkt(int k,int[] x,int[] y,int n) {
  int i,j;
  for (i=0;i<nEdges;i++)
    if (edges[i].active) {
      if (edges[i].a==y[k-1] && (x[edges[i].b]==0 || k==n+1 && x[edges[i].b]==1)) {
        x[edges[i].b]=1;
        y[k]=edges[i].b;
        if (k<=n) bkt(k+1,x,y,n);
        else
          if (y[1]==y[n+1] && y[2]<y[n]) {
            sr+="  ";
            for (j=1;j<=n+1;j++)
              sr+=(y[j]+1)+" ";
            sr+="\n";
          }
        if (k<n+1)// || (k==n+1 && y[1]!=y[n+1]))
          x[edges[i].b]=0;
      }
      else if (edges[i].b==y[k-1] && (x[edges[i].a]==0 || k==n+1 && x[edges[i].a]==1)) {
        x[edges[i].a]=1;
        y[k]=edges[i].a;
        if (k<=n) bkt(k+1,x,y,n);
        else
          if (y[1]==y[n+1] && y[2]<y[n]) {
            sr+="  ";
            for (j=1;j<=n+1;j++)
              sr+=(y[j]+1)+" ";
            sr+="\n";
          }
        if (k<n+1)// || (k==n+1 && y[1]!=y[n+1]))
          x[edges[i].a]=0;
      }
    }
}

void bkt2(int k,int[] x,int[] y,int n) {
  int i,j;
  for (i=0;i<nEdges;i++)
    if (edges[i].active && x[i]==0) {
      if (edges[i].a==y[k-1]) {
        x[i]=1;
        y[k]=edges[i].b;
        if (k<n+1) bkt2(k+1,x,y,n);
        else
          if (y[1]==y[n+1] && y[2]<y[n]) {
            sr+="  ";
            for (j=1;j<=n+1;j++)
              sr+=(y[j]+1)+" ";
            sr+="\n";
          }
        x[i]=0;
      }
      else if (edges[i].b==y[k-1]) {
        x[i]=1;
        y[k]=edges[i].a;
        if (k<n+1) bkt2(k+1,x,y,n);
        else
          if (y[1]==y[n+1] && y[2]<y[n]) {
            sr+="  ";
            for (j=1;j<=n+1;j++)
              sr+=(y[j]+1)+" ";
            sr+="\n";
          }
        x[i]=0;
      }
    }
}

void rsd(int[] dr,int[] st,int x) {
  sr+=(x)+" ";
  if (st[x-1]>0) rsd(dr,st,st[x-1]);
  if (dr[x-1]>0) rsd(dr,st,dr[x-1]);
}

void srd(int[] dr,int[] st,int x) {
  if (st[x-1]>0) srd(dr,st,st[x-1]);
  sr+=(x)+" ";
  if (dr[x-1]>0) srd(dr,st,dr[x-1]);
}

void sdr(int[] dr,int[] st,int x) {
  if (st[x-1]>0) sdr(dr,st,st[x-1]);
  if (dr[x-1]>0) sdr(dr,st,dr[x-1]);
  sr+=(x)+" ";
}

void df(int[] x,int y,int nr) {
  int i;
  x[y]=nr;
  if (!isBetween(margTop+R+(nr-1)*90-45,margTop+R+(nr-1)*90+45,grafs[y].y))
    nivOk=0;
  for (i=0;i<nEdges;i++)
    if (edges[i].active)
      if (edges[i].a==y && x[edges[i].b]==0) {
        if (lessonActive==10 || lessonActive==11) df(x,edges[i].b,nr+1);
        else df(x,edges[i].b,nr);
      }
      else if (edges[i].b==y && x[edges[i].a]==0) {
        if (lessonActive==10 || lessonActive==11) df(x,edges[i].a,nr+1);
        else df(x,edges[i].a,nr);
      }
}

void dfdf(int[] x,int[] z,int y) {
  int i;
  x[val]=y;
  val++;
  z[y]=1;
  for (i=0;i<nEdges;i++)
    if (edges[i].active)
      if (edges[i].a==y && z[edges[i].b]==0)
        dfdf(x,z,edges[i].b);
      else if (edges[i].b==y && z[edges[i].a]==0)
        dfdf(x,z,edges[i].a);
}

void bfbf(int[] c,int[] z,int y) {
  int i,f=0;
  z[y]=1;
  c[0]=y;
  val++;
  while (f<val) {
    for (i=0;i<nEdges;i++)
      if (edges[i].active)
        if (edges[i].a==c[f] && z[edges[i].b]==0) {
          z[edges[i].b]=1;
          c[val]=edges[i].b;
          val++;
        }
        else if (edges[i].b==c[f] && z[edges[i].a]==0) {
          z[edges[i].a]=1;
          c[val]=edges[i].a;
          val++;
        }
    f++;
  }
}

void df2(int[] x,int y,int nr,int[] lant) { //lant
  int i;
  x[y]=1;
  lant[nr]=y;
  if (nr>=1 && lant[0]<lant[nr]) {
    sr+="  ";
    for (i=0;i<=nr;i++)
      sr+=(lant[i]+1)+" ";
    sr+="\n";
  }
  for (i=0;i<nEdges;i++)
    if (edges[i].active)
      if (edges[i].a==y && x[edges[i].b]==0)
        df2(x,edges[i].b,nr+1,lant);
      else if (edges[i].b==y && x[edges[i].a]==0)
        df2(x,edges[i].a,nr+1,lant);
  x[y]=0;
}
void df3(int[] x,int y,int nr,int[] lant) { //ciclu
  int i,j;
  x[y]=1;
  lant[nr]=y;
  for (i=0;i<nEdges;i++)
    if (edges[i].active) {
      if ((edges[i].a==lant[0] && edges[i].b==y || edges[i].b==lant[0] && edges[i].a==y) && nr>=2 && lant[1]<lant[nr] && lant[0]<lant[1]) {
      sr+="  ";
        for (j=0;j<=nr;j++)
          sr+=(lant[j]+1)+" ";
        sr+=(lant[0]+1);//+"mama";
        sr+="\n";
      }
      else if (edges[i].a==y && x[edges[i].b]==0 && edges[i].active)
        df3(x,edges[i].b,nr+1,lant);
      else if (edges[i].b==y && x[edges[i].a]==0 && edges[i].active)
        df3(x,edges[i].a,nr+1,lant);
    }
  x[y]=0;
}
void df4(int[] x,int y,int nr,int[] lant) { //drum
  int i;
  x[y]=1;
  lant[nr]=y;
  if (nr>=1 && lant[0]<lant[nr]) {
    sr+="  ";
    for (i=0;i<=nr;i++)
      sr+=(lant[i]+1)+" ";
    sr+="\n";
  }
  for (i=0;i<nEdges;i++)
    if (edges[i].active)
      if (edges[i].a==y && x[edges[i].b]==0)
        df4(x,edges[i].b,nr+1,lant);
  x[y]=0;
}
void df5(int[] x,int y,int nr,int[] lant) { //circuit
  int i,j;
  x[y]=1;
  lant[nr]=y;
  for (i=0;i<nEdges;i++)
    if (edges[i].active) {
      if (currentModule==2 && ((edges[i].b==lant[0] && edges[i].a==y) && nr>=2 && (lant[1]<lant[nr] && lant[0]<lant[1] || lant[1]>lant[nr] && lant[0]>lant[1]))) {
      sr+="  ";
        for (j=0;j<=nr;j++)
          sr+=(lant[j]+1)+" ";
        sr+=(lant[0]+1);
        sr+="\n";
      }
      else if (edges[i].a==y && x[edges[i].b]==0 && edges[i].active)
        df5(x,edges[i].b,nr+1,lant);
    }
  x[y]=0;
}

void rw(int[][] x) {
  int i,j,k;
  for (i=0;i<nEdges;i++)
    if (edges[i].active)
      x[edges[i].a][edges[i].b]=1;
  for (k=0;k<nGrafs;k++)
    for (i=0;i<nGrafs;i++)
      for (j=0;j<nGrafs;j++)
        if (x[i][j]==0) x[i][j]=x[i][k]*x[k][j];
}

void df6(int[] x,int y,int[][] a) {
  int i,j;
  for (i=0;i<nGrafs;i++) {
    if (grafs[i].active)
      if (a[i][y]==1 && a[y][i]==1 && i!=y) {
        x[i]=1;
        sr+=(i+1)+" ";
      }
  }
}
String sr;
int nivOk=1;
int val=0;

String getExample(int lessonActive) {
  String s="";
  sr="";
  int i,j,x=0,k,y,z,r1,r2,r3,r4;
  int[][] a=new int[max(nEdges,nGrafs)+5][max(nEdges,nGrafs)+5];
  int[] df=new int[max(nEdges,nGrafs)+5];
  int[] lant=new int[max(nEdges,nGrafs)+5];
  int[] t=new int[max(nEdges,nGrafs)+5];
  int[] desc=new int[max(nEdges,nGrafs)+5];
  int[] st=new int[max(nEdges,nGrafs)+5];
  int[] dr=new int[max(nEdges,nGrafs)+5];
  for (i=0;i<max(nEdges,nGrafs)+5;i++)
    df[i]=lant[i]=t[i]=dr[i]=st[i]=desc[i]=0;
  for (i=0;i<max(nEdges,nGrafs)+5;i++)
    for (j=0;j<max(nEdges,nGrafs)+5;j++)
      a[i][j]=0;
  switch (lessonActive) {
    case 1: {
      if (currentModule==1) {
        s+="Gradele nodurilor sunt:\n";
        for (i=0;i<nGrafs;i++) 
          if (grafs[i].active) {
            x=0;
            for (j=0;j<nEdges;j++)
              if (edges[j].active)
                if (edges[j].a==i || edges[j].b==i) x++;
            s+="  d("+(i+1)+") = "+x;
            if (x==0) s+="  =>  "+(i+1)+" este varf izolat";
            s+="\n";
          }
        }
        else if (currentModule==2) {
          s+="Gradele nodurilor sunt:\n";
          for (i=0;i<nGrafs;i++) 
            if (grafs[i].active) {
              x=0; y=0;
              for (j=0;j<nEdges;j++)
                if (edges[j].active)
                  if (edges[j].a==i) x++;
                  else if(edges[j].b==i) y++;
              s+="  d+("+(i+1)+") = "+x+"   ";
              s+="  d-("+(i+1)+") = "+y;
              if (x==0 && y==0) s+="  =>  "+(i+1)+" este varf izolat";
              s+="\n";
            }
        }
        break;
    }
    case 2: {
      if (currentModule==1) {
        s="Matricea de adiacenta a grafului de mai sus este:\n";
        for (i=0;i<nGrafs;i++) 
          if (grafs[i].active) {
            s+="  ";
            for (j=0;j<nGrafs;j++)
              if (grafs[j].active) {
                x=0;
                for (k=0;k<nEdges;k++)
                  if (edges[k].active && (edges[k].a==i && edges[k].b==j || edges[k].a==j && edges[k].b==i)) {
                    x=1;
                    break;
                  }
                s+=x+" ";
              }
              else s+="/ ";
              s+='\n';
          }
          else {
            s+="  ";
            for (j=0;j<nGrafs;j++)
              s+="/ ";
            s+="\n";
          }
        s+="Vectorul de muchii al grafului de mai sus este:\n";
        s+="  ";
        for (k=0;k<nEdges;k++)
          if (edges[k].active)
            s+="["+(edges[k].a+1)+","+(edges[k].b+1)+"] ";
        s+='\n';
        s+="Lista de adiacenta a grafului de mai sus este:\n";
        for (i=0;i<nGrafs;i++) 
          if (grafs[i].active) {
            s+="  "+(i+1)+": ";
            x=0;
            for (j=0;j<nGrafs;j++)
              if (grafs[j].active) {
                for (k=0;k<nEdges;k++)
                  if (edges[k].active && (edges[k].a==i && edges[k].b==j || edges[k].a==j && edges[k].b==i)) {
                    x=1;
                    s+=(j+1)+" ";
                    break;
                  }
              }
              if (x==0) s+="/ ";
              s+='\n';
          }
      }
      else if (currentModule==2) {
        s+="Matricea de adiacenta a grafului de mai sus este:\n";
        for (i=0;i<nGrafs;i++) 
          if (grafs[i].active) {
            s+="  ";
            for (j=0;j<nGrafs;j++)
              if (grafs[j].active) {
                x=0;
                for (k=0;k<nEdges;k++)
                  if (edges[k].active && edges[k].a==i && edges[k].b==j) {
                    x=1;
                    break;
                  }
                s+=x+" ";
              }
              else s+="/ ";
              s+='\n';
          }
          else {
            s+="  ";
            for (j=0;j<nGrafs;j++)
              s+="/ ";
            s+="\n";
          }
        s+="Vectorul de muchii al grafului de mai sus este:\n";
        s+="  ";
        for (k=0;k<nEdges;k++)
          if (edges[k].active)
            s+="("+(edges[k].a+1)+","+(edges[k].b+1)+") ";
        s+='\n';
        s+="Matricea de incidenta a grafului de mai sus este:\n";
        for (i=0;i<nGrafs;i++) 
          if (grafs[i].active) {
            s+="  ";
            for (j=0;j<nGrafs;j++)
              if (grafs[j].active) {
                x=0;
                for (k=0;k<nEdges;k++)
                  if (edges[k].active && edges[k].a==i && edges[k].b==j) {
                    x=1;
                    break;
                  }
                  else if (edges[k].active && edges[k].a==j && edges[k].b==i) {
                    x=-1;
                    break;
                  }
                if (x==-1) s+=x+"  ";
                else s+=x+"    ";
              }
              else s+="/ ";
              s+='\n';
          }
          else {
            s+="  ";
            for (j=0;j<nGrafs;j++)
              s+="/ ";
            s+="\n";
          }
        s+="Lista de adiacenta a grafului de mai sus este:\n";
        for (i=0;i<nGrafs;i++) 
          if (grafs[i].active) {
            s+="  "+(i+1)+": ";
            x=0;
            for (j=0;j<nGrafs;j++)
              if (grafs[j].active) {
                for (k=0;k<nEdges;k++)
                  if (edges[k].active && edges[k].a==i && edges[k].b==j) {
                    x=1;
                    s+=(j+1)+" ";
                    break;
                  }
              }
              if (x==0) s+="/";
              s+='\n';
          }
      }
      break;
    }
    case 3: {
      if (currentModule==1) {
        x=-1;
        val=0;
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active) {
            val=0;
            s+="DF("+(i+1)+"): ";
            for (j=0;j<nGrafs;j++)
              t[j]=0;
            dfdf(df,t,i);
            for (j=0;j<val;j++)
              s+=(df[j]+1)+" ";
            s+="\n";
          }
         s+="\n";
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active) {
            val=0;
            s+="BF("+(i+1)+"): ";
            for (j=0;j<nGrafs;j++)
              t[j]=0;
            bfbf(df,t,i);
            for (j=0;j<val;j++)
              s+=(df[j]+1)+" ";
            s+="\n";
          }
      }
      else if (currentModule==2) {
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active)
            df3(df,i,0,lant);
        s+="Cicluri elementare:\n"+sr;
        sr="";
        
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active)
            df5(df,i,0,lant);
        s+="Circuite elementare:\n"+sr;
        sr="";
        
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active)
            df2(df,i,0,lant);
        s+="Lanturi elementare:\n"+sr;
        sr="";
        
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active)
            df4(df,i,0,lant);
        s+="Drumuri elementare:\n"+sr;
      }
      break;
    }
    case 4: {
      if (currentModule==1) {
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active)
            df3(df,i,0,lant);
        s+="Cicluri elementare:\n"+sr;
        sr="";
        for (i=0;i<nGrafs;i++)
          if (/*df[i]==0 && */grafs[i].active)
            df2(df,i,0,lant);
        s+="Lanturi elementare:\n"+sr;
      }
      else if (currentModule==2) {
        x=0;
        for (i=0;i<nGrafs;i++)
          if (df[i]==0 && grafs[i].active) {
            x++;
            df(df,i,x);
            s+="Componenta conexa "+x+":\n  ";
            for (j=0;j<nGrafs;j++)
              if (df[j]==x && grafs[j].active)
                s+=(j+1)+" ";
            s+="\n";
          }
        s+="------------\n";
        x=0;
        for (i=0;i<nGrafs;i++) df[i]=0;
        rw(a);
        for (i=0;i<nGrafs;i++)
          if (df[i]==0 && grafs[i].active) {
            x++;
            sr="";
            s+="Componenta tare conexa "+x+":\n  ";
            s+=(i+1)+" ";
            df6(df,i,a);
            s+=sr+"\n";
          }
      }
      break;
    }
    case 5: {
      if (currentModule==1) {
        x=0;
        for (i=0;i<nGrafs;i++)
          if (df[i]==0 && grafs[i].active) {
            x++;
            df(df,i,x);
            s+="Componenta conexa "+x+":\n  ";
            for (j=0;j<nGrafs;j++)
              if (df[j]==x && grafs[j].active)
                s+=(j+1)+" ";
            s+="\n";
          }
        if (x==1) s+="Graful este conex.";
      }
      else if (currentModule==2) {
        x=1;
        for (i=0;i<nGrafs && x==1;i++)
          if (grafs[i].active)
            for (j=i+1;j<nGrafs;j++)
              if (grafs[j].active) {
                y=0;
                for (k=0;k<nEdges;k++)
                  if (edges[k].active)
                    if (edges[k].a==i && edges[k].b==j)
                      y++;
                    else if (edges[k].a==j && edges[k].b==i)
                      y++;
                if (y==0 || y==2) {
                  x=0;
                  break;
                }
              }
        if (x==1) s+="Graful orientat de mai sus este graf turneu.";
        else s+="Graful orientat de mai sus nu este graf turneu.";
      }
      break;
    }
    case 6: {
      if (currentModule==1) {
        x=1;
        for (i=0;i<nEdges;i++)
          if (edges[i].active)
            if ((grafs[edges[i].a].x<width-(width-margLeft)/2 && grafs[edges[i].b].x>=width-(width-margLeft)/2)
              || (grafs[edges[i].a].x>width-(width-margLeft)/2 && grafs[edges[i].b].x<=width-(width-margLeft)/2)) {
              if (df[edges[i].a]==0)
                if (df[edges[i].b]==0) {
                  if (grafs[edges[i].a].x<width-(width-margLeft)/2) {
                    df[edges[i].a]=1;
                    df[edges[i].b]=-1;
                  }
                  else if (grafs[edges[i].a].x>width-(width-margLeft)/2) {
                    df[edges[i].a]=-1;
                    df[edges[i].b]=1;
                  }
                }
                else df[edges[i].a]=-df[edges[i].b];
              else
                if (df[edges[i].b]==0)
                  df[edges[i].b]=-df[edges[i].a];
                else
                  if (df[edges[i].a]*df[edges[i].b]==1) {
                    x=0;
                    break;
                  }
              }
              else {
                x=2;
                break;
              }
        if (x==1) {
          s+="Graful de mai sus este bipartit.\n";
          s+="A: ";
          for (i=0;i<nGrafs;i++)
            if (df[i]==1 || grafs[i].x<width-(width-margLeft)/2) s+=(i+1)+" ";
          s+="\n";
          s+="B: ";
          for (i=0;i<nGrafs;i++)
            if (df[i]==-1 || grafs[i].x>=width-(width-margLeft)/2) s+=(i+1)+" ";
        }
        else if (x==0)
            s+="Graful de mai sus nu este bipartit.\n";
        else s+="Verifica aranjarea nodurilor!";
      }
      break;
    }
    case 7: {
      if (currentModule==1) {
        x=0;
        y=-1;
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active) {
            x++;
            if (y==-1) y=i;
          }
        if (x<3) s+="Graful de mai sus nu este un graf hamiltonian";
        else {
          df[y]=1;
          t[1]=y;
          bkt(2,df,t,x);
          if (sr=="") s+="Graful de mai sus nu este un graf hamiltonian";
          else {
            s+="Graful de mai sus este un graf hamiltonian\n";
            s+="Cicluri hamiltoniene:\n";
            s+=sr;
          }
        }
      }
      break;
    }
    case 8: {
      if (currentModule==1) {
        y=-1;
        x=0;
        for (i=0;i<nGrafs;i++)
          if (grafs[i].active && y==-1) {
            y=i;
            break;
          }
        for (i=0;i<nEdges;i++)
          if (edges[i].active) x++;
        t[1]=y;
        bkt2(2,df,t,x);
        if (sr=="") s+="Graful de mai sus nu este un graf eulerian";
        else {
          s+="Graful de mai sus este un graf eulerian\n";
          s+="Cicluri euleriene:\n";
          s+=sr;
        }
      }
      break;
    }
    case 9: {
      if (currentModule==1) {
        if (nGrafs>=1) {
          x=1;
          df(df,0,x);
          x=1; y=0; j=0;
          for (i=0;i<nGrafs;i++)
            if (grafs[i].active) {
              j++;
              if (df[i]==0) {
                x=0;
                break;
              }
            }
          if (x==1) {
            x=0;
            for (i=0;i<nEdges;i++)
              if (edges[i].active)
                x++;
            if (x==j-1) s+="Graful de mai sus este arbore.";
            else s+="Graful de mai sus nu este arbore.";
          }
          else s+="Graful de mai sus nu este arbore.";
        }
      }
      break;
    }
    case 10: {
      if (currentModule==1) {
        if (nGrafs>=1) {
          nivOk=1;
          x=1; y=-1; j=0;
          for (i=0;i<nGrafs;i++)
            if (grafs[i].active)
              if (isBetween(margTop+R-45,margTop+R+45,grafs[i].y))
                if (y==-1) {
                  y=i;
                  t[y]=-1;
                }
                else x=0;
          if (y!=-1 && x!=0) 
            df(df,y,x);
          for (i=0;i<nGrafs;i++)
            if (grafs[i].active) {
              j++;
              if (df[i]==0) {
                x=0;
                break;
              }
            }
          if (nivOk==0) s+="Verifica asezarea pe nivele! Nu uita sa fiul unui nod trebuie sa fie pe nivelul nodului + 1!\n";
          if (x==1) {
            x=0;
            for (i=0;i<nEdges;i++)
              if (edges[i].active)
                x++;
            if (x==j-1 && nivOk==1) {
              s+="Graful de mai sus este arbore cu radacina "+(y+1)+".";
              for (i=0;i<nGrafs;i++) {
                y=0;
                if (grafs[i].active)
                  for (j=0;j<nEdges;j++)
                    if (edges[j].active)
                      if (edges[j].a==i) {
                        if (df[i]+1==df[edges[j].b]) {
                          if (y==0)
                            s+="\n  Fii lui "+ (i+1) + " sunt: ";
                          y=1;
                          t[edges[j].b]=i;
                          s+=(edges[j].b+1)+" ";
                        }
                      }
                      else if (edges[j].b==i)
                        if (df[i]+1==df[edges[j].a]) {
                          if (y==0)
                            s+="\n  Fii lui "+ (i+1) + " sunt: ";
                          y=1;
                          t[edges[j].a]=i;
                          s+=(edges[j].a+1)+" ";
                        }
              }
              s+="\n  T = [";
              for (i=0;i<nGrafs;i++)
                if (grafs[i].active) s+=(t[i]+1)+" ";
                else s+="/ ";
              s+="]";
              x=0;
              for (i=0;i<nGrafs;i++) {
                y=0;
                if (grafs[i].active)
                  for (j=0;j<nEdges;j++)
                    if (edges[j].active)
                      if (edges[j].a==i) {
                        if (df[i]+1==df[edges[j].b]) {
                          y=1;
                          break;
                        }
                      }
                      else if (edges[j].b==i)
                        if (df[i]+1==df[edges[j].a]) {
                          y=1;
                          break;
                        }
                if (y==0) {
                  if (x==0)
                    s+="\n  Frunze: ";
                  x=1;
                  s+=(i+1)+ " ";
                }
              }

            }
            else s+="Graful de mai sus nu este arbore.";
          }
          else s+="Graful de mai sus nu este arbore.";
        }
      }
      break;
    }
    case 11: {
      if (currentModule==1) {
        if (nGrafs>=1) {
          x=1; y=-1; j=0; r3=0;
          for (i=0;i<nGrafs;i++)
            if (grafs[i].active)
              if (isBetween(margTop+R-45,margTop+R+45,grafs[i].y))
                if (y==-1) {
                  y=i;
                  r3=i;
                  t[y]=-1;
                  desc[y]=0;
                }
                else x=0;
          nivOk=1;
          if (y!=-1 && x!=0) 
            df(df,y,x);
          for (i=0;i<nGrafs;i++)
            if (grafs[i].active) {
              j++;
              if (df[i]==0) {
                x=0;
                break;
              }
            }
          if (nivOk==0) s+="Verifica asezarea pe nivele! Nu uita sa fiul unui nod trebuie sa fie pe nivelul nodului + 1!\n";
          if (x==1) {
            x=0;
            for (i=0;i<nEdges;i++)
              if (edges[i].active)
                x++;
            if (x==j-1 && nivOk==1) {
              s+="Graful de mai sus este arbore cu radacina "+(y+1)+".";
              for (i=0;i<nGrafs;i++) {
                y=0;
                r1=r2=i;
                if (grafs[i].active)
                  for (j=0;j<nEdges;j++)
                    if (edges[j].active)
                      if (edges[j].a==i) {
                        if (df[i]+1==df[edges[j].b]) {
                          if (y==0) r1=edges[j].b;
                          else r2=edges[j].b;
                          y++;
                          t[edges[j].b]=i;
                        }
                      }
                      else if (edges[j].b==i)
                        if (df[i]+1==df[edges[j].a]) {
                          if (y==0) r1=edges[j].a;
                          else r2=edges[j].a;
                          y++;
                          t[edges[j].a]=i;
                        }
                if (y>2) {
                  x=0;
                  break;
                }
                else if (y==1) {
                  if (grafs[r1].x<grafs[i].x) {
                    st[i]=r1+1;
                    desc[r1]=-1;
                  }
                  else {
                    dr[i]=r1+1;
                    desc[r1]=1;
                  }
                }
                else if (y==2) {
                  if (grafs[r1].x<grafs[r2].x) {
                    st[i]=r1+1;
                    dr[i]=r2+1;
                    desc[r1]=-1;
                    desc[r2]=1;
                  }
                  else {
                    st[i]=r2+1;
                    dr[i]=r1+1;
                    desc[r1]=1;
                    desc[r2]=-1;
                  }
                }
              }
              if (x!=0) {
                s+="\nGraful de mai sus este arbore binar.";
                s+="\n  T = [";
                for (i=0;i<nGrafs;i++)
                  if (grafs[i].active) s+=(t[i]+1)+" ";
                  else s+="/ ";
                s+="]";
                s+="\n  DESC = [";
                for (i=0;i<nGrafs;i++)
                  if (grafs[i].active) s+=(desc[i])+" ";
                  else s+="/ ";
                s+="]";
                s+="\n  ST = [";
                for (i=0;i<nGrafs;i++)
                  if (grafs[i].active) s+=(st[i])+" ";
                  else s+="/ ";
                s+="]";
                s+="\n  DR = [";
                for (i=0;i<nGrafs;i++)
                  if (grafs[i].active) s+=(dr[i])+" ";
                  else s+="/ ";
                s+="]";
                s+="\nRSD: ";
                rsd(dr,st,r3+1);
                s+=sr;
                sr="";
                s+="\nSRD: ";
                srd(dr,st,r3+1);
                s+=sr;
                sr="";
                s+="\nSDR: ";
                sdr(dr,st,r3+1);
                s+=sr;
                sr="";
              }
              else s+="\nGraful de mai sus nu este arbore binar.";
            }
            else s+="Graful de mai sus nu este arbore.";
          }
          else s+="Graful de mai sus nu este arbore.";
        }
      }
      break;
    }
  }
  ex.scrollbar.nrlines=max(0,s.length()/5);
  ex.scrollbar.h2=ex.h/ex.scrollbar.nrlines;
  return s;
}

class example {
  float x,y,w,h,scrolled=0;
  color c=c8;
  String s="";
  scrollbar scrollbar;
  
  example(float xx,float yy,float ww,float hh) {
    x=xx;
    y=yy;
    w=ww;
    h=hh;
    scrollbar=new scrollbar(x+w-R/2,y,R/2,h,2);
    scrollbar.nrlines=max(0,s.length()/5-6);
    scrollbar.h2=h/scrollbar.nrlines;
  }
  
  void display() {
    noStroke();
    fill(c);
    rect(x,y,w,h);
    textSize(R/2);
    fill(-1);
    textAlign(LEFT,LEFT);
    text(s,x+R,y+R+scrolled,w-R/2*3,s.length()*20);
    scrollbar.display();
  }
}