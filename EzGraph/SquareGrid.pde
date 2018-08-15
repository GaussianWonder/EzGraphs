class Square extends Obj{
	boolean viz = false, active = false, solid = false, visible = true;

	Square(PVector pos, color c, float sz, float anim){
		super(pos, c, sz, anim);
	}

	void display(){
		fill(baseCol);
		if(solid)fill(42);
		noStroke();
		rect(basePos.x, basePos.y, baseSize, baseSize);
		stroke(42);
		strokeWeight(4);
		if(active)ellipse(basePos.x + baseSize/2, basePos.y + baseSize/2, baseSize/2, baseSize/2);
	}

	void update(){
		animate();
	}

}