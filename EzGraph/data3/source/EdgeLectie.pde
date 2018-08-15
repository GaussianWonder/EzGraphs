class EdgeLectie{
	color normal, hover, baseCol, seekCol;
	Obj sPoint, fPoint, controlPS, controlPF;
	int sIndex, fIndex;

	EdgeLectie(NodeLectie nod, NodeLectie vec, int _n, int _v, color norm, color hov){
		sPoint = new Obj(new PVector(nod.addPos.x + nod.basePos.x, nod.addPos.y + nod.basePos.y), norm, 4, 4, 0.15);
		fPoint = new Obj(new PVector(vec.addPos.x + vec.basePos.x, vec.addPos.y + vec.basePos.y), norm, 4, 4, 0.15);

		normal = baseCol = seekCol = norm;
		hover = hov;

		sIndex = _n;
		fIndex = _v;
	}
	
	void displayOriented(){
		//println("AM AFISAT");
		noFill();
		float w3, w11, w22, q, w1, w2;
		int x1 = int(sPoint.basePos.x), y1 = int(sPoint.basePos.y), x2 = x1, y2 = y1, x3 = int(fPoint.basePos.x), y3 = int(fPoint.basePos.y), x4 = x3, y4 = y3;
		if (x1!=x4) w3=atan((y1-y4)/(x1-x4));
	    else w3=PI/2;
	    if (y4<y1) w3=-w3;

	    PVector v1 = new PVector(x4-x1, y4-y1);
	    PVector v2 = new PVector(width, 0);
	    w3=radians(PVector.angleBetween(v2, v1));

	    if (y4<y1) w3=-w3;
	    w3=w3*180/PI;

	    q=dist(x1,y1,x4,y4)/3;
	    w1=q*cos(w3-PI/8);
	    w2=q*sin(w3-PI/8);
	    w11=q*cos(w3+PI/8+PI);
	    w22=q*sin(w3+PI/8+PI);

	    if (currForm.forms.get(1).grafLectie.indexBtn==5) {
		    stroke(256,0,0);
			strokeWeight(1);
		    line(x4,y4,x2,y2);
		}

	    stroke(c1);
		strokeWeight(6);
		bezier(x1,y1,x1+w1,y1+w2,x4+w11,y4+w22,x4,y4);

	    q=R;
	    w1=q*cos(w3+PI+PI/8);
	    w2=q*sin(w3+PI+PI/8);

	    w11=R*cos(w3+PI/10+PI+PI/8);
	    w22=R*sin(w3+PI/10+PI+PI/8);
	    line(x4+w1,y4+w2,x4+w1+w11,y4+w2+w22);

	    w11=R*cos(w3-PI/5+PI+PI/8);
	    w22=R*sin(w3-PI/5+PI+PI/8);
	    line(x4+w1,y4+w2,x4+w1+w11,y4+w2+w22);
	}

	void displayUnoriented(){
		stroke(c1);
		strokeWeight(6);
		int x1 = int(sPoint.basePos.x), y1 = int(sPoint.basePos.y), x2 = x1, y2 = y1, x3 = int(fPoint.basePos.x), y3 = int(fPoint.basePos.y), x4 = x3, y4 = y3;
		line(x1, y1, x4, y4);
	}

	void update(){
		if(currForm.forms.get(1).grafLectie!=null){
			NodeLectie nod = currForm.forms.get(1).grafLectie.nodes.get(sIndex), vec = currForm.forms.get(1).grafLectie.nodes.get(fIndex);
			sPoint.seekPosition(new PVector(nod.addPos.x + nod.basePos.x, nod.addPos.y + nod.basePos.y));
			fPoint.seekPosition(new PVector(vec.addPos.x + vec.basePos.x, vec.addPos.y + vec.basePos.y));
			
		}
		sPoint.animate();
		fPoint.animate();

		baseCol = lerpColor(baseCol, seekCol, 0.15);
		if(isOnLine(sPoint.basePos, fPoint.basePos, new PVector(mouseX, mouseY))) seekCol = hover;
		else seekCol = normal;
	}

	boolean isOnLine(PVector startP, PVector endP, PVector mouseP){
		PVector closeP = new PVector();			//Can be returned as reference -> closest point to segment
		PVector line = PVector.sub(endP, startP);
		float ERR = 6;							//size of border / stroke
	  	float l2 = line.magSq();
	  	if (l2 == 0.0) {
	    	closeP.set(startP);
	    	return false;
	  	}

	  	PVector dstLine = PVector.sub(mouseP, startP);
	  	float t = dstLine.dot(line)/l2;

	  	dstLine.normalize();
	  	closeP.set(line);
	  	closeP.mult(t);
	  	closeP.add(startP);

	  	float d = PVector.dist(mouseP, closeP);
	  	if (t >= 0 && t <= 1 && d <= ERR) return true;
	  	else return false;
	}

	boolean exist(int s, int f){
		return (sIndex == s && fIndex == f);
	}

	int oneEnd(int nod){
		if(sIndex == nod) return fIndex;
		else if(fIndex == nod) return sIndex;
		return -1;
	}

	void indexReplacement(int nod){
		if(sIndex >= nod)sIndex--;
		if(fIndex >= nod)fIndex--;
	}

}
