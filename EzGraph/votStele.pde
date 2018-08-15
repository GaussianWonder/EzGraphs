class votStele {
	float x,y,w,h,w2,w3;
	int val=0,val2=0,freeze;
	PImage img1,img2;

	votStele(float xx,float yy,int freezee) {
		x=xx;
		y=yy;
	  	img1=loadImage("steaPlina-01.png");
  		img2=loadImage("steaNeplina-01.png");
  		w=img1.width;
  		h=img1.height;
  		freeze=freezee;
	}

	void update() {
		w2=lerp(w2,w3,0.2);
	}

	void display() {
		float sc=0,yc=0;
		if (currentModule==25) {
			//sc=scrollbarModif.y2-scrollbarModif.y;
			sc=scrollbarComentarii.decateori*scrollbarComentarii.h4;
		}
		else if (currentModule==26) {
			//sc=scrollbarModif.y2-scrollbarModif.y;
			sc=scrollbarLectii.decateori*scrollbarLectii.h4;
		}
		else if (currentModule==27) {
			//sc=scrollbarModif.y2-scrollbarModif.y;
			sc=scrollbarLectie.decateori*scrollbarLectie.h4;
		}
		yc=y;
		y=yc-sc;
		
		int i;
		update();

		if (freeze==0)
			for (i=4;i>=0;i--)
				if (isBetween(x+i*w*3/2,x+i*w*3/2+w,mouseX) && isBetween(y,y+h,mouseY)) {
					val2=i+1;
					w3=i*w*3/2+w;
					if (mousePressed && delay==0) {
						if (val==i+1) val=0;
						else val=i+1;

						if(db.connect() && currentModule==27 && lectieCurentaprof.vs.val!=0){
							db.query("SELECT * FROM lectiedata WHERE lectieName='"+lectieCurentaprof.s2+"' AND lectieData='"+lectieCurentaprof.s+"'");
							if(db.next()){
								float scr = db.getFloat("scor");
								int nrVotes = db.getInt("nrVotes") + 1;
								int lectieID = db.getInt("lectieID");

								float NOTAFINALA = ( ((scr * (nrVotes-1)) + lectieCurentaprof.vs.val) / float(nrVotes) );
								
								db.execute("UPDATE lectiedata SET scor="+NOTAFINALA+", nrVotes="+nrVotes+" WHERE lectieID="+lectieID);
							}
						}
						
						val2=val;
						w3=i*w*3/2+w;
						delay=DELAY;
					}
					break;
				}

		if (isBetween(x,x+4*w*3/2+w,mouseX) && isBetween(y,y+h,mouseY) && freeze==0) {
			for (i=0;i<5;i++)
				if (i*w*3/2+w<=w2)
					image(img1,x+i*w*3/2,y);
				else if (i*w*3/2<w2 && (i+1)*w*3/2>w2)
					image(img1.get(0,0,int(min(w,w2-i*w*3/2)),int(h)),x+i*w*3/2,y);
				else
					image(img2,x+i*w*3/2,y);
		}
		else {
			val2=val;
			w3=val*w*3/2+w;
			for (i=0;i<val;i++)
				image(img1,x+i*w*3/2,y);
			for (i=val;i<5;i++)
				image(img2,x+i*w*3/2,y);
		}
		y=yc;
	}
}