void afisComentarii() {
	int i;
    background(c7);
    image(fundal1,0,0);
    for (i=0;i<nComentarii;i++)
    	comentarii[i].display();
    scrollbarComentarii.display();
}

float lungimeCom() {
	int i;
	if (nComentarii>=1) return comentarii[nComentarii-1].y+comentarii[nComentarii-1].h+R*3;
	else return 0;
}