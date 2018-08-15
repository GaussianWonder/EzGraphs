class Form extends Obj{
	int index;
	ArrayList<TextBox> txtboxes = new ArrayList<TextBox>();
	ArrayList<ToggleBtn> btns = new ArrayList<ToggleBtn>();
	txtbx numeLectie, utilizator, parola;

	MultipleSelectionDropDown tipLectie;	//Nume + Tip Lectie
	GrafLectie grafLectie;
	txtbx txtb;

	Form(PVector pos, color c, float w, float h, float anim, int i){
		super(pos, c, w, h, anim);
		index = i;

		switch(index){
			case 1:{	//Nume + Tip Lectie
				tipLectie = new MultipleSelectionDropDown(new PVector(pos.x, pos.y), c6, c6_o, 30, (width - 20), height/10, 0.2);
				tipLectie.addMainTab("Tip Lectie", 1);

				tipLectie.mainTabs.get(0).addSubTab("Grafuri Neorientate", 1);
				tipLectie.mainTabs.get(0).addSubTab("Grafuri Orientate", 2);
				//tipLectie.mainTabs.get(0).addSubTab("Amandoua", 3);


				txtboxes.add(new TextBox(new PVector(2*seekW/6, 2*seekH/8), color(255, 100, 100), 2*seekW/6, seekH/8, 0.2, color(255, 120, 120), color(255, 140, 140), 30, 30, 1));
				txtboxes.get(0).data = "NUME LECTIE";
				numeLectie=new txtbx(2*seekW/6, 2*seekH/8,2*seekW/6, seekH/8,R,1,0);
				break;
			}
			case 2:{	//Lectie + Graf Anim
				grafLectie = new GrafLectie(new PVector(pos.x + w / 2, pos.y), c6, (w - 20)/2, h, 0.2);
				txtb = new txtbx(basePos.x + R, basePos.y + R, ((baseW - 10)/2)-R, (baseH/2)-R, R*2/3, 0, 0);
				break;
			}
			case 3:{	//Submit
				utilizator=new txtbx(2*seekW/6, 2*seekH/8,2*seekW/6, seekH/8,R,1,0);
				parola=new txtbx(2*seekW/6, 2*seekH/8,2*seekW/6, seekH/8,R,1,0);
				//PVector pos, color c, float w, float h, float anim, color hov, color press, String text, int i
				btns.add(new ToggleBtn(new PVector(basePos.x + baseW/2, basePos.y + baseH/2), c6, baseW/8, baseH/8, 0.2, c6_o, color(125, 131, 230), "SUBMIT", 1));
				break;
			}
		}
	}

	void display(){
		noStroke();
		fill(baseCol);
		rect(basePos.x, basePos.y, baseW, baseH, 10);
		/*for(TextBox t : txtboxes){
			if(t.focus)textAlign(LEFT);
			else textAlign(CENTER, CENTER);
			t.display();
		}*/

		switch (index) {
			case 1:{
				noStroke();
				tipLectie.display();
				numeLectie.display();
				break;
			}
			case 2:{
				grafLectie.display();
				if(txtb!=null){
					txtb.display();
					scTb.display();
				}
				break;
			}
			case 3: {
				fill(-1);
				textSize(R);
				textAlign(CENTER,CENTER);
				text("Utilizator:",utilizator.x-R*6,utilizator.y,R*6,utilizator.h);
				text("Parola:",parola.x-R*6,parola.y,R*6,parola.h);
				utilizator.display();
				parola.display();
				btns.get(0).display();
				
				fill(230);
				textAlign(CENTER, CENTER);
				textSize(30);
				text("Press ENTER", basePos.x + width/2, basePos.y + height/2);
				break;
			}
		}		
	}

	void update(){
		animate();

		switch (index) {
			case 1:{
				tipLectie.update();
				tipLectie.position = new PVector(basePos.x, basePos.y);
				numeLectie.x=basePos.x+baseW/2-numeLectie.w/2;
				numeLectie.y=basePos.y+baseH/2-numeLectie.h/2;
				break;
			}
			case 2:{
				if(currForm.forms.get(0).tipLectie!=null && currForm.forms.get(0).tipLectie.mainTabs!=null)
					if(currForm.forms.get(0).tipLectie.mainTabs.get(0).indexSelected==1){
						grafLectie.oriented = false;
					}
					else{
						grafLectie.oriented = true;
					}
				
				grafLectie.addPos = new PVector(basePos.x, 0);
				grafLectie.update();
				if(txtb!=null){
					txtb.w = ((baseW - 10)/2)-R;
					txtb.h = (baseH/2)-R;
					txtb.x = basePos.x + R;
					txtb.y = basePos.y + R;
					scTb.x = basePos.x + width/2;
					scTb.y = basePos.y + 10;

				}
				break;
			}
			case 3: {
				btns.get(0).update();
				utilizator.x = basePos.x+baseW/2-utilizator.w/3;
				utilizator.y = basePos.y+R*3;
				parola.x = basePos.x+baseW/2-parola.w/3;
				parola.y = utilizator.y + 10+utilizator.h;
				break;
			}
		}

		for(TextBox t : txtboxes){
			t.addPos = new PVector(basePos.x, basePos.y);
			t.update();
		}


		if(index==3 && keyPressed && key==ENTER){
			if(SENT)return;
		   	if(db.connect()){
		   		db.query("SELECT * FROM users WHERE (nickname='"+utilizator.s+"' OR email='"+utilizator.s+"')");
		   		while(db.next()){
		   			String tmpPass = db.getString("pass");

		   			if(checkCrypted(parola.s, tmpPass)){
		   				int profID = db.getInt("userID");
			   			String userName = db.getString("name");
						db.execute("INSERT INTO lectiedata VALUES(NULL, "+profID+", '"+currForm.forms.get(1).txtb.s+"', '"+faCodGraf()+"', '"+currForm.forms.get(0).numeLectie.s+"', 0, 0)");
			   			SENT = true;
		   			}
		   		}
		   	}
		   	else return;
		}
	}

	void mouseEvents(){
		
		for(TextBox t : txtboxes){
			if(t.isHovered(mouseX, mouseY)) t.focus = true;
			else t.focus = false;
		}

		if(index==2){
			grafLectie.mouseEvents();
		}
	}

	void keyEvents(){
		for(TextBox t : txtboxes)
			if(t.focus == true)
				t.keyIsPressed();

		if(txtb!=null) txtb.PressKeyProperly();
	}

}
