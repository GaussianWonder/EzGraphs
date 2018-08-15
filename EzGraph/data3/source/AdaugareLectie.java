import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.bezier.data.sql.*; 
import java.awt.*; 
import java.awt.datatransfer.*; 
import javax.swing.*; 
import java.io.*; 

import org.mindrot.jbcrypt.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AdaugareLectie extends PApplet {

		//Database
					//Transfarable data + Clipboard


					//EOF Clipboard
//import java.awt.event.*;			//conflicts with MouseEvent

float midW, midH;
FormHolder currForm;
float R;
PApplet thisPapplet = this;
MySQL db;
boolean SENT = false;
PImage logo;
int saltCrypt = 10;					//computing complexity for crypting

public void setup() {
	logo = loadImage("icon2-4-01.png");
	surface.setIcon(logo);
	
	
	frameRate(60);
	noStroke();
	ellipseMode(RADIUS);

	midW = width/2;
	midH = height/2;
	R = (height/25);

	currForm = new FormHolder();
	currForm.addForm(new Form(new PVector(10, 20 + height/8), c3, width - 20, height - (10 + height/8), 0.2f, 1));
	currForm.addForm(new Form(new PVector(10, 20 + height/8), c3, width - 20, height - (10 + height/8), 0.2f, 2));
	currForm.addForm(new Form(new PVector(10, 20 + height/8), c3, width - 20, height - (10 + height/8), 0.2f, 3));
	scTb=new scrollbar2(width/2-R/2 + R/3,height/6,R/2,height-R*2,(int)(lungTb()/4/R/3+1));

	db = new MySQL(thisPapplet, "localhost", "ezgraphs", "root", "");    //localhost
}

public void draw() {
	background(c3);

	currForm.show();
}

public void mouseWheel(MouseEvent event) {
	float e = event.getCount();

	if (isBetween(scTb.y,scTb.y+scTb.h-scTb.h2,scTb.y2+e*scTb.h3)) {
      scTb.y2+=e*scTb.h3;
      scTb.decateori+=e;
    }
}

int c1=color(0, 175, 234); //light blue
int c2=color(163, 205, 57); //green
int c3=color(0, 7, 40);  //black-blue
int c4=color(247, 240, 150); //light yellow
int c5=color(255, 89, 94); //red-pink
int c6=color(125, 131, 255); //light purple
int c7=color(3, 0, 56); //dark purple-blue
int c8=color(97, 83, 204); //purple

int c1_o=color(60, 235, 294); //light blue
int c2_o=color(183, 225, 77); //green
int c3_o=color(48, 54, 60);  //black-blue
int c4_o=color(267, 260, 170); //light yellow
int c5_o=color(275, 109, 114); //red-pink
int c6_o=color(145, 151, 275); //light purple
int c7_o=color(39, 80, 105); //dark purple-blue
int c8_o=color(117, 103, 224); //purple

int currentModule;
int delay=0, DELAY = 20;

public boolean isBetween(float a,float b,float x) {
  if (a<=x && x<=b) return true;
  else return false;
}

scrollbar2 scTb;

public float lungTb() {
	if(currForm.forms.get(1).txtb==null)return 0;
	return currForm.forms.get(1).txtb.y+currForm.forms.get(1).txtb.h+R*3;
}

public String faCodGraf() {
	int i;
	String codGraf = "";

	if (currForm.forms.get(1).grafLectie.oriented) codGraf+="1\n";
	else codGraf+="0\n";

	codGraf+=(currForm.forms.get(1).grafLectie.graf.size()-1)+"\n";
	for (i=0;i<currForm.forms.get(1).grafLectie.nodes.size();i++) {
		codGraf+=((int)currForm.forms.get(1).grafLectie.nodes.get(i).basePos.x+(int)currForm.forms.get(1).grafLectie.basePos.x)+" ";
		codGraf+=((int)currForm.forms.get(1).grafLectie.nodes.get(i).basePos.y+(int)currForm.forms.get(1).grafLectie.basePos.y)+" ";
		if (currForm.forms.get(1).grafLectie.nodes.get(i).active) codGraf+="1 ";
		else codGraf+="0 ";
		codGraf+=currForm.forms.get(1).grafLectie.nodes.get(i).index+" ";
		codGraf+="\n";
	}
	codGraf+=currForm.forms.get(1).grafLectie.edges.size()+"\n";
	for (i=0;i<currForm.forms.get(1).grafLectie.edges.size();i++) {
		codGraf+=currForm.forms.get(1).grafLectie.edges.get(i).sIndex+" ";
		codGraf+=currForm.forms.get(1).grafLectie.edges.get(i).fIndex+" ";
		codGraf+="\n";
	}
	
	return codGraf;
}

public String crypt(String pass){
	String hash = BCrypt.hashpw(pass, BCrypt.gensalt(saltCrypt));

	if (BCrypt.checkpw(pass, hash)) return hash;
	else return "{ERR}";
}

public boolean checkCrypted(String pass, String hash){
	return BCrypt.checkpw(pass, hash);
}
class ToggleBtn extends Obj{	//toggle in mousePressed();
	PVector addPos;
	int index;
	boolean toggle = false;
	String name;
	int normal, hover, active;
	float baseAngle = 50, seekAngle = 0;

	ToggleBtn(PVector pos, int c, float w, float h, float anim, int hov, int press, String text, int i){
		super(pos, c, w, h, anim);
		normal = c;
		hover = hov;
		active = press;

		name = text;

		index = i;

		addPos = new PVector(0, 0);
	}

	public void display(){
		noStroke();
		fill(baseCol);
		rect(addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH, baseAngle);
		
		textSize(round(baseH / 4));
		textAlign(CENTER, CENTER);
		fill(42);

		text(name, addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH);
	}

	public void update(){
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

	public boolean isHovered(float x, float y){
		return(x>=addPos.x + basePos.x && x<=addPos.x + basePos.x + baseW && y>=addPos.y + basePos.y && y<=addPos.y + basePos.y + baseH);
	}
}
class EdgeLectie{
	int normal, hover, baseCol, seekCol;
	Obj sPoint, fPoint, controlPS, controlPF;
	int sIndex, fIndex;

	EdgeLectie(NodeLectie nod, NodeLectie vec, int _n, int _v, int norm, int hov){
		sPoint = new Obj(new PVector(nod.addPos.x + nod.basePos.x, nod.addPos.y + nod.basePos.y), norm, 4, 4, 0.15f);
		fPoint = new Obj(new PVector(vec.addPos.x + vec.basePos.x, vec.addPos.y + vec.basePos.y), norm, 4, 4, 0.15f);

		normal = baseCol = seekCol = norm;
		hover = hov;

		sIndex = _n;
		fIndex = _v;
	}
	
	public void displayOriented(){
		//println("AM AFISAT");
		noFill();
		float w3, w11, w22, q, w1, w2;
		int x1 = PApplet.parseInt(sPoint.basePos.x), y1 = PApplet.parseInt(sPoint.basePos.y), x2 = x1, y2 = y1, x3 = PApplet.parseInt(fPoint.basePos.x), y3 = PApplet.parseInt(fPoint.basePos.y), x4 = x3, y4 = y3;
		if (x1!=x4) w3=atan((y1-y4)/(x1-x4));
	    else w3=PI/2;
	    if (y4<y1) w3=-w3;

	    PVector v1 = new PVector(x4-x1, y4-y1);
	    PVector v2 = new PVector(width, 0);
	    w3=radians(PVector.angleBetween(v2, v1));

	    if (y4<y1) w3=-w3;
	    w3=w3*180/PI;

	    q=dist(x1,y1,x4,y4)/3;
	    w1=q*cos(w3-PI/8);
	    w2=q*sin(w3-PI/8);
	    w11=q*cos(w3+PI/8+PI);
	    w22=q*sin(w3+PI/8+PI);

	    if (currForm.forms.get(1).grafLectie.indexBtn==5) {
		    stroke(256,0,0);
			strokeWeight(1);
		    line(x4,y4,x2,y2);
		}

	    stroke(c1);
		strokeWeight(6);
		bezier(x1,y1,x1+w1,y1+w2,x4+w11,y4+w22,x4,y4);

	    q=R;
	    w1=q*cos(w3+PI+PI/8);
	    w2=q*sin(w3+PI+PI/8);

	    w11=R*cos(w3+PI/10+PI+PI/8);
	    w22=R*sin(w3+PI/10+PI+PI/8);
	    line(x4+w1,y4+w2,x4+w1+w11,y4+w2+w22);

	    w11=R*cos(w3-PI/5+PI+PI/8);
	    w22=R*sin(w3-PI/5+PI+PI/8);
	    line(x4+w1,y4+w2,x4+w1+w11,y4+w2+w22);
	}

	public void displayUnoriented(){
		stroke(c1);
		strokeWeight(6);
		int x1 = PApplet.parseInt(sPoint.basePos.x), y1 = PApplet.parseInt(sPoint.basePos.y), x2 = x1, y2 = y1, x3 = PApplet.parseInt(fPoint.basePos.x), y3 = PApplet.parseInt(fPoint.basePos.y), x4 = x3, y4 = y3;
		line(x1, y1, x4, y4);
	}

	public void update(){
		if(currForm.forms.get(1).grafLectie!=null){
			NodeLectie nod = currForm.forms.get(1).grafLectie.nodes.get(sIndex), vec = currForm.forms.get(1).grafLectie.nodes.get(fIndex);
			sPoint.seekPosition(new PVector(nod.addPos.x + nod.basePos.x, nod.addPos.y + nod.basePos.y));
			fPoint.seekPosition(new PVector(vec.addPos.x + vec.basePos.x, vec.addPos.y + vec.basePos.y));
			
		}
		sPoint.animate();
		fPoint.animate();

		baseCol = lerpColor(baseCol, seekCol, 0.15f);
		if(isOnLine(sPoint.basePos, fPoint.basePos, new PVector(mouseX, mouseY))) seekCol = hover;
		else seekCol = normal;
	}

	public boolean isOnLine(PVector startP, PVector endP, PVector mouseP){
		PVector closeP = new PVector();			//Can be returned as reference -> closest point to segment
		PVector line = PVector.sub(endP, startP);
		float ERR = 6;							//size of border / stroke
	  	float l2 = line.magSq();
	  	if (l2 == 0.0f) {
	    	closeP.set(startP);
	    	return false;
	  	}

	  	PVector dstLine = PVector.sub(mouseP, startP);
	  	float t = dstLine.dot(line)/l2;

	  	dstLine.normalize();
	  	closeP.set(line);
	  	closeP.mult(t);
	  	closeP.add(startP);

	  	float d = PVector.dist(mouseP, closeP);
	  	if (t >= 0 && t <= 1 && d <= ERR) return true;
	  	else return false;
	}

	public boolean exist(int s, int f){
		return (sIndex == s && fIndex == f);
	}

	public int oneEnd(int nod){
		if(sIndex == nod) return fIndex;
		else if(fIndex == nod) return sIndex;
		return -1;
	}

	public void indexReplacement(int nod){
		if(sIndex >= nod)sIndex--;
		if(fIndex >= nod)fIndex--;
	}

}
class Form extends Obj{
	int index;
	ArrayList<TextBox> txtboxes = new ArrayList<TextBox>();
	ArrayList<ToggleBtn> btns = new ArrayList<ToggleBtn>();
	txtbx numeLectie, utilizator, parola;

	MultipleSelectionDropDown tipLectie;	//Nume + Tip Lectie
	GrafLectie grafLectie;
	txtbx txtb;

	Form(PVector pos, int c, float w, float h, float anim, int i){
		super(pos, c, w, h, anim);
		index = i;

		switch(index){
			case 1:{	//Nume + Tip Lectie
				tipLectie = new MultipleSelectionDropDown(new PVector(pos.x, pos.y), c6, c6_o, 30, (width - 20), height/10, 0.2f);
				tipLectie.addMainTab("Tip Lectie", 1);

				tipLectie.mainTabs.get(0).addSubTab("Grafuri Neorientate", 1);
				tipLectie.mainTabs.get(0).addSubTab("Grafuri Orientate", 2);
				//tipLectie.mainTabs.get(0).addSubTab("Amandoua", 3);


				txtboxes.add(new TextBox(new PVector(2*seekW/6, 2*seekH/8), color(255, 100, 100), 2*seekW/6, seekH/8, 0.2f, color(255, 120, 120), color(255, 140, 140), 30, 30, 1));
				txtboxes.get(0).data = "NUME LECTIE";
				numeLectie=new txtbx(2*seekW/6, 2*seekH/8,2*seekW/6, seekH/8,R,1,0);
				break;
			}
			case 2:{	//Lectie + Graf Anim
				grafLectie = new GrafLectie(new PVector(pos.x + w / 2, pos.y), c6, (w - 20)/2, h, 0.2f);
				txtb = new txtbx(basePos.x + R, basePos.y + R, ((baseW - 10)/2)-R, (baseH/2)-R, R*2/3, 0, 0);
				break;
			}
			case 3:{	//Submit
				utilizator=new txtbx(2*seekW/6, 2*seekH/8,2*seekW/6, seekH/8,R,1,0);
				parola=new txtbx(2*seekW/6, 2*seekH/8,2*seekW/6, seekH/8,R,1,0);
				//PVector pos, color c, float w, float h, float anim, color hov, color press, String text, int i
				btns.add(new ToggleBtn(new PVector(basePos.x + baseW/2, basePos.y + baseH/2), c6, baseW/8, baseH/8, 0.2f, c6_o, color(125, 131, 230), "SUBMIT", 1));
				break;
			}
		}
	}

	public void display(){
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

	public void update(){
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

	public void mouseEvents(){
		
		for(TextBox t : txtboxes){
			if(t.isHovered(mouseX, mouseY)) t.focus = true;
			else t.focus = false;
		}

		if(index==2){
			grafLectie.mouseEvents();
		}
	}

	public void keyEvents(){
		for(TextBox t : txtboxes)
			if(t.focus == true)
				t.keyIsPressed();

		if(txtb!=null) txtb.PressKeyProperly();
	}

}
class FormHolder{
	int currIndex;
	TextBox notification;
	ArrayList<Form> forms;
	ArrayList<ToggleBtn> buttons;

	FormHolder(){
		forms = new ArrayList<Form>();
		buttons = new ArrayList<ToggleBtn>();

		for(int i=0;i<3;i++)
			buttons.add(new ToggleBtn(new PVector(10 + (width/8 + 10) * i, 10), color(61, 164, 171), width/8, height/8, 0.2f, color(14, 154, 167), color(0, 166, 166), PApplet.parseInt(i + 1) + "", i + 1));
		notification = new TextBox(new PVector(10 + (width/8 + 10) * 3, 10), color(120, 120, 120), width - (5 * 10 + 3 * width/8), height/8, 0.2f, color(150, 150, 150), color(160, 160, 160), 30, 30, 1);
		
		currIndex = 1;
		buttons.get(0).toggle = true;
	}

	public void show(){
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

	public void addForm(Form f){
		forms.add(f);
	}

	public void mouseEvents(){
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

	public void keyEvents(){
		for(Form f : forms)
			f.keyEvents();
	}
}
class GrafLectie extends Obj{
	PVector addPos;
	int indexBtn = -1;
	ArrayList<ToggleBtn> btns;

	ArrayList<IntList> graf;
	boolean oriented = true;
	ArrayList<NodeLectie> nodes;
	boolean nodeOnPossesion = false;
	int nodeOnPossesionIndex = -1, nodePrime = -1, nodeNeighbor = -1;
	ArrayList<EdgeLectie> edges;

	GrafLectie(PVector pos, int c, float w, float h, float anim){
		super(pos, c, w, h, anim);
		addPos = new PVector(0, 0);

		btns = new ArrayList<ToggleBtn>();
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2f, color(66,121,163), color(14,154,167), "Adauga nod", 1));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2f, color(66,121,163), color(14,154,167), "Misca", 2));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 2 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2f, color(66,121,163), color(14,154,167), "Sterge graf", 3));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 3 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2f, color(66,121,163), color(14,154,167), "Adauga muchie", 4));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 4 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2f, color(66,121,163), color(14,154,167), "Sterge muchie", 5));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 4 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2f, color(66,121,163), color(14,154,167), "Sterge nod", 6));
		
		graf = new ArrayList<IntList>();
		graf.add(new IntList());	//Empty (starting with 1);
		nodes = new ArrayList<NodeLectie>();
		edges = new ArrayList<EdgeLectie>();
	}

	public void display(){
		for(EdgeLectie edge : edges){
			if(!oriented) edge.displayUnoriented();
			else edge.displayOriented();
		}
		for(ToggleBtn btn : btns){
			btn.display();
		}
		for(NodeLectie node : nodes){
			node.display();
		}
	}

	public void update(){
		animate();

		int i = 0;
		for(ToggleBtn btn : btns){
			btn.seekPosition(new PVector(addPos.x + basePos.x + i * baseW/6, addPos.y + basePos.y));
			btn.update();
			i++;
		}

		for(NodeLectie node : nodes){
			node.addPos = new PVector(addPos.x + basePos.x - 10, addPos.y + basePos.y);
			node.update();
		}

		for(EdgeLectie edge : edges){
			edge.update();
		}
	}

	public void mouseEvents(){
		for(ToggleBtn btn : btns)
			if(btn.isHovered(mouseX, mouseY)){
				btn.toggle = (btn.toggle) ? false : true;
				indexBtn = (btn.toggle) ? btn.index : -1;
			}
		for(ToggleBtn btn : btns)
			if(btn.index!=indexBtn)
				btn.toggle = false;

		switch (indexBtn) {
			case 1:{		//Add/Connect
				if(mouseButton==LEFT){			//Add
					int nextIndex = findMissingNode(), coordX = PApplet.parseInt(mouseX - basePos.x), coordY = PApplet.parseInt(mouseY - basePos.y);
					if(mouseX>=basePos.x && mouseX<=basePos.x + baseW && mouseY>=basePos.y + baseH/7 && mouseY<=basePos.y + baseH){
						nodes.add(new NodeLectie(new PVector(coordX, coordY), color(0, 215, 32), baseW/20, baseW/20, 0.2f, nextIndex, color(0, 243, 36)));
						graf.add(new IntList());	//somewhat inefficient
					}
				}
				/*else if(mouseButton==RIGHT){	//Connect	-> more in mouseDrag()

				}*/
				break;
			}
			case 2:{
				break;
			}
			case 3:{		//Reset		-> new init of graf
				graf = new ArrayList<IntList>();
				graf.add(new IntList());
				nodes = new ArrayList<NodeLectie>();
				edges = new ArrayList<EdgeLectie>();

				break;
			}
			case 5: {
				if(mouseButton==LEFT){	//Remove
					for(int j=edges.size()-1;j>=0;j--){				//edge deletion
						EdgeLectie edge = edges.get(j);
						if(edge.isOnLine(edge.sPoint.basePos, edge.fPoint.basePos, new PVector(mouseX, mouseY))){
							removeFromGraf(nodes.get(edge.sIndex).index + 1, nodes.get(edge.fIndex).index + 1);
							removeFromGraf(nodes.get(edge.fIndex).index + 1, nodes.get(edge.sIndex).index + 1);
							edges.remove(j);
						}
					}
				}
				break;
			}
			case 6: {
				if(mouseButton==LEFT){	//Remove
					for (int i=0;i<nodes.size();i++){
						NodeLectie node = nodes.get(i);
						if(node.isHovered(mouseX, mouseY)){
							int tmpIndex = node.index + 1;
							node.active = false;
							graf.get(tmpIndex).clear();

							for(int j=edges.size()-1;j>=0;j--){	
								EdgeLectie edge = edges.get(j);
								int index = edge.oneEnd(i);
								if(index!=-1){
									NodeLectie vec = nodes.get(index);
									IntList lst = graf.get(vec.index + 1);

									for(int k=lst.size()-1;k>=0;k--){
										int tmpInf = lst.get(k);

										if(tmpInf == tmpIndex){
											lst.remove(k);
											break;
										}
									}
									edges.remove(j);
								}
							}
							break;
						}
					}
					break;
				}
			}
		}
	}

	public void mouseDrag(){
		if(indexBtn==4){		//Connect
			if(mouseButton==LEFT) for(int i=0;i<nodes.size();i++){			//=> working
				NodeLectie node = nodes.get(i);
				if(node.active && node.isHovered(mouseX, mouseY)){
					if(nodePrime==-1){
						nodePrime = i;
						break;
					}
					else if(nodeNeighbor==-1 && i!=nodePrime){		//Different ends
						nodeNeighbor = i;
						joinNodes(nodePrime, nodeNeighbor);
						break;
					} 
				}
			}
		}
		if(indexBtn==2){		//Move
			if(mouseButton==LEFT) for(NodeLectie node : nodes){
				if(node.active && node.isHovered(mouseX, mouseY) && (!nodeOnPossesion || node.index == nodeOnPossesionIndex)){
					int coordX = PApplet.parseInt(mouseX - basePos.x), coordY = PApplet.parseInt(mouseY - basePos.y);
					PVector coords = new PVector(coordX, coordY);
					nodeOnPossesion = true;
					nodeOnPossesionIndex = node.index;

					if(mouseX>=basePos.x && mouseX<=basePos.x + baseW && mouseY>=basePos.y + baseH/7 && mouseY<=basePos.y + baseH){
						node.basePos = coords;
						node.seekPosition(coords);
						break;
					}
				}
			}
		}
	}

	public void mouseRelease(){
		nodeOnPossesion = false;
		nodePrime = nodeNeighbor = -1;
	}

	public int findMissingNode(){
		boolean[] f = new boolean[30];
		for(int i=0;i<30;i++)
			f[i] = false;

		for(NodeLectie n : nodes)
			if(n.active)
				f[n.index] = true;

		for(int i=0;i<30;i++)		//return the first one missing
			if(!f[i])
				return i;

		return nodes.size() + 1;	//if none is missing add number
	}

	public void joinNodes(int n, int v){
		NodeLectie nod = nodes.get(n), vec = nodes.get(v);
		int nodIndex = nod.index + 1, vecIndex = vec.index + 1;

		for(EdgeLectie edge : edges)
			if(edge.exist(nod.index, vec.index))
				return;
		
		//No repeating edge
		if(oriented){
			graf.get(nodIndex).append(vecIndex);
			edges.add(new EdgeLectie(nod, vec, n, v, color(7, 157, 243), color(0, 255, 252)));
		}
		else{
			graf.get(nodIndex).append(vecIndex);
			edges.add(new EdgeLectie(nod, vec, n, v, color(7, 157, 243), color(0, 255, 252)));
			graf.get(vecIndex).append(nodIndex);
		}

		nodePrime = nodeNeighbor = -1;
	}

	public void removeFromGraf(int nod, int vec){
		for(int i=0; i<graf.get(nod).size();i++){
			int inf = graf.get(nod).get(i);
			if(inf == vec){
				graf.get(nod).remove(i);
				return;
			}
		}
	}

	public void deleteEdge(int nod, int vec){
		for(int i = edges.size() - 1; i>=0;i--)
			if(edges.get(i).exist(nod, vec))
				edges.remove(i);
	}
}
class MultipleSelectionDropDown{
	ArrayList<MultipleMainTab> mainTabs;
	PVector position;
	int col, hoverCol;
	float size, w, h, anim;

