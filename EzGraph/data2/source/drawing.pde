class drawing {
	float x,y,r,r1;
	int val;

	drawing(float xx,float yy,float rr,int vall) {
		val=vall;
		x=xx;
		y=yy;
		r=rr;
	}

	void display() {
		noStroke();
		if (val>=8) fill(0,256,0);
		else if (val>=5) fill(256,256,0);
		else fill(256,0,0);
		ellipse(x,y,r*2,r*2);
		fill(questions[0].c_Fill2);
		ellipse(x,y,(r-r/10)*2,(r-r/10)*2);
		if (val>=8) fill(0,256,0);
		else if (val>=5) fill(256,256,0);
		else fill(256,0,0);
		ellipse(x-r/2,y-r/2+r/5,r/7*2,r/7*2);
		ellipse(x+r/2,y-r/2+r/5,r/7*2,r/7*2);
		fill(questions[0].c_Fill2);
		ellipse(x-r/2,y-r/2+r/5,r/10*2,r/10*2);
		ellipse(x+r/2,y-r/2+r/5,r/10*2,r/10*2);
		if (val>=8) {
			fill(0,256,0);
			arc(x,y+r/8,r,r,0,PI);
			fill(questions[0].c_Fill2);
			arc(x,y+r/8-3,r-r/10,r-r/10,0,PI);
		}
		else if (val>=5) {
			fill(256,256,0);
			rect(x-r/2-r/8,y+r/5,r+r/4,r/10);
		}
		else {
			fill(256,0,0);
			arc(x,y+r/2,r,r,PI,2*PI);
			fill(questions[0].c_Fill2);
			arc(x,y+r/2+3,r-r/10,r-r/10,PI,2*PI);	
			fill(0,256,256);
			beginShape();
			vertex(x-r/2,y-r/2+r/5+r/7);
			vertex(x-r/2-r/12,y-r/2+r/5+r/4+r/7);
			vertex(x-r/2+r/12,y-r/2+r/5+r/4+r/7);
			endShape();
			arc(x-r/2,y-r/2+r/5+r/4-1+r/7,r/6,r/6,0,PI);
		}
	}

}
