float[] desx=new float[600];
float[] desy=new float[600];
float[] desr=new float[600];
float[] desx2=new float[600];
float[] desy2=new float[600];
float[] desr2=new float[600];
int[] perechiDesen1=new int[60000];
int[] perechiDesen2=new int[60000];
int nrDes=0,nrDes2=0,okDes=0;

float nod1x=1140;
float nod2x=1140;
float nod3x=1050;
float nod4x=1220;
float nod5x=1270;
float nod6x=1270;
float nod7x=1220;
float nod8x=1220;

float nod1y=110;
float nod2y=240;
float nod3y=175;
float nod4y=175;
float nod5y=110;
float nod6y=240;
float nod7y=40;
float nod8y=290;

////////////////////////////////

float nnod1x=1130;
float nnod2x=1130;
float nnod3x=1270;
float nnod4x=1050;
float nnod5x=1050;
float nnod6x=1050;
float nnod7x=1230;
float nnod8x=1180;

float nnod1y=500;
float nnod2y=650;
float nnod3y=575;
float nnod4y=575;
float nnod5y=500;
float nnod6y=650;
float nnod7y=575;
float nnod8y=575;

////////////////////////////////

float nnnod1x=1140;
float nnnod2x=1140;
float nnnod3x=1050;
float nnnod4x=1220;
float nnnod5x=1270;
float nnnod6x=1270;
float nnnod7x=1220;
float nnnod8x=1220;

float nnnod1y=110;
float nnnod2y=240;
float nnnod3y=175;
float nnnod4y=175;
float nnnod5y=110;
float nnnod6y=240;
float nnnod7y=40;
float nnnod8y=290;

int nnnok=1;
float nnnr=10;

void updateGraf(float a,float b,int x) {
	if (x==1) {
		nnnod1x=lerp(nnnod1x,a,0.2);
		nnnod1y=lerp(nnnod1y,b,0.2);
	}
	else if (x==2) {
		nnnod2x=lerp(nnnod2x,a,0.2);
		nnnod2y=lerp(nnnod2y,b,0.2);
	}
	else if (x==3) {
		nnnod3x=lerp(nnnod3x,a,0.2);
		nnnod3y=lerp(nnnod3y,b,0.2);
	}
	else if (x==4) {
		nnnod4x=lerp(nnnod4x,a,0.2);
		nnnod4y=lerp(nnnod4y,b,0.2);
	}
	else if (x==5) {
		nnnod5x=lerp(nnnod5x,a,0.2);
		nnnod5y=lerp(nnnod5y,b,0.2);
	}
	else if (x==6) {
		nnnod6x=lerp(nnnod6x,a,0.2);
		nnnod6y=lerp(nnnod6y,b,0.2);
	}
	else if (x==7) {
		nnnod7x=lerp(nnnod7x,a,0.2);
		nnnod7y=lerp(nnnod7y,b,0.2);
	}
	else if (x==8) {
		nnnod8x=lerp(nnnod8x,a,0.2);
		nnnod8y=lerp(nnnod8y,b,0.2);
	}
}

void drawGraf() {
	fill(-1,100);
	stroke(-1,100);
	strokeWeight(2);

	ellipse(nnnod1x,nnnod1y,nnnr*2,nnnr*2);
	ellipse(nnnod2x,nnnod2y,nnnr*2,nnnr*2);
	ellipse(nnnod3x,nnnod3y,nnnr*2,nnnr*2);
	ellipse(nnnod4x,nnnod4y,nnnr*2,nnnr*2);
	ellipse(nnnod5x,nnnod5y,nnnr*2,nnnr*2);
	ellipse(nnnod6x,nnnod6y,nnnr*2,nnnr*2);
	ellipse(nnnod7x,nnnod7y,nnnr*2,nnnr*2);
	ellipse(nnnod8x,nnnod8y,nnnr*2,nnnr*2);

	line(nnnod1x,nnnod1y,nnnod2x,nnnod2y);
	line(nnnod1x,nnnod1y,nnnod3x,nnnod3y);
	line(nnnod1x,nnnod1y,nnnod4x,nnnod4y);
	line(nnnod1x,nnnod1y,nnnod7x,nnnod7y);
	line(nnnod1x,nnnod1y,nnnod8x,nnnod8y);
	line(nnnod3x,nnnod3y,nnnod2x,nnnod2y);
	line(nnnod8x,nnnod8y,nnnod2x,nnnod2y);
	line(nnnod4x,nnnod4y,nnnod2x,nnnod2y);
	line(nnnod7x,nnnod7y,nnnod2x,nnnod2y);
	line(nnnod5x,nnnod5y,nnnod4x,nnnod4y);
	line(nnnod6x,nnnod6y,nnnod4x,nnnod4y);

	if (dist(nnnod1x,nnnod1y,mouseX,mouseY)<nnnr || dist(nnnod2x,nnnod2y,mouseX,mouseY)<nnnr || dist(nnnod3x,nnnod3y,mouseX,mouseY)<nnnr || 
		dist(nnnod4x,nnnod4y,mouseX,mouseY)<nnnr || dist(nnnod5x,nnnod5y,mouseX,mouseY)<nnnr || dist(nnnod6x,nnnod6y,mouseX,mouseY)<nnnr || 
		dist(nnnod7x,nnnod7y,mouseX,mouseY)<nnnr || dist(nnnod8x,nnnod8y,mouseX,mouseY)<nnnr)
		nnnok*=(-1);

	if (nnnok==1) {
		updateGraf(nod1x,nod1y,1);
		updateGraf(nod2x,nod2y,2);
		updateGraf(nod3x,nod3y,3);
		updateGraf(nod4x,nod4y,4);
		updateGraf(nod5x,nod5y,5);
		updateGraf(nod6x,nod6y,6);
		updateGraf(nod7x,nod7y,7);
		updateGraf(nod8x,nod8y,8);
	}
	else {
		updateGraf(nnod1x,nnod1y,1);
		updateGraf(nnod2x,nnod2y,2);
		updateGraf(nnod3x,nnod3y,3);
		updateGraf(nnod4x,nnod4y,4);
		updateGraf(nnod5x,nnod5y,5);
		updateGraf(nnod6x,nnod6y,6);
		updateGraf(nnod7x,nnod7y,7);
		updateGraf(nnod8x,nnod8y,8);
	}
}