	MultipleSelectionDropDown(PVector pos, int c, int hov, float sz, float ww, float hh, float a){
		mainTabs = new ArrayList<MultipleMainTab>();
		position = new PVector(pos.x, pos.y);

		w = ww;
		h = hh;
		size = sz;
		col = c;
		hoverCol = hov;
		anim = a;
	}

	public void update(){
		int i = 0;
		for(MultipleMainTab tab : mainTabs){
			tab.update();
			tab.seekPosition(new PVector(position.x + i * w, position.y));
			i++;
		}
	}

	public void display(){
		for(MultipleMainTab tab : mainTabs){
			tab.display();
		}
	}

	public void addMainTab(String name, int index){
		mainTabs.add(new MultipleMainTab(new PVector(position.x + mainTabs.size() * w, position.y), col, hoverCol, size, anim, name, index, w, h));
	}

	public void clear(){
		mainTabs.clear();
	}

}

class MultipleMainTab extends Obj{
	ArrayList<MultipleSubTab> subTabs;
	String name;
	int index, indexSelected;
	float baseW, baseH, seekW, seekH;
	boolean hovered = false, changed = false;
	int hoverCol, col;
	float txtSz;

	MultipleMainTab(PVector pos, int c, int hov, float sz, float anim, String n, int i, float ww, float hh){
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

	public void display(){
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

	public void update(){
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

	public void addSubTab(String name, int index){
		subTabs.add(new MultipleSubTab(new PVector(seekPos.x, seekPos.y), seekCol, hoverCol, txtSz * 2/3, animSpd, name, index, seekW, seekH * 2/3));
	}

	public void clear(){
		subTabs.clear();
	}

	public boolean isHovered(float x, float y){
		return (x >= basePos.x && x <= basePos.x + baseW && y >= basePos.y && y <= basePos.y + baseH);
	}

	public boolean insideSelection(float x, float y){
		return(x>=basePos.x && x<=basePos.x + baseW && y>=basePos.y && y<=basePos.y + baseH + subTabs.size() * (baseH * 2/3));
	}
}

class MultipleSubTab extends Obj{
	String name;
	int index;
	float baseW, baseH, seekW, seekH;
	boolean toggle = false;
	int hoverCol, col;
	float txtSz;

	MultipleSubTab(PVector pos, int c, int hov, float sz, float anim, String n, int i, float ww, float hh){
		super(pos, c, sz, sz, anim);
		name = n;
		index = i;
		col = c;
		hoverCol = hov;

		baseW = seekW = ww;
		baseH = seekH = hh;
		txtSz = sz;
	}

	public void display(){
		fill(baseCol);
		rect(basePos.x, basePos.y, baseW, baseH);

		fill(42);
		textAlign(CENTER, CENTER);
		textSize(txtSz);
		text(name, basePos.x + baseW/2, basePos.y + baseH/2);
	}

	public void update(){
		animate();
		baseW = lerp(baseW, seekW, animSpd);
		baseH = lerp(baseH, seekH, animSpd);
	}

	public boolean isHovered(float x, float y){
		return (x >= basePos.x && x<= basePos.x + baseW && y>=basePos.y && y<=basePos.y + baseH);
	}

}
class NodeLectie extends Obj{
	PVector addPos = new PVector(0, 0);
	int index;
	boolean active = true;
	float initSz;

	NodeLectie(PVector pos, int c, float w, float h, float anim, int i, int hov){
		super(pos, c, w, h, anim);
		initSz = w;
		index = i;
	}

	public void display(){
		if(active){
			stroke(c5_o);
			strokeWeight(R/5);
			fill(c2);
			ellipse(addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH);

			noStroke();
			fill(42);
			textSize(baseW / 2);
			textAlign(CENTER, CENTER);
			text((index + 1) + "", addPos.x + basePos.x, addPos.y + basePos.y);
		}
	}

	public void update(){
		if(active){
			animate();

			if(isHovered(mouseX, mouseY)) seekSize(initSz * 1.35f, initSz * 1.35f);
			else seekSize(initSz, initSz);
		}
	}

	public void mouseEvents(){

	}

	public boolean isHovered(float x, float y){
		return(dist(basePos.x + addPos.x, basePos.y + addPos.y, mouseX, mouseY) < baseW);
	}

}
class Obj{
	PVector basePos, seekPos;
	int baseCol, seekCol;
	float baseW, baseH, seekW, seekH;
	float animSpd;

	Obj(PVector pos, int c, float w, float h, float anim){
		basePos = new PVector(midW, midH);
		seekPos = new PVector(pos.x, pos.y);

		int r = PApplet.parseInt(red(c) - 25), g = PApplet.parseInt(green(c) - 25), b = PApplet.parseInt(blue(c) - 25);
		if(r<0)r=0;
		if(g<0)g=0;
		if(b<0)b=0;
		baseCol = color(r, g, b);	//darker than c
		seekCol = c;

		baseH = 0.1f;
		baseW = 0.1f;
		seekW = w;
		seekH = h;

		animSpd = anim;
	}

	public void animate(){
		basePos.lerp(seekPos, animSpd);
		baseCol = lerpColor(baseCol, seekCol, animSpd);
		baseW = lerp(baseW, seekW, animSpd);
		baseH = lerp(baseH, seekH, animSpd);
	}

	public void seekPosition(PVector pos){
		seekPos = new PVector(pos.x, pos.y);
	}

	public void seekColor(int c){
		seekCol = c;
	}

	public void seekSize(float w, float h){
		seekW = w;
		seekH = h;
	}

	public void seekWidth(float w){
		seekW = w;
	}

	public void seekHeight(float h){
		seekH = h;
	}
}
class TextBox extends Obj{
	PVector addPos;
	String data = "";
	boolean focus = false;
	float leading, txtSz, descent, ascent, initW, initH, baseAngle = 10, seekAngle = 50;
	int endlines = 0, lineIndex = 0, index;
	int normal, hover, active;

	TextBox(PVector pos, int c, float w, float h, float anim, int hov, int act, float lead, float sz, int i){
		super(pos, c, w, h, anim);
		normal = c;
		hover = hov;
		active = act;

		leading = lead;
		txtSz = sz;
		textSize(txtSz);
		textLeading(leading);
		descent = textDescent() * 0.8f;
		ascent = textAscent() * 0.8f;

		initW = w;
		initH = h;

		index = i;

		addPos = new PVector(0, 0);
	}

	public void display(){
		noStroke();
		fill(baseCol);
		rect(addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH, baseAngle);

		fill(42);
		//textAlign(LEFT);
		textSize(txtSz);
		textLeading(leading);
		text(data, addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH);

		stroke(42);
		strokeWeight(1);
		if(frameCount % 60 < 30 && focus){
			PVector pos = calcLinePos(lineIndex);
			line(addPos.x + basePos.x + pos.x, addPos.y + basePos.y + pos.y + descent + ascent, addPos.x + basePos.x + pos.x, addPos.y + basePos.y + pos.y);
		}
	}

	public void update(){
		animate();
		baseAngle = lerp(baseAngle, seekAngle, animSpd);
		if(keyPressed){
			float localW = textWidth(data) + txtSz;
			float localH = descent + (txtSz + (txtSz - leading)) * (endlines + 1.5f);

			if(initW < localW) seekWidth(localW);
			if(initH < localH) seekHeight(descent + (txtSz + (txtSz - leading)) * (endlines + 1.5f));
		}

		if(focus){
			seekAngle = 0;
			seekColor(active);
		}
		else if(isHovered(mouseX, mouseY)) seekColor(hover);
		else {
			seekAngle = 50;
			seekColor(normal);
		}

		if(lineIndex>data.length())lineIndex = data.length();
		else if(lineIndex<0)lineIndex = 0;
	}

	public boolean isHovered(float x, float y){
		return(x>=addPos.x + basePos.x && x<=addPos.x + basePos.x + baseW && y>=addPos.y + basePos.y && y<=addPos.y + basePos.y + baseH);
	}

	public PVector calcLinePos(int lineIndex){
		if(data.equals(""))return(new PVector(0, 0));
		int endlns = 0, endlnIndex = -1;
		String txtSample = "";

		for(int i=0;i<data.length();i++){
			if(i<lineIndex){
				txtSample += data.charAt(i) + "";
				if(data.charAt(i) == '\n'){
					endlns++;
					endlnIndex = i;
					txtSample = "";
				}
			}
		}

		return new PVector(textWidth(txtSample), descent + (txtSz + (txtSz - leading)) * endlns);
	}

	public void keyIsPressed(){
		if(key == CODED){	//Special keys
			if(keyCode == ALT) return;

			switch (keyCode) {
				case DOWN:{
					do{
						lineIndex++;
					}while (lineIndex < data.length() && data.charAt(lineIndex)!='\n');
					lineIndex++;
					if(lineIndex>data.length())
						lineIndex = data.length();
					break;
				}
				case UP:{
					lineIndex-=2;
					if(lineIndex < 0){
						lineIndex = 0;
						break;
					}

					do{
						lineIndex--;
					}while (lineIndex > 0 && data.charAt(lineIndex)!='\n');
					lineIndex++;

					if(lineIndex < 0) lineIndex = 0;
					else if(lineIndex == 1)lineIndex = 0;

					break;
				}
				case LEFT:{
					lineIndex--;
					if(lineIndex<0)
						lineIndex=0;
					break;
				}
				case RIGHT:{
					lineIndex++;
					if(lineIndex>data.length())
						lineIndex = data.length();
					break;
				}
			}
		} else switch (key) {
			case ESC:{
				int i;
				break;
			}
			case BACKSPACE:{
				delRightAt(lineIndex - 1);
				lineIndex--;
				break;
			}
			case DELETE:{
				delLeftAt(lineIndex - 1);
				break;
			}
			case TAB:{
				if(textWidth(data + "     " + "") > seekW)
						return;
				data += "     ";
				lineIndex += 5;
				break;
			}
			case ENTER:{
				data += '\n' + "";
				endlines++;
				lineIndex++;
				break;
			}
			case RETURN:{
				data += '\n' + "";
				endlines++;
				break;
			}
			default:{
				if( PApplet.parseInt(key) == 22 ){			//paste from clipboard CTRL + V
					Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
 					Transferable contents = clipboard.getContents(null);
 					DataFlavor flavor = DataFlavor.stringFlavor;
 					Object contentData = null;

					if (contents != null && contents.isDataFlavorSupported(flavor)){
						try{
							contentData = contents.getTransferData(flavor);
						}
						catch (UnsupportedFlavorException exu){		//Completely Optional -> no freeze to death tho
							println("Unsupported flavor: " + exu);
						}
						catch (java.io.IOException exi){
							println("Unavailable data: " + exi);
						}
					}

					data = (String) contentData;

					endlines = 0;
					for(int i=0; i<data.length();i++)
						if(data.charAt(i)=='\n')
							endlines++;
					break;
				}
				else if(PApplet.parseInt(key) == 3){		//copy to clipboard CTRL + C
					Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
					StringSelection selection = new StringSelection(data);
					clipboard.setContents(selection, selection);
					break;
				}
				else if( (key>='a' && key<='z') || (key>='A' && key<='Z') || (key>='0' && key<='9') || 1==1){
					if(textWidth(data + key + "") > seekW)
						return;
					insertAt(lineIndex);
					lineIndex++;
				}
				break;
			}
		}
	}

	public void insertAt(int index){
		if(data.equals("") || index == data.length()){
			data += key + "";
			return;
		}

		String newData = "";
		for(int i=0;i<data.length();i++){
			if(i==index) newData += key;
			newData += data.charAt(i);
		}
		data = newData;
	}

	public void delRightAt(int index){
		String newData = "";
		for(int i=0;i<data.length();i++){
			if(i==index && data.charAt(i)=='\n')
				endlines--;
			if(i!=index)
				newData += data.charAt(i);
		}
		data = newData;
	}

	public void delLeftAt(int index){
		String newData = "";
		for(int i=0;i<data.length();i++){
			if(i==index + 1 && data.charAt(i)=='\n')
				endlines--;
			if(i!=index + 1)
				newData += data.charAt(i);
		}
		data = newData;
	}
}
public void keyPressed(){
	currForm.keyEvents();
	currForm.forms.get(0).numeLectie.PressKeyProperly();
	currForm.forms.get(2).utilizator.PressKeyProperly();
	currForm.forms.get(2).parola.PressKeyProperly();
}

public void keyReleased(){

}
public void mousePressed(){
	currForm.mouseEvents();
	/*
	if(tst.isHovered(mouseX, mouseY))
		tst.focus = true;
	else tst.focus = false;

	if(tstBtn.isHovered(mouseX, mouseY)){
		if(tstBtn.toggle==true)
			tstBtn.toggle = false;
		else tstBtn.toggle = true;
	}
	*/
}

public void mouseReleased(){
	if(currForm.currIndex == 2 && currForm.forms.get(1).grafLectie!=null)
		currForm.forms.get(1).grafLectie.mouseRelease();
}

public void mouseDragged(){
	if(currForm.currIndex == 2 && currForm.forms.get(1).grafLectie!=null)
		currForm.forms.get(1).grafLectie.mouseDrag();
}
class scrollbar2 {
	float x,y,w,h,y2,h2,y3,h3,numar;
	int c1=c6,c2=c8,c2_o=c8_o;
	float h4;
	float decateori;

	scrollbar2(float xx,float yy,float ww,float hh,float numarr) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		numar=numarr;
		h2=(float)h/numar;
		y2=y3=y;
		h3=h2/4;
		h4=R*3;
		decateori=0;
	}

	public void display() {
		fill(c1);
		noStroke();
		rect(x,y,w,h);
		if (isBetween(x,x+w,mouseX) && isBetween(y2,y2+h2,mouseY)) {
			fill(c2_o);
		}
		else fill(c2);
		rect(x,y2,w,h2);
	}
}
class txtbx {
	float x,y,w,h,sz;
	String s,sP;
	int c=c6,c_o=c6_o;
	int cursor,randuri,rand,cursor2;
	boolean ok;
	int unRand,pass,pass2;

	txtbx(float xx,float yy,float ww,float hh,float szz,int unRRand,int passs) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		sz=szz;
		s=sP="";
		ok = false;
		cursor=0; //global
		cursor2=0; //linie
		randuri=1;
		rand=0;
		unRand=unRRand;
		pass2=pass=passs;
	}

	public void display() {
		int rr = 0;
		for (int i=0;i<cursor;i++)
				if (s.charAt(i)=='\n') {
					rr++;
				}
		if (y+sz*rr+sz+rr*sz/2>y+h){
			h=sz*rr+sz+rr*sz/2 + sz;
			scTb.numar = (int)(lungTb()/4/R/3+1);
			scTb.h2=(float)scTb.h/scTb.numar;
			scTb.h3=scTb.h2/4;
			scTb.y2=scTb.decateori*scTb.h3+scTb.y;
		}

		float sc=0,yc=0;
		sc=scTb.decateori*scTb.h4;
		yc=y;
		y=yc-sc;

		strokeWeight(2);
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			fill(c_o);
			fill(-1,60);
			if (mousePressed)
				ok=true;
		}
		else {
			if (!ok){
				fill(c);
				fill(-1,30);
			}
			else {
				fill(c_o);
				fill(-1,60);
			}
			if (mousePressed)
				ok=false;
		}
		stroke(-1);
		strokeWeight(2);
		rect(x,y,w,h);
		noStroke();
		fill(-1);
		if (ok) textAlign(LEFT,LEFT);
		else textAlign(CENTER,CENTER);
		textSize(R*2/3);

		textLeading(sz+5);
		if (pass==0)
			text(s,x,y,w,h);
		else 
			text(pass(s),x,y,w,h);
		if (pass2==1) {
			if (isBetween(x+w+R,x+w+R+R*3,mouseX) && isBetween(y,y+h,mouseY)) {
				fill(c_o);
				if (mousePressed && frameCount%4==0)
					pass=(pass==1)?0:1;
			}
			else 
				fill(c);
			rect(x+w+R,y,R*3,h);
			fill(-1);
			textSize(R*2/3);
			textAlign(CENTER,CENTER);
			if (pass==0)
				text("Hide",x+w+R,y,R*3,h);
			else 
				text("Show",x+w+R,y,R*3,h);
		}
		if (ok) {//} && delay==0) {
			delay=10;
			String ss1="";
			int ll=0;
			rr=0;
			for (int i=0;i<cursor;i++)
				if (s.charAt(i)=='\n') {
					rr++;
					ll=i;
				}
			for (int i=ll;i<cursor;i++)
				ss1=ss1+s.charAt(i);
			if (ll>0) ll++;
			stroke(-1);
			strokeWeight(1);
			textSize(R*2/3);

			/*if (keyCode!=LEFT && keyCode!=RIGHT && frameCount%60>30)//frameCount%60>30	
				if (pass==0){
					line(x+textWidth(ss1),y+sz*rr+rr*5,x+textWidth(ss1),y+sz*rr+sz+rr*5);
				}
				else 
					line(x+textWidth(pass(ss1)),y+sz*rr+rr*5,x+textWidth(pass(ss1)),y+sz*rr+sz+rr*5);*/
		}

		y=yc;
		noStroke();
	}
	
