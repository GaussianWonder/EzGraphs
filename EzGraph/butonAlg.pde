class butonAlg {
	float x,y,w,h,y2,x2,w2;
	int tip; //1-start/stop 2-auto/manual 3-inainte
	int tip2;
	int number;

	butonAlg(float xx,float yy,float ww,float hh,int tipp,int nr) {
		x=xx;
		y=yy;
		y2=yy;
		w=ww;
		h=hh;
		tip=tipp;
		tip2=1;
		number=nr;
		x2=x+w-h;
		w2=h;
	}

	void update() {
		if (currentModule==1)
			y=y2+menu.bars[lessonActive-1].lesson.scrolled;
		else  if (currentModule==2)
			y=y2+menuOrientate.bars[lessonActive-1].lesson.scrolled;
		else  if (currentModule==4)
			y=y2+menuD.bars[lessonActive-1].lesson.scrolled;
	}

	void display() {
		update();
		noStroke();
		/*if (tip==4) {
			if (isBetween(x2,x2+w2,mouseX) && isBetween(y,y+h,mouseY)) {
					fill(62, 234, 45);
				}
				else
					fill(42, 214, 25);
				rect(x2,y,w2,h);
				strokeWeight(w2/8);
				stroke(-1);
				line(x2+w2/2,y+w2/8,x2+w2/2,y+h-w2/8*4);
				line(x2+w2/2,y+h-w2/8*4,x2+w2/2-w2/4,y+h-w2/8*4-w2/4);
				line(x2+w2/2,y+h-w2/8*4,x2+w2/2+w2/4,y+h-w2/8*4-w2/4);
				line(x2+w2/2+w2/4,y+h-w2/8*2,x2+w2/2+w2/4,y+h-w2/8*2);
				fill(-1);
				textAlign(CENTER,CENTER);
				textSize(h/2);
				text("Download:",x,y,w-w2,h);
		}*/
		if (!alg || alg && nrLess!=number) {
			if (tip==1) {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y,y+h,mouseY)) {
					fill(62, 234, 45);
					if (mousePressed && delay==0 && !alg) {
						delay=DELAY;
						alg=true;
						nrLess=number;
						animatieAlg();
					}
				}
				else
					fill(42, 214, 25);
				rect(x2,y,w2,h);
				fill(-1);
				triangle(x2+w2/4,y+w2/6,x2+w2/4,y+h-w2/6,x2+w2-w2/6,y+h/2);
				fill(-1);
				textAlign(CENTER,CENTER);
				textSize(h/2);
				text("Start alg:",x,y,w-w2,h);
			}
			else if (tip==2) {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y,y+h,mouseY)) {
					fill(194, 108, 256);
					if (mousePressed && delay==0 && !alg) {
						delay=DELAY;
						tip2=-tip2;
					}
				}
				else
					fill(174, 88, 239);
				rect(x2,y,w2,h);
				fill(-1);
				//if (tip2==1) {
					strokeWeight(w2/8);
					stroke(-1);
					line(x2+w2/9,y+h/2,x2+w2-w2/9,y+h/2);
					line(x2+w2/2,y+w2/9,x2+w2/2,y+h-w2/9);
					line(x2+w2/2-(w2-w2/9*2)/2/sqrt(2),y+h/2-(w2-w2/9*2)/2/sqrt(2),
						x2+w2/2+(w2-w2/9*2)/2/sqrt(2),y+h/2+(w2-w2/9*2)/2/sqrt(2));
					line(x2+w2/2+(w2-w2/9*2)/2/sqrt(2),y+h/2-(w2-w2/9*2)/2/sqrt(2),
						x2+w2/2-(w2-w2/9*2)/2/sqrt(2),y+h/2+(w2-w2/9*2)/2/sqrt(2));
					noStroke();
					fill(-1);
					ellipse(x2+w2/2,y+h/2,w2-w2/9*3,w2-w2/9*3);
					if (isBetween(x2,x2+w2,mouseX) && isBetween(y,y+h,mouseY)) fill(194, 108, 256);
					else fill(174, 88, 239);
					ellipse(x2+w2/2,y+h/2,w2-w2/9*5,w2-w2/9*5);
					fill(-1);
					ellipse(x2+w2/2,y+h/2,w2-w2/9*7,w2-w2/9*7);
				/*}
				else {
					fill(-1);
					rect(x2+w2/12,y+h/2,w2-w2/12*5+w2/12/2,h/2-w2/12);
					strokeWeight(w2/12);
					stroke(-1);
					line(x2+w2/12+w2/12/2,y+h/2,x2+w2/12+w2/12/2,y+w2/12);
					line(x2+w2/12*3+w2/12/2,y+h/2,x2+w2/12*3+w2/12/2,y+w2/12);
					line(x2+w2/12*5+w2/12/2,y+h/2,x2+w2/12*5+w2/12/2,y+w2/12);
					line(x2+w2/12*7+w2/12/2,y+h/2,x2+w2/12*7+w2/12/2,y+w2/12);
					line(x2+w2/12*8,y+h-w2/12*2,x2+w2/12*11,y+h/2-w2/12*3);

				}*/
				if (tip2!=1) {
					strokeWeight(w2/8);
					stroke(256,0,0);
					line(x2,y,x2+w2,y+h);
				}
				noStroke();
				fill(-1);
				textSize(h/2);
				textAlign(CENTER,CENTER);
				if (tip2==1) text("Automat:",x,y,w-w2,h);
				else text("Manual:",x,y,w-w2,h);
			}
		}
		else  {
			if (tip==1) {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y,y+h,mouseY)) {
					fill(256, 39, 39);
					if (mousePressed && delay==0) {
						delay=DELAY;
						alg=false;
						stopAlg=true;
						init();
					}
				}
				else
					fill(247, 19, 19);
				rect(x2,y,w2,h);
				fill(-1);
				rect(x2+w2/5,y+w2/6,w2/5,h-w2/5*2);
				rect(x2+w2/5*3,y+w2/6,w2/5,h-w2/5*2);
				fill(-1);
				textAlign(CENTER,CENTER);
				textSize(h/2);
				text("Stop alg:",x,y,w-w2,h);
			}
			else if (tip==3 && (currentModule==1 && menu.bars[lessonActive-1].b2[nrLess].tip2==-1 ||
						currentModule==2 && menuOrientate.bars[lessonActive-1].b2[nrLess].tip2==-1)) {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y,y+h,mouseY)) {
					fill(51, 199, 218);
					if (mousePressed && delay==0) {
						delay=DELAY;
						if (currentModule==1 && (lessonActive==4 || lessonActive==7/* || lessonActive==8*/) || currentModule==2 && lessonActive==3) {
					    	if (nrLess<4) {
					        	if (nrLantCurent<=nrLanturi2) {
					          		atribuireLant();
					          		timerAlg=TIMER2;
					        	}
					      	}
					    }
					    else {
						    ramas++;
						    if (ordine[ramas-1]==1)
						      ramasG++;
						    else ramasE++;
						}
					}
				}
				else
					fill(31, 179, 198);
				rect(x2,y,w2,h);
				fill(-1);
				stroke(-1);
				strokeWeight(w2/8);
				line(x2+w2/6,y+h/2,x2+w2-w2/6,y+h/2);
				line(x2+w2-w2/6,y+h/2,x2+w2-w2/6-w2/6,y+h/2-w2/6);
				line(x2+w2-w2/6,y+h/2,x2+w2-w2/6-w2/6,y+h/2+w2/6);
				noStroke();
				fill(-1);
				textSize(h/2);
				textAlign(CENTER,CENTER);
				text("Pasul urm:",x,y,w-w2,h);
			}
		}
	}
}