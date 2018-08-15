int[] viz=new int[200];
int[] coada=new int[200];
int[] lant2=new int[200];
int[][] lantFinal=new int[200][200];
int nrLanturi2,nrLungLant,nrLantCurent;
int[][] compConexe=new int[200][200];
int nrCompConexe;
color[] culoriComp={color(256,0,0),color(256, 256, 60),color(0, 256, 256),color(0, 256, 0),color(256, 0, 256),
	color(250, 190, 190),color(255, 250, 200),color(240, 50, 230),color(230, 190, 255)};

void animatieAlg() {
	int i,j;
	if (currentModule==1) //neorientate
		switch (lessonActive) {
			case 3: { //df si bf la neorientate
				if (nrLess==0) { //df
					init();
					dfAlg(nod);
					break;
				}
				else if (nrLess==1) { //bf
					init();
					bfAlg(nod);
					break;
				}
				break;
			}
			case 4: { //lant ciclu la neorientate
				if (nrLess==0) { //lant
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									viz[i]=1;
									//lantAlg(i,j,1);
									lantAlg2(i,1);
									viz[i]=0;
								}
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaMuchie(lantFinal[0][i],noduri[ng2-1]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
					break;
				}
				else if (nrLess==1) { //ciclu
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									viz[i]=1;
									//lantAlg(i,j,1);
									ciclu(i,1);
									viz[i]=0;
								}
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaMuchie(lantFinal[0][i],noduri[ng2-1]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
					break;
				}
				break;
			}
			case 5: { //conexitate
				init();
				for (i=0;i<nGrafs;i++)
					if (grafs[i].active)
						if (viz[i]==0) {
							dfAlg(i);
							for (j=0;j<ng2;j++)
								compConexe[nrCompConexe][j+1]=noduri[j];
							compConexe[nrCompConexe][0]=ng2;
							//culoriComp[nrCompConexe]=color(random(0,2.99999999999)*128,random(0,2.99999999999)*128,random(0,2.99999999999)*128);
							ng2=0;
							nrCompConexe++;
						}
				nt2=1;
				break;
			}
			case 7: { //grafuri orientate hamiltoniene
				if (nrLess==0) { //ciclu ham
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									viz[i]=1;
									//lantAlg(i,j,1);
									cicluHam(i,1);
									viz[i]=0;
									break;
								}
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaMuchie(lantFinal[0][i],noduri[ng2-1]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
				}
				break;
			}
			case 8: { //grafuri neorientate euleriene
				if (nrLess==0) { //ciclu eul
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									//viz[i]=1;
									//lantAlg(i,j,1);
									cicluEul(i,1);
									//viz[i]=0;
									break;
								}
					ne2=ng2=nt2=0;
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ordine[nt2]=1;
						nt2++;
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaMuchie(lantFinal[0][i],noduri[ng2-1]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
				}
				break;
			}
			default: break;	
		}
	else if (currentModule==2) //orientate
		switch (lessonActive) {
			case 3: { //lant ciclu drum circuit la orientate
				if (nrLess==0) { //lant
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									viz[i]=1;
									//lantAlg(i,j,1);
									lantAlg2(i,1);
									viz[i]=0;
								}
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaMuchie(lantFinal[0][i],noduri[ng2-1]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
					break;
				}
				else if (nrLess==1) { //ciclu
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									viz[i]=1;
									//lantAlg(i,j,1);
									ciclu(i,1);
									viz[i]=0;
								}
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaMuchie(lantFinal[0][i],noduri[ng2-1]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
					break;
				}
				else if (nrLess==2) { //drum
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									viz[i]=1;
									//lantAlg(i,j,1);
									drum(i,1);
									viz[i]=0;
								}
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaArc(noduri[ng2-1],lantFinal[0][i]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
					break;
				}
				else if (nrLess==3) { //circuit
					init();
					for (i=0;i<nGrafs-1;i++)
						if (grafs[i].active) {
//							for (j=i+1;j<nGrafs;j++) 
//								if (grafs[j].active) {
									lant2[0]=i;
									viz[i]=1;
									//lantAlg(i,j,1);
									circuit(i,1);
									viz[i]=0;
								}
					if (nrLanturi2>=1) {
						noduri[ng2]=lantFinal[0][1];
						ng2++;
						for (i=2;i<=lantFinal[0][0];i++) {
							muchii[ne2]=cautaArc(noduri[ng2-1],lantFinal[0][i]);
							ne2++;
							ordine[nt2]=2;
							nt2++;
							noduri[ng2]=lantFinal[0][i];
							ng2++;
							ordine[nt2]=1;
							nt2++;
						}
						nrLantCurent=0;
						print('\n');
					}
					break;
				}
				break;
			}
			case 4: { //conexitate
				if (nrLess==0) {
					init();
					for (i=0;i<nGrafs;i++)
						if (grafs[i].active)
							if (viz[i]==0) {
								dfAlg(i);
								for (j=0;j<ng2;j++)
									compConexe[nrCompConexe][j+1]=noduri[j];
								compConexe[nrCompConexe][0]=ng2;
								//culoriComp[nrCompConexe]=color(random(0,2.99999999999)*128,random(0,2.99999999999)*128,random(0,2.99999999999)*128);
								ng2=0;
								nrCompConexe++;
							}
					nt2=1;
					break;
				}
				break;
			}
			default: break;	
		}
	timerAlg=TIMER2;
	alg=true;
	stopAlg=false;

}

