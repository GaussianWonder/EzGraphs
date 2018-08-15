class DropDown{
	float w, h;
	MainTab[] tabs;

	DropDown(PVector pos, color c, float sz, float anim){
		w = margLeft / 3;
		h = 2*R;

		tabs = new MainTab[3];
		tabs[0] = new MainTab("Contul tau", 1, pos, c, sz, anim, w, h);
		tabs[1] = new MainTab("Grafuri", 2, pos, c, sz, anim, w, h);
		tabs[2] = new MainTab("Exercitii", 3, pos, c, sz, anim, w, h);

		for(int i=0;i<tabs.length;++i){
			tabs[i].basePos = new PVector(0, 0);
			tabs[i].seekPosition(new PVector(pos.x + i*w, pos.y));
		}
	}

	void show(){
		int i = 0;
		for(MainTab t : tabs){
			t.seekPosition(new PVector(i * margLeft/3, 0));
			t.seekW = margLeft/3;

			t.update();
			t.display();

			++i;
		}
	}
	
	boolean mainTabHovered(){
		for(MainTab t : tabs)
			if(t.toggled)
				return true;
		return false;
	}

}

class MainTab extends Obj{
	boolean toggled;
	color backGr;
	int index;
	String name;
	float baseW, seekW, h;
	SubMenu[] sub;

	MainTab(String n, int i, PVector pos, color c, float sz, float anim, float wd, float he) {
		super(pos, c, sz, anim);

		backGr = color(42, 42, 42);
		toggled = false;
		index = i;
		name = n;
		baseW = wd;
		seekW = wd;
		h = he;
		sub=null;

		if(index == 1){
			sub = new SubMenu[2];
			sub[0] = new SubMenu("Conectare", 5, pos, c, sz, anim, baseW, 2*h/3);
			sub[1] = new SubMenu("Inregistrare", 6, pos, c, sz, anim, baseW, 2*h/3);
		}
		else if(index == 2){
			sub = new SubMenu[3];
			sub[0] = new SubMenu("Definitie", 4, pos, c, sz, anim, baseW, 2*h/3);
			sub[1] = new SubMenu("Neorientate", 1, pos, c, sz, anim, baseW, 2*h/3);
			sub[2] = new SubMenu("Orientate", 2, pos, c, sz, anim, baseW, 2*h/3);
		}
		else if(index == 3){
			sub = new SubMenu[1];
			sub[0] = new SubMenu("Jocuri", 3, pos, c, sz, anim, baseW, 2*h/3);
		}
		for(i=0;i<sub.length;++i)
			sub[i].basePos = new PVector(0, 0);
	}

	void display(){
		for(SubMenu s : sub)
			s.display();

		fill(baseCol);
		rect(basePos.x, basePos.y, baseW, h);

		fill(0, 255, 0);
    	textSize(R/3*2);
    	textAlign(CENTER,CENTER);
		text(name, basePos.x + baseW/2, basePos.y + h/2);
	}

	void update(){
		int i = 0;
		if(toggled) for(SubMenu s : sub){
			s.seekPosition(new PVector(seekPos.x, seekPos.y + menu2.h + i*s.h));
			s.seekW = margLeft / 3;

			s.update();
			++i;
		}
		else{
			for(SubMenu s : sub){
				s.seekPosition(new PVector(basePos.x, 0));
				s.seekW = margLeft / 3;
				s.update();
			}
		}

		animate();
		baseW = lerp(baseW, seekW, animSpd);

		if((toggled && onMenu(mouseX, mouseY)) || (!toggled && isHovered(mouseX, mouseY))) toggled = true;
		else toggled = false;
	}

	boolean isHovered(float x, float y){
		return (x>=basePos.x && x<=basePos.x + baseW && y>=basePos.y && y<=basePos.y + h);
	}

	boolean onMenu(float x, float y){
		return (x>=basePos.x && x<=basePos.x + baseW && y>=basePos.y && y<=basePos.y + (sub.length-0.5) * h + menu2.h);
	}

}

