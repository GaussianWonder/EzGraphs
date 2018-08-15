class MultipleSelectionDropDown{
	ArrayList<MultipleMainTab> mainTabs;
	PVector position;
	color col, hoverCol;
	float size, w, h, anim;

	MultipleSelectionDropDown(PVector pos, color c, color hov, float sz, float ww, float hh, float a){
		mainTabs = new ArrayList<MultipleMainTab>();
		position = new PVector(pos.x, pos.y);

		w = ww;
		h = hh;
		size = sz;
		col = c;
		hoverCol = hov;
		anim = a;
	}

	void update(){
		int i = 0;
		for(MultipleMainTab tab : mainTabs){
			tab.update();
			tab.seekPosition(new PVector(position.x + i * w, position.y));
			i++;
		}
	}

	void display(){
		for(MultipleMainTab tab : mainTabs){
			tab.display();
		}
	}

	void addMainTab(String name, int index){
		mainTabs.add(new MultipleMainTab(new PVector(position.x + mainTabs.size() * w, position.y), col, hoverCol, size, anim, name, index, w, h));
	}

	void clear(){
		mainTabs.clear();
	}

}

class MultipleMainTab extends Obj{
	ArrayList<MultipleSubTab> subTabs;
	String name;
	int index, indexSelected;
	float baseW, baseH, seekW, seekH;
	boolean hovered = false, changed = false;
	color hoverCol, col;
	float txtSz;

	MultipleMainTab(PVector pos, color c, color hov, float sz, float anim, String n, int i, float ww, float hh){
		super(pos, c, sz, sz, anim);
		subTabs = new ArrayList<MultipleSubTab>();

		index = i;
		name = n;

		baseW = seekW = ww;
		baseH = seekH = hh;
		txtSz = sz;

		hoverCol = hov;
		col = c;
	}

	void display(){
		for(MultipleSubTab tab : subTabs){
			tab.display();
		}

		fill(baseCol);
		rect(basePos.x, basePos.y, baseW, baseH);

		fill(42);
		textAlign(CENTER, CENTER);
		textSize(txtSz);
		text(name, basePos.x + baseW/2, basePos.y + baseH/2);
	}

	void update(){
		animate();
		baseW = lerp(baseW, seekW, animSpd);
		baseH = lerp(baseH, seekH, animSpd);

		for(MultipleSubTab tab : subTabs){
			tab.update();

			if(tab.isHovered(mouseX, mouseY)){
				tab.seekColor(hoverCol);
				if(mousePressed){
					tab.toggle = true;
					indexSelected = tab.index;
					changed = true;
				}
			}
			else tab.seekColor(col);
			if(tab.toggle && millis() > 1000){
				tab.seekColor(color(red(col) - 50, green(col) - 50, blue(col) - 50));
			}

			if(tab.index != indexSelected){
				tab.toggle = false;
			}
		}

		if(isHovered(mouseX, mouseY) && millis() > 1000){
			hovered = true;
			int i = 0;
			for(MultipleSubTab tab : subTabs){
				tab.seekPosition(new PVector(seekPos.x, seekPos.y + baseH + (baseH * 2/3) * i));
				++i;
			}
		}

		if(hovered && insideSelection(mouseX, mouseY)){
			int i;
			//do stuff if needed
		}
		else{
			hovered = false;
			for(MultipleSubTab tab : subTabs){
				tab.seekPosition(new PVector(seekPos.x, seekPos.y));
			}
		}
	}

	void addSubTab(String name, int index){
		subTabs.add(new MultipleSubTab(new PVector(seekPos.x, seekPos.y), seekCol, hoverCol, txtSz * 2/3, animSpd, name, index, seekW, seekH * 2/3));
	}

	void clear(){
		subTabs.clear();
	}

	boolean isHovered(float x, float y){
		return (x >= basePos.x && x <= basePos.x + baseW && y >= basePos.y && y <= basePos.y + baseH);
	}

	boolean insideSelection(float x, float y){
		return(x>=basePos.x && x<=basePos.x + baseW && y>=basePos.y && y<=basePos.y + baseH + subTabs.size() * (baseH * 2/3));
	}
}

class MultipleSubTab extends Obj{
	String name;
	int index;
	float baseW, baseH, seekW, seekH;
	boolean toggle = false;
	color hoverCol, col;
	float txtSz;

	MultipleSubTab(PVector pos, color c, color hov, float sz, float anim, String n, int i, float ww, float hh){
		super(pos, c, sz, sz, anim);
		name = n;
		index = i;
		col = c;
		hoverCol = hov;

		baseW = seekW = ww;
		baseH = seekH = hh;
		txtSz = sz;
	}

	void display(){
		fill(baseCol);
		rect(basePos.x, basePos.y, baseW, baseH);

		fill(42);
		textAlign(CENTER, CENTER);
		textSize(txtSz);
		text(name, basePos.x + baseW/2, basePos.y + baseH/2);
	}

	void update(){
		animate();
		baseW = lerp(baseW, seekW, animSpd);
		baseH = lerp(baseH, seekH, animSpd);
	}

	boolean isHovered(float x, float y){
		return (x >= basePos.x && x<= basePos.x + baseW && y>=basePos.y && y<=basePos.y + baseH);
	}

}
