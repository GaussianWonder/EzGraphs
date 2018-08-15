class FormHolder{
	int currIndex;
	TextBox notification;
	ArrayList<Form> forms;
	ArrayList<ToggleBtn> buttons;

	FormHolder(){
		forms = new ArrayList<Form>();
		buttons = new ArrayList<ToggleBtn>();

		for(int i=0;i<3;i++)
			buttons.add(new ToggleBtn(new PVector(10 + (width/8 + 10) * i, 10), color(61, 164, 171), width/8, height/8, 0.2, color(14, 154, 167), color(0, 166, 166), int(i + 1) + "", i + 1));
		notification = new TextBox(new PVector(10 + (width/8 + 10) * 3, 10), color(120, 120, 120), width - (5 * 10 + 3 * width/8), height/8, 0.2, color(150, 150, 150), color(160, 160, 160), 30, 30, 1);
		
		currIndex = 1;
		buttons.get(0).toggle = true;
	}

	void show(){
		for(Form f : forms){
			f.update();
			f.display();
			if(currIndex > f.index) f.seekPosition(new PVector(-width, 20 + height/8));
			else if(currIndex < f.index) f.seekPosition(new PVector(width + 10, 20 + height/8));
			else f.seekPosition(new PVector(10, 20 + height/8));
		}

		fill(49, 54, 142);
		rect(0, 0, width, height/6);

		for(ToggleBtn btn : buttons){
			btn.update();
			btn.display();
		}
		notification.update();
		textAlign(CENTER, CENTER);
		//notification.display();
	}

	void addForm(Form f){
		forms.add(f);
	}

	void mouseEvents(){
		for(ToggleBtn btn : buttons)
			if(btn.isHovered(mouseX, mouseY)){
				btn.toggle = true;
				currIndex = btn.index;
			}
		for(ToggleBtn btn : buttons)
			if(btn.index != currIndex)
				btn.toggle = false;

		/*if(notification.isHovered(mouseX, mouseY))		//+ Sum bonus shit
			notification.focus = true;
		else notification.focus = false;*/

		for(Form f : forms)
			f.mouseEvents();
	}

	void keyEvents(){
		for(Form f : forms)
			f.keyEvents();
	}
}