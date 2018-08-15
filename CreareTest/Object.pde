class Obj{
	PVector basePos, seekPos;
	color baseCol, seekCol;
	float baseW, baseH, seekW, seekH;
	float animSpd;

	Obj(PVector pos, color c, float w, float h, float anim){
		basePos = new PVector(midW, midH);
		seekPos = new PVector(pos.x, pos.y);

		int r = int(red(c) - 25), g = int(green(c) - 25), b = int(blue(c) - 25);
		if(r<0)r=0;
		if(g<0)g=0;
		if(b<0)b=0;
		baseCol = color(r, g, b);	//darker than c
		seekCol = c;

		baseH = 0.1;
		baseW = 0.1;
		seekW = w;
		seekH = h;

		animSpd = anim;
	}

	void animate(){
		basePos.lerp(seekPos, animSpd);
		baseCol = lerpColor(baseCol, seekCol, animSpd);
		baseW = lerp(baseW, seekW, animSpd);
		baseH = lerp(baseH, seekH, animSpd);
	}

	void seekPosition(PVector pos){
		seekPos = new PVector(pos.x, pos.y);
	}

	void seekColor(color c){
		seekCol = c;
	}

	void seekSize(float w, float h){
		seekW = w;
		seekH = h;
	}

	void seekWidth(float w){
		seekW = w;
	}

	void seekHeight(float h){
		seekH = h;
	}
}