	public void PressKeyProperly(){
		if(ok){
			if(PApplet.parseInt(key)==3){
				Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
				StringSelection selection = new StringSelection(s);
				clipboard.setContents(selection, selection);
				return;
			}
			else if(PApplet.parseInt(key)==22){
				Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
				Transferable contents = clipboard.getContents(null);
				DataFlavor flavor = DataFlavor.stringFlavor;
				Object contentData = null;

				if (contents != null && contents.isDataFlavorSupported(flavor)){
					try{
						contentData = contents.getTransferData(flavor);
					}
					catch (UnsupportedFlavorException exu){		//Completely Optional -> no freeze to death tho
						println("Unsupported flavor: " + exu);
					}
					catch (java.io.IOException exi){
						println("Unavailable data: " + exi);
					}
				}

				s = (String) contentData;
				cursor = s.length() - 1;
				return;
			}
		}

		textSize(sz);
		if (ok) {//} && delay==0) {
			if (s.length()>=1)
				if (s.charAt(cursor-1)=='\n')
					cursor--;
			delay=10;
			textSize(R*2/3);
			String ss1="";
			int ll=0,rr=0;
			for (int i=0;i<cursor;i++)
				if (s.charAt(i)=='\n') {
					rr++;
					ll=i;
				}
			for (int i=ll;i<cursor;i++)
				ss1=ss1+s.charAt(i);
			if (ll>0) ll++;
			stroke(-1);
			if (keyCode!=LEFT && keyCode!=RIGHT)//frameCount%60>30
				if (pass==0){
					line(x+textWidth(ss1),y+sz*rr+rr*5,x+textWidth(ss1),y+sz*rr+sz+rr*5);
				}
				else 
					line(x+textWidth(pass(ss1)),y+sz*rr+rr*5,x+textWidth(pass(ss1)),y+sz*rr+sz+rr*5);
			if (keyPressed) {//} && delay==0) { && frameCount%10==0
				delay=DELAY;
				if (key==8) {
					if (cursor>=1) {
						int i;
						String ss="",ss2;
						for (i=0;i<cursor-1;i++)
							ss+=s.charAt(i);
						for (i=cursor;i<s.length();i++)
							if (s.charAt(i)!='\n')
								ss+=s.charAt(i);
						s=ss;
						if (unRand==0) {
							ss=ss2="";
							for (i=0;i<ll;i++)
								ss+=s.charAt(i);
							for (i=ll;i<s.length();i++) {
								ss2+=s.charAt(i);
								if (pass==0 && textWidth(ss2)>w || pass==1 && textWidth(pass(ss2))>w) {
									ss+='\n';
									ss2="";
								}
								ss+=s.charAt(i);
							}
							s=ss;
						}
						cursor--;
					}
				}
				else if (keyCode==LEFT) {
					if (cursor-1>=0) {
						cursor--;
					}
				}
				else if (keyCode==RIGHT) {
					if (cursor+1<=s.length()) {
						cursor++;
					}
				}
				else  if (textWidth(key)>0) {
					//(keyCode!=UP && keyCode!=DOWN && (key>='0' && key<='9' || key>='a' && key<'z' || key>='A' && key<='Z')) {
					int i;
					String ss="",ss2="";
					for (i=0;i<cursor;i++)
						ss+=s.charAt(i);
					ss+=key;
					for (i=cursor;i<s.length();i++)
						if (s.charAt(i)!='\n')
							ss+=s.charAt(i);
					if (unRand==0) {
						s=ss;
						ss=ss2="";
						for (i=0;i<ll;i++)
							ss+=s.charAt(i);
						for (i=ll;i<s.length();i++) {
							ss2+=s.charAt(i);
							if (textWidth(ss2)>w) {
								ss+='\n';
								ss2="";
								if (i==cursor) cursor++;
							}
							ss+=s.charAt(i);
						}
						s=ss;
						cursor++;
					}
					else 
						if ((pass==0 && textWidth(ss)<w || pass==1 && textWidth(pass(ss))<w) && key!='\n') {
							s=ss;
							cursor++;
						}
				}
			}
		}
	}

}

public String pass(String s) {
	int i;
	String ss="";
	for (i=0;i<s.length();i++)
		if (textWidth(s.charAt(i))>0)
			ss+="*";
	return ss;
}
  public void settings() { 	fullScreen(); 	pixelDensity(displayDensity()); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AdaugareLectie" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
