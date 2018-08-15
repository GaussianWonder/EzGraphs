String txt(String name) {
    String[] lines = loadStrings(name + ".txt");
    String prop = "\n\n\n\n";
    for(int i=0;i<lines.length; i++) {
      if (lines[i].length()>3 && lines[i].charAt(0)=='+' && lines[i].charAt(1)=='+' && lines[i].charAt(2)=='e' && lines[i].charAt(3)=='x') {
        //createExample(lines,i+1);
        break;
      }
      else 
        prop += lines[i] + '\n';
    }
    return prop;
}

void createExample(String[] s,int nr) {
  int a,b,x,y,n=0,n2=0;
  int i,j;
  for (i=0;i<s[nr].length();i++) {
    n=n*10+s[nr].charAt(i)-'0';
  }
  nr++;
  for (i=1;i<=n;i++) {
    j=0;
    x=y=0;
    while (s[nr].charAt(j)!=' ') {
      x=x*10+s[nr].charAt(j)-'0';
      j++;
    }
    j++;
    while (j<s[nr].length()) {
      y=y*10+s[nr].charAt(j)-'0';
      j++;
    }
    add_graf(x,y);
    nr++;
  }
  
  for (i=0;i<s[nr].length();i++)
    n2=n2*10+s[nr].charAt(i)-'0';
  nr++;
  for (i=1;i<=n2;i++) {
    j=0;
    a=b=0;
    while (s[nr].charAt(j)!=' ') {
      a=a*10+s[nr].charAt(j)-'0';
      j++;
    }
    j++;
    while (j<s[nr].length()) {
      b=b*10+s[nr].charAt(j)-'0';
      j++;
    }
    if (a<200 && b<200) add_edge(grafs[a-1],grafs[b-1]);
    nr++;
  }
  
}