void drawStart() {
	//text(mouseX+" "+mouseY,mouseX,mouseY);
	fill(-1,13);
    beginShape();
    vertex(R*40,0);
    vertex(R*50,0);
    vertex(R*11,height);
    vertex(R*41,height);
    endShape();

    fill(234, 255, 10,13);
    beginShape();
    vertex(R*2,0);
    vertex(R*15,0);
    vertex(R*10,height);
    vertex(R*6,height);
    endShape();

    fill(256,0,0,13);
    beginShape();
    vertex(-R*45,0);
    vertex(-R*10,0);
    vertex(R*46,height);
    vertex(R*37,height);
    endShape();

    fill(0,256,0,13);
    beginShape();
    vertex(R*9,0);
    vertex(R*20	,0);
    vertex(R*30,height);
    vertex(R*45,height);
    endShape();

    fill(176, 244, 66,13);
    beginShape();
    vertex(R*28,0);
    vertex(R*39	,0);
    vertex(0,height);
    vertex(-R*2,height);
    endShape();

    //drawGraf();
    drawDesen();
}

void drawDesen() {
	int i,ok,j;
	float x;
	noStroke();
	fill(-1,12);
	for (i=0;i<200;i++) {
		if (nrDes<=200) {
			nrDes++;
			ok=0;
			while (ok==0) {
				ok=1;
				desx[i]=desx2[i]=random(0,width);
				desy[i]=desy2[i]=random(0,height);
				desr[i]=desr2[i]=random(10,20);
				for (j=0;j<i;j++)
					if (dist(desx[i],desy[i],desx[j],desy[j])<50) {
						ok=0;
						break;
					}
			}
		}
		desx[i]=lerp(desx[i],desx2[i],0.2);
		desy[i]=lerp(desy[i],desy2[i],0.2);
		desr[i]=lerp(desr[i],desr2[i],0.2);
		ellipse(desx[i],desy[i],desr[i],desr[i]);
	}
	stroke(-1,12);
	strokeWeight(1);
	for (i=0;i<199;i++)
		for (j=i+1;j<200;j++)
			if (dist(desx[i],desy[i],desx[j],desy[j])<100)
				line(desx[i],desy[i],desx[j],desy[j]);

	if (mousePressed && delay==0) {
		delay=DELAY;
		for (i=0;i<200;i++) {
			ok=0;
			while (ok==0) {
				ok=1;
				desx2[i]=random(0,width);
				desy2[i]=random(0,height);
				desr2[i]=random(10,20);
				for (j=0;j<i;j++)
					if (dist(desx2[i],desy2[i],desx2[j],desy2[j])<50){//desr2[i]+desr2[j]) {
						ok=0;
						break;
					}
			}
		}
	}
}

void drawLinii() {
	int i,ok,j;
	float x;
	for (i=0;i<400;i++) {
		if (nrDes2<=400) {
			nrDes2++;
			ok=0;
			while (ok==0) {
				ok=1;
				desx[i]=random(0,width);
				desy[i]=random(0,height);
				desr[i]=random(10,20);
				if (i<200) {
					for (j=0;j<i;j++)
						if (dist(desx[i],desy[i],desx[j],desy[j])<50) {
							ok=0;
							break;
						}
				}
				else if (i<400) {
					for (j=200;j<i;j++)
						if (dist(desx[i],desy[i],desx[j],desy[j])<50) {
							ok=0;
							break;
						}
				}
			}
		}
	}
	if (okDes==0) {
		for (i=0;i<199;i++)
			for (j=i+1;j<200;j++)
				if (dist(desx[i],desy[i],desx[j],desy[j])<100) {
					perechiDesen1[okDes]=i;
					perechiDesen2[okDes]=j;
					okDes++;
				}

					//line(desx[i],desy[i],desx[j],desy[j]);
		for (i=200;i<399;i++)
			for (j=i+1;j<400;j++)
				if (dist(desx[i],desy[i],desx[j],desy[j])<100) {
					perechiDesen1[okDes]=i;
					perechiDesen2[okDes]=j;
					okDes++;
				}
					//line(desx[i],desy[i],desx[j],desy[j]);
	}
	strokeWeight(1);
	stroke(-1,20);
	for (i=0;i<okDes/2;i++)
		if (dist(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]])<100)
			line(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]]);
	stroke(-1,10);
	for (i=okDes/2;i<okDes;i++)
		if (dist(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]])<100)
			line(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]]);
}
