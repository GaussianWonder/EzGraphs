class ModuleSelector{
	Tab[] tabs = new Tab[4];

	ModuleSelector(){
    tabs[0] = new Tab(0, 0, "Definitie", 4, margLeft/4);
		tabs[1] = new Tab(1 * margLeft/4, 0, "Neorientate", 1, margLeft/4);
		tabs[2] = new Tab(2 * margLeft/4 * margLeft/4, 0, "Orientate", 2, margLeft/4);
		tabs[3] = new Tab(3 * margLeft/4, 0, "Jocuri", 3, margLeft/4);

	}

	void display(){
		for(int i=0;i<=3;i++){
			tabs[i].display();
		}
	}

	void update(){
    for(int i=0;i<=3;i++){
      tabs[i].pos = new PVector(i * margLeft/4, 0);
      tabs[i].sz = margLeft/4;
    }
		for(int i=0;i<=3;i++){
			tabs[i].update();
		}
	}
}

class Tab{
	PVector pos;
	String name;
	int index;
	float sz;
  color c=c8, c_o = c8_o;

	Tab(float x, float y, String n, int i, float szz){
		name = n;
		index = i;
		sz = szz;

		pos = new PVector(x, y);
	}

	boolean isHovered(float x, float y){
		return (x>=pos.x && x<=pos.x + sz && y>=pos.y && y<=pos.y + 2*R);
	}

	void display() {
    noStroke();

    if (isHovered(mouseX,mouseY)) fill(c_o);
    else fill(c6);
    if(currentModule == index)fill(c);

		rect(pos.x, pos.y, sz, 2*R);
		fill(0, 255, 0);
    textSize(R/3*2);
    textAlign(CENTER,CENTER);
		text(name, pos.x + sz/2, pos.y + R);
	}

	void update(){
    int i;
		if(mousePressed && delay==0 && isHovered(mouseX, mouseY)) {
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

}