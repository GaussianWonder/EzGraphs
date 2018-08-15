class ToggleBtn extends Obj{	//toggle in mousePressed();
	PVector addPos;
	int index;
	boolean toggle = false;
	String name;
	color normal, hover, active;
	float baseAngle = 50, seekAngle = 0;

	ToggleBtn(PVector pos, color c, float w, float h, float anim, color hov, color press, String text, int i){
		super(pos, c, w, h, anim);
		normal = c;
		hover = hov;
		active = press;

		name = text;

		index = i;

		addPos = new PVector(0, 0);
	}

	void display(){
		noStroke();
		fill(baseCol);
		rect(addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH, baseAngle);
		
		textSize(round(baseH / 4));
		textAlign(CENTER, CENTER);
		fill(42);

		text(name, addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH);
	}

	void update(){
		this.animate();
		baseAngle = lerp(baseAngle, seekAngle, animSpd);

		if(toggle){
			seekColor(active);
			seekAngle = 50;
		}
		else if(isHovered(mouseX, mouseY)){
			seekColor(hover);
			seekAngle = 50;
		}
		else {
			seekColor(normal);
			seekAngle = 0;
		}
	}

	boolean isHovered(float x, float y){
		return(x>=addPos.x + basePos.x && x<=addPos.x + basePos.x + baseW && y>=addPos.y + basePos.y && y<=addPos.y + basePos.y + baseH);
	}
}