void atribuireLant() {
	int i;
	ng2=nt2=ne2=0;
	noduri[ng2]=lantFinal[nrLantCurent][1];
	ng2++;
	for (i=2;i<=lantFinal[nrLantCurent][0];i++) {
		muchii[ne2]=cautaMuchie(lantFinal[nrLantCurent][i],noduri[ng2-1]);
		ne2++;
		ordine[nt2]=2;
		nt2++;
		noduri[ng2]=lantFinal[nrLantCurent][i];
		ng2++;
		ordine[nt2]=1;
		nt2++;
	}
	print((nrLantCurent),"   :    ");
	for (i=0;i<ng2;i++)
		print((noduri[i]+1),' ');
	print('\n');
	ramas=nt2;
	ramasG=ng2;
	ramasE=ne2;
	nrLantCurent++;
}

void sortareMatriceLant() {
	int i,j;
	int[] copie=new int[200];
}

int cautaArc(int x,int y) {
	int i,ok=-1;
	for (i=0;i<nEdges;i++)
		if (edges[i].active)
			if (edges[i].a==x && edges[i].b==y) {
				ok=i;
				break;
			}
	return ok;
}

int cautaMuchie(int x,int y) {
	int i,ok=-1;
	for (i=0;i<nEdges;i++)
		if (edges[i].active)
			if (edges[i].a==x && edges[i].b==y ||  edges[i].a==y && edges[i].b==x) {
				ok=i;
				break;
			}
	return ok;
}

void adaugaLant(int k) {
	int i;
	for (i=0;i<k;i++) {
		print((lant2[i]+1),' ');
		lantFinal[nrLanturi2][i+1]=lant2[i];
	}
	print('\n');
	lantFinal[nrLanturi2][0]=k;
	nrLanturi2++;
}

void circuit(int x,int k) {
	int i,j;
	for (j=0;j<nEdges;j++)
		if (edges[j].active)
			if (edges[j].a==lant2[k-1]) {
				if (viz[edges[j].b]==0) {
					lant2[k]=edges[j].b;
					viz[edges[j].b]=1;
					if (x!=lant2[k]) circuit(x,k+1);
					viz[edges[j].b]=0;
				}
				else if (x==edges[j].b && k>=3 && (x<lant2[1] && lant2[1]<lant2[k-1] || x>lant2[1] && lant2[1]>lant2[k-1])) {
					lant2[k]=x;
					adaugaLant(k+1);
				}
			}
}

