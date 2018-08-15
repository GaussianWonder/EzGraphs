class Obj{
	PVector basePos, seekPos;
	color baseCol, seekCol;
	float baseSize, seekSize;
	float animSpd;

	Obj(PVector pos, color c, float sz, float anim){
		basePos = new PVector(midW, midH);
		seekPos = new PVector(pos.x, pos.y);

		baseCol = c;
		seekCol = c;

		baseSize = 0.1;
		seekSize = sz;

		animSpd = anim;
	}

	void animate(){
		basePos.lerp(seekPos, animSpd);
		baseCol = lerpColor(baseCol, seekCol, animSpd);
		baseSize = lerp(baseSize, seekSize, animSpd);
	}

	void seekPosition(PVector pos){
		seekPos = new PVector(pos.x, pos.y);
	}

	void seekColor(color c){
		seekCol = c;
	}

	void seekDimension(float dim){
		seekSize = dim;
	}
}