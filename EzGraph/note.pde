int temaSelectat=-1;
int okda2=0;

void note() {
   if(!getData09 && idNOTE3==-1){
      getData09 = true;
      getTestNotesDatesByUserId(IDUSER);
      nrNoteTest=noteTest.length;
   }
   else if(idNOTE3!=-1){
      getData09 = true;
      getTestNotesDatesByUserId(idNOTE3);
      nrNoteTest=noteTest.length;
   }
      int i;

   	background(c7);
      image(fundal1,0,0);

   	oxx1=R*4;
   	oxy1=height/7*6-R*2;
   	oxx2=width-R*8; //sageata ox (orizontal)
   	oxy2=height/7*6-R*2;

   	oyx1=R*5;
   	oyy1=height/7*6+R-R*2;
   	oyx2=R*5; //sageata oy (vertical)
   	oyy2=height/4-R*2;

   	strokeWeight(1);
   	stroke(-1);

   	line(oxx1,oxy1,oxx2,oxy2);
   	line(oyx1,oyy1,oyx2,oyy2);

   	line(oxx2,oxy2,oxx2-R,oxy2-R); //sageata ox
   	line(oxx2,oxy2,oxx2-R,oxy2+R);

   	line(oyx2,oyy2,oyx2-R,oyy2+R); //sageata oy
   	line(oyx2,oyy2,oyx2+R,oyy2+R);

   	textSize(R);
   	text("Data",oxx2+R,oxy1-R,R*3,R*2);
   	text("Nota",oyx2-R*3/2,oyy2-R*2,R*3,R*2);

   	float v,v2=12,v3;
   	float w=(oxx2-oxx1-2*R)/(nrNoteTest+2);
   	float h=-(oyy2-oyy1-2*R)/15;
   	float medie=0;

   	fill(-1);
   	textSize(R/2);
	stroke(256,0,256);
   	for (i=1;i<=10;i++) {
   		v=oyx1;
   		v3=oxy1-i*h;
   		text(str(i),oyx1-R*3/2,oxy1-i*h-R,R*3/2,R*3/2);
   		//line(oxx1,v3,oxx2,v3);
   		while (v+v2<oxx2) {
   			line(v,v3,v+v2/3,v3);
   			v+=v2;
   		}
   	}

   	noStroke();
   	for (i=0;i<nrNoteTest;i++) {
   		if (noteTest[i]<5) fill(256,0,0);
   		else if (noteTest[i]<8) fill(256,256,0);
   		else fill(0,256,0);
         if (isBetween(oyx1+(i+1)*w,oyx1+(i+1)*w+w/2,mouseX) && isBetween(oxy1-noteTest[i]*h,oxy1-noteTest[i]*h+noteTest[i]*h,mouseY)) {
            if (mousePressed && delay==0) {
               delay=DELAY;
               notePanou=new panouDr(width-R*7,R*6,R*7,R*7,teste[i]+"\nNota: "+noteTest[i]+"\n"+zile[i]);
            
               testSelectat=i;
            }
            fill(255, 0, 255);
         }
         if (testSelectat==i)
            fill(255, 0, 255);
         rect(oyx1+(i+1)*w,oxy1-noteTest[i]*h,w/2,noteTest[i]*h);
	     	fill(-1);

	  	/*pushMatrix();
	  	translate(oyx1+(i+1)*w-R/3,oxy1+R*4);
	  	rotate(-PI/2);
	  	text(zile[i],0,0,R*4,R*3/2);
	  	translate(0,0);
	  	popMatrix();*/

   		if (isBetween(oyx1+(i+1)*w,oyx1+(i+1)*w+w/2,mouseX) && isBetween(oxy1-noteTest[i]*h,oxy1-noteTest[i]*h+noteTest[i]*h,mouseY))
	   		text(str(int(noteTest[i])),oyx1+(i+1)*w,oxy1-noteTest[i]*h-R*3/2,w/2,R*3/2);

	   	medie+=noteTest[i];
   	}

   	medie/=nrNoteTest;

   	textSize(R);
   	fill(-1);
   	textAlign(LEFT,CENTER);
   	text("Rata reusita: "+str(medie),R*14,R*5);
   	drawing dr=new drawing(R*12,R*5,R,medie);
   	dr.display();
      //rect(oyx1+(i+1)*w,oxy1-noteTest[i]*h,w/2,noteTest[i]*h);
      if (testSelectat!=-1) {
         i=testSelectat;
         stroke(-1);
         strokeWeight(1);
         line(oyx1+(i+1)*w+w/2/2,oxy1+R/2/3,oyx1+(i+1)*w+w/2/2,oxy1+R*2/3+R/2/3);
         line(oyx1+(i+1)*w+w/2/2,oxy1+R/2/3,oyx1+(i+1)*w+w/2/2+R/2/3,oxy1+R/2/3+R/3);
         line(oyx1+(i+1)*w+w/2/2,oxy1+R/2/3,oyx1+(i+1)*w+w/2/2-R/2/3,oxy1+R/2/3+R/3);
      }
      notePanou.display();
}