void cicluEul(int x,int k) {
	int i,j;
	for (j=0;j<nEdges;j++)
		if (edges[j].active && viz[j]==0)
			if (edges[j].a==lant2[k-1]) {
				if (k<realNrEdges()) {
					lant2[k]=edges[j].b;
					viz[j]=1;
					if (x!=lant2[k]) cicluEul(x,k+1);
					viz[j]=0;

				}
				else if (/*k==realNrEdges() && */x==edges[j].b && x<lant2[1] && x<lant2[k-1] && k>=3 && lant2[1]<lant2[k-1]) {
					lant2[k]=x;
					adaugaLant(k+1);
				}
			}
			else if (edges[j].b==lant2[k-1]) {
				if (k<realNrEdges()) {
					lant2[k]=edges[j].a;

					viz[j]=1;
					if (x!=lant2[k]) cicluEul(x,k+1);
					viz[j]=0;
				}
				else if (/*k==realNrEdges() && */x==edges[j].a && x<lant2[1] && x<lant2[k-1] && k>=3 && lant2[1]<lant2[k-1]) {
					lant2[k]=x;
					adaugaLant(k+1);
				}
			}
}

void cicluHam(int x,int k) {
	int i,j;
	for (j=0;j<nEdges;j++)
		if (edges[j].active)
			if (edges[j].a==lant2[k-1]) {
				if (viz[edges[j].b]==0) {
					lant2[k]=edges[j].b;
					viz[edges[j].b]=1;
					if (x!=lant2[k]) cicluHam(x,k+1);
					viz[edges[j].b]=0;
				}
				else if (k==realNrNoduri() && x==edges[j].b && x<lant2[1] && x<lant2[k-1] && k>=3 && lant2[1]<lant2[k-1]) {
					lant2[k]=x;
					adaugaLant(k+1);
				}
			}
			else if (edges[j].b==lant2[k-1]) {
				if (viz[edges[j].a]==0) {
					lant2[k]=edges[j].a;
					viz[edges[j].a]=1;
					if (x!=lant2[k]) cicluHam(x,k+1);
					viz[edges[j].a]=0;
				}
				else if (k==realNrNoduri() && x==edges[j].a && x<lant2[1] && x<lant2[k-1] && k>=3 && lant2[1]<lant2[k-1]) {
					lant2[k]=x;
					adaugaLant(k+1);
				}
			}
}

void ciclu(int x,int k) {
	int i,j;
	for (j=0;j<nEdges;j++)
		if (edges[j].active)
			if (edges[j].a==lant2[k-1]) {
				if (viz[edges[j].b]==0) {
					lant2[k]=edges[j].b;
					viz[edges[j].b]=1;
					if (x!=lant2[k]) ciclu(x,k+1);
					viz[edges[j].b]=0;
				}
				else if (x==edges[j].b && x<lant2[1] && x<lant2[k-1] && k>=3 && lant2[1]<lant2[k-1]) {
					lant2[k]=x;
					adaugaLant(k+1);
				}
			}
			else if (edges[j].b==lant2[k-1]) {
				if (viz[edges[j].a]==0) {
					lant2[k]=edges[j].a;
					viz[edges[j].a]=1;
					if (x!=lant2[k]) ciclu(x,k+1);
					viz[edges[j].a]=0;
				}
				else if (x==edges[j].a && x<lant2[1] && x<lant2[k-1] && k>=3 && lant2[1]<lant2[k-1]) {
					lant2[k]=x;
					adaugaLant(k+1);
				}
			}
}

void drum(int x,int k) {
	int i,j;
	for (j=0;j<nEdges;j++)
		if (edges[j].active)
			if (edges[j].a==lant2[k-1] && viz[edges[j].b]==0) {
				lant2[k]=edges[j].b;
				viz[edges[j].b]=1;
				/*if (x<lant2[k] && (k<=2 || k>2 && lant2[1]<lant2[k-1]))*/ adaugaLant(k+1);
				drum(x,k+1);
				viz[edges[j].b]=0;
			}
}

