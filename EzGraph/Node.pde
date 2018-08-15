class Node extends Obj{
	boolean toggle = false;
	int index;
	IntList vec;

	Node(PVector pos, color c, float sz, float anim, int i){
		super(pos, c, sz, anim);
		index = i;
		vec = new IntList();

		if(i!=0 && i!=nodeNum-1){
			if(tabSelected!=0){
				vec.append(i-1);
				vec.append(i+1);
			}
		}
		else if(i==0){
			if(tabSelected!=0)vec.append(i+1);
		}
		else{
			if(tabSelected!=0)vec.append(i-1);
		}
	}

	void display(){
		noStroke();
		fill(baseCol);
		ellipse(basePos.x, basePos.y, baseSize, baseSize);
		
		if(tabSelected==0){
			fill(255,255,255);
			textAlign(CENTER);
			textSize(40);
			text(index + 1, basePos.x, basePos.y + 10);
		}
	}

	void update(){
		animate();

		noStroke();

		if(toggle==false)seekColor(offGR);
		else seekColor(onGR);

		if(isHovered(mouseX, mouseY)){
			seekColor(hoverGR);
			seekDimension(SCL + SCL/5);
		}
		else seekDimension(SCL);
	}

	boolean isHovered(float x, float y){
		return(dist(x, y, basePos.x, basePos.y) <= baseSize);
	}

	void displayLines(){
		for(int n : vec){
			if(n>index){
				Node nod = nodes.get(n);

				strokeWeight(6);
				stroke(18, 166, 255);

				line(basePos.x, basePos.y, nod.basePos.x, nod.basePos.y);
			}
		}
	}

}