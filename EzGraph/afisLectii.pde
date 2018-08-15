//lectieProf l1;

void afisLectii() {
	//l1=new lectieProf(R*3,R*6,width-R*6,R*15, "adwfawfaw","Lectie1","autor1",3.3);
	int i;
    background(c7);
    image(fundal1,0,0);
    //l1.display();
    for (i=0;i<nLectii;i++)
    	lectiiProf[i].display();
    scrollbarLectii.display();
}

float lungimeLectii() {
	int i;
	if (nLectii>=1) return lectiiProf[nLectii-1].y+lectiiProf[nLectii-1].h+R*3;
	else return 0;
}