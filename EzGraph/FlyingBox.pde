class FlyingBox extends Obj{
	boolean isProf = false;
	textbox clasa_pass;
	textbox clasa_name;
	buton2 submit;

	FlyingBox(PVector pos, color c, float sz, float anim, boolean isPrf, int cnct){
		super(pos, c, sz, anim);
		isProf = isPrf;

		String nm;
		if(cnct==1)nm = "Conectare clasa";
		else if(cnct==2)nm = "Creare clasa";

		clasa_name = new textbox(pos.x + 6*R, pos.y + 4.5*R, width/8*3, R*2, R, 1, 0);
  		clasa_pass = new textbox(pos.x + 6*R, pos.y + 6.5*R, width/8*3, R*2, R, 1, 0);
  		submit = new buton2(pos.x + 2*R, pos.y + 8.5 * R, R*6 , parola.h,"Conectare clasa");
	}

	void display(){
		fill(baseCol);
		rect(basePos.x, basePos.y, width/2 - width/5, 8.5 * R);

		clasa_name.display();
		clasa_pass.display();
		submit.display();
	}

	void update(){
		animate();
		clasa_name.x = basePos.x;
		clasa_name.y = basePos.y;

		clasa_pass.x = basePos.x;
		clasa_pass.y = basePos.y;

		submit.x = basePos.x;
		submit.y = basePos.y;
	}

}