void lantAlg2(int x,int k) {
	int i,j;
	for (j=0;j<nEdges;j++)
		if (edges[j].active)
			if (edges[j].a==lant2[k-1] && viz[edges[j].b]==0) {
				lant2[k]=edges[j].b;
				viz[edges[j].b]=1;
				if (x<lant2[k]/* && (k<=2 || k>2 && lant2[1]<lant2[k-1])*/) adaugaLant(k+1);
				lantAlg2(x,k+1);
				viz[edges[j].b]=0;
			}
			else if (edges[j].b==lant2[k-1] && viz[edges[j].a]==0) {
				lant2[k]=edges[j].a;
				viz[edges[j].a]=1;
				if (x<lant2[k]/* && (k<=2 || k>2 && lant2[1]<lant2[k-1])*/) adaugaLant(k+1);
				lantAlg2(x,k+1);
				viz[edges[j].a]=0;
			}
}

void init() {
	int i,j;
	ng2=ne2=nt2=ramasG=ramasE=ramas=nrLanturi2=nrLungLant=nrLantCurent=nrCompConexe=0;
	for (i=0;i<nGrafs;i++)
		noduri[i]=viz[i]=coada[i]=lant2[i]=0;
	for (i=0;i<nGrafs;i++)
		for (j=0;j<nGrafs;j++)
			lantFinal[i][j]=compConexe[i][j]=0;
	for (i=0;i<nEdges;i++)
		muchii[i]=0;
}

void bfAlg(int x) {
	int i,m=0,j;
	viz[x]=1;
	coada[m]=x;
	m++;
	noduri[ng2]=x;
	ordine[nt2]=1;
	ng2++;
	nt2++;
	for (i=0;i<m;i++)
		for (j=0;j<nEdges;j++)
			if (edges[j].active)
				if (edges[j].a==coada[i] && viz[edges[j].b]==0) {
					coada[m]=edges[j].b;
					m++;
					muchii[ne2]=j;
					ordine[nt2]=2;
					ne2++;
					nt2++;
					noduri[ng2]=edges[j].b;
					ordine[nt2]=1;
					ng2++;
					nt2++;
					viz[edges[j].b]=1;
				}
				else if (edges[j].b==coada[i] && viz[edges[j].a]==0) {
					coada[m]=edges[j].a;
					m++;
					muchii[ne2]=j;
					ordine[nt2]=2;
					ne2++;
					nt2++;
					noduri[ng2]=edges[j].a;
					ordine[nt2]=1;
					ng2++;
					nt2++;
					viz[edges[j].a]=1;
				}
}

void dfAlg(int x) {
	int i;
	viz[x]=1;
	noduri[ng2]=x;
	ordine[nt2]=1;
	ng2++;
	nt2++;
	for (i=0;i<nEdges;i++)
		if (edges[i].active)
			if (edges[i].a==x && viz[edges[i].b]==0) {
				muchii[ne2]=i;
				ordine[nt2]=2;
				ne2++;
				nt2++;
				dfAlg(edges[i].b);
			}
			else if (edges[i].b==x && viz[edges[i].a]==0) {
				muchii[ne2]=i;
				ordine[nt2]=2;
				ne2++;
				nt2++;
				dfAlg(edges[i].a);
			}
}

/*void lantAlg(int x,int y,int k) {
	int i,j;
	for (j=0;j<nEdges;j++)
		if (edges[j].active)
			if (edges[j].a==lant2[k-1] && viz[edges[j].b]==0) {
				lant2[k]=edges[j].b;
				viz[edges[j].b]=1;
				if (lant2[k]==y) adaugaLant(k+1);
				else lantAlg(x,y,k+1);
				viz[edges[j].b]=0;
			}
			else if (edges[j].b==lant2[k-1] && viz[edges[j].a]==0) {
				lant2[k]=edges[j].a;
				viz[edges[j].a]=1;
				if (lant2[k]==y) adaugaLant(k+1);
				else lantAlg(x,y,k+1);
				viz[edges[j].a]=0;
			}
}*/