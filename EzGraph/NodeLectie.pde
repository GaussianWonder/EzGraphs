class NodeLectie extends ObjGraf{
	PVector addPos = new PVector(0, 0);
	int index;
	boolean active = true;
	float initSz;

	NodeLectie(PVector pos, color c, float w, float h, float anim, int i, color hov){
		super(pos, c, w, h, anim);
		initSz = w;
		index = i;
	}

	void display(){
		if(active){
			ellipseMode(RADIUS);
			stroke(c5_o);
			strokeWeight(R/5);
			fill(c2);
			ellipse(addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH);

			noStroke();
			fill(255);
    		textSize(R);
			textAlign(CENTER, CENTER);
			text((index + 1) + "", addPos.x + basePos.x, addPos.y + basePos.y);
		}
	}

	void update(){
		if(active){ 
			animate();
			ellipseMode(RADIUS);
			if(isHovered(mouseX, mouseY)) seekSize(initSz * 1.35, initSz * 1.35);
			else seekSize(initSz, initSz);
		}
	}

	void mouseEvents(){

	}

	boolean isHovered(float x, float y){
		return(dist(basePos.x + addPos.x, basePos.y + addPos.y, mouseX, mouseY) < baseW);
	}

}