class SubMenu extends Obj{
	boolean pressed;
	String name;
	int index;
	float baseW, seekW, h;

	SubMenu(String n, int i, PVector pos, color c, float sz, float anim, float we, float hi) {
		super(pos, c, sz, anim);

		pressed = false;
		index = i;
		name = n;
		baseW = we;
		seekW = we;
		h = hi;
	}

	void display(){
		if (isHovered(mouseX,mouseY)) seekColor(c8_o);
    	else seekColor(c6);
    	if(currentModule == index) seekColor(c8);

    	fill(baseCol);
		rect(basePos.x, basePos.y, baseW, h);

		fill(0, 255, 0);
    	textSize(R/3*1.5);
    	textAlign(CENTER,CENTER);
		text(name, basePos.x + baseW/2, basePos.y + h/2);
	}

	void update(){
		animate();

		baseW = lerp(baseW, seekW, animSpd);

		if(mousePressed && delay==0  && isHovered(mouseX, mouseY)){
		  int i;
		  currentModule = index;
	      lessonActive=1;
	      lines=lines2=false;
	      if (index==0) {
	        menuD.bars[lessonActive-1].lesson.scrolled=0;
	        menuD.bars[lessonActive-1].lesson.scrollbar.scrolled=0;
	        menuD.bars[lessonActive-1].lesson.scrollbar.linesScrolled=0;
	        for (i=0;i<nGrafs;i++)
	          delete_point(grafs[i]);
	        String[] lines = loadStrings(menuD.bars[0].s2 + ".txt");
	        for(i=0;i<lines.length; i++) {
	          if (lines[i].length()>3 && lines[i].charAt(0)=='+' && lines[i].charAt(1)=='+' && lines[i].charAt(2)=='e' && lines[i].charAt(3)=='x') {
	            createExample(lines,i+1);
	            break;
	          }
	          ex.s=getExample(lessonActive);
	        }
	        ex.s=getExample(1);
	      }
	      else if (index==1) {
	        menu.bars[lessonActive-1].lesson.scrolled=0;
	        menu.bars[lessonActive-1].lesson.scrollbar.scrolled=0;
	        menu.bars[lessonActive-1].lesson.scrollbar.linesScrolled=0;
	        for (i=0;i<nGrafs;i++)
	          delete_point(grafs[i]);
	        String[] lines = loadStrings(menu.bars[0].s2 + ".txt");
	        for(i=0;i<lines.length; i++) {
	          if (lines[i].length()>3 && lines[i].charAt(0)=='+' && lines[i].charAt(1)=='+' && lines[i].charAt(2)=='e' && lines[i].charAt(3)=='x') {
	            createExample(lines,i+1);
	            break;
	          }
	          ex.s=getExample(lessonActive);
	        }
	        ex.s=getExample(1);
	      }
	      else if (index==2) {
	        menuOrientate.bars[lessonActive-1].lesson.scrolled=0;
	        menuOrientate.bars[lessonActive-1].lesson.scrollbar.scrolled=0;
	        menuOrientate.bars[lessonActive-1].lesson.scrollbar.linesScrolled=0;
	        for (i=0;i<nGrafs;i++)
	          delete_point(grafs[i]);
	        String[] lines = loadStrings(menuOrientate.bars[0].s2 + ".txt");
	        for(i=0;i<lines.length; i++) {
	          if (lines[i].length()>3 && lines[i].charAt(0)=='+' && lines[i].charAt(1)=='+' && lines[i].charAt(2)=='e' && lines[i].charAt(3)=='x') {
	            createExample(lines,i+1);
	            break;
	          }
	          ex.s=getExample(lessonActive);
	        }
	        ex.s=getExample(1);
	      }
	      else if (index==4) {
	        margLeft = width/2;
	      }
	      delay=DELAY;
		}
	}

	boolean isHovered(float x, float y){
		return (x>=basePos.x && x<=basePos.x + baseW && y>=basePos.y && y<=basePos.y + h);
	}

}