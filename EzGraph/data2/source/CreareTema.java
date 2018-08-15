import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.bezier.data.sql.*; 
import java.awt.*; 
import java.awt.event.*; 
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

public class CreareTema extends PApplet {

		//DB
					//Transfarable data + Clipboard



					//EOF Clipboard
float midW, midH;
PApplet thisPapplet;
MySQL db;

public void setup() {
	
	initialize();
	
	thisPapplet = this;
	midW = width/2;
	midH = height/2;
	frameRate(60);
}

public void draw() {
	int i,j;
	noStroke();
	if (delay>0) delay--;
	if (STARTTEST) {
		background(c3);
		display_all_questions();
		fill(-1);
		stroke(-1);
	}
	else {
		background(c7);
		textSize(R);
		fill(-1);
		textAlign(CENTER,CENTER);
		drawStart();
		start.display();
		if (start.ok)
			STARTTEST=true;
		nQuestions=7;
		nQuestionsMax=6;
	}
}

public void mousePressed(){
	mousePress_all_questions();
	start.mousePress();
}

public void keyPressed(){
	keyPress_all_questions();
}

int saltCrypt = 10;					//computing complexity for crypting
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
class buton {
  float x,y,r;
  String s;
  int cFill=c1,cFill_o=c1_o;
  boolean pressed=false;
  
  buton(float x_,float y_,float r_,String s_) {
    x=x_;
    y=y_;
    r=r_;
    s=s_;
  }
  
  public void display() {
    if (s=="Delete graph") {
      if (dist(mouseX,mouseY,x,y)<r) {
        if (r<(R+R/4)/2) r+=2;
        if (mousePressed && delay==0) {
          delay=DELAY;
          for (int i=questions[questionActive].nGrafs-1;i>=0;i--)
            delete_point(questions[questionActive].g[i],questionActive);
        }
        fill(cFill_o);
      }
      else {
        fill(cFill);
        if (r>R/2) r-=2;
      }
    }
    else
      if (dist(mouseX,mouseY,x,y)<r || butonActive==s) {
        fill(cFill_o);
        if (r<(R+R/4)/2) r+=2;
        if (mousePressed)
          butonActive=s;
      }
      else {
        fill(cFill);
        if (r>R/2) r-=2;
      }
    
    noStroke();
    ellipse(x,y,r*2,r*2);
    
    fill(-1);
    textAlign(CENTER,CENTER);
    textSize(r/2.5f);
    //text(s,x-2*r,y+r,r*4,r);
    if(s.equals("Delete graph")) text("Sterge graf",x-2*r,y+r,r*4,r);
    else if(s.equals("Add point")) text("Adauga nod",x-2*r,y+r,r*4,r);
    else if(s.equals("Add edge")) text("Adauga muchie",x-2*r,y+r,r*4,r);
    else if(s.equals("Delete point")) text("Sterge nod",x-2*r,y+r,r*4,r);
    else if(s.equals("Delete edge")) text("Sterge muchie",x-2*r,y+r,r*4,r);
    else if(s.equals("Move")) text("Misca",x-2*r,y+r,r*4,r);
    fill(128,128,128);
  }

  public void mousePress(){
    if (s=="Delete graph") {
      if (dist(mouseX,mouseY,x,y)<r) {
        delay=DELAY;
        for (int i=questions[questionActive].nGrafs-1;i>=0;i--)
          delete_point(questions[questionActive].g[i],questionActive);
      }
    }
    else
      if (dist(mouseX,mouseY,x,y)<r || butonActive==s)
        butonActive=s;
  }
}

public void display_all_butons() {
  move.display();
  deleteEdge.display();
  deletePoint.display();
  addEdge.display();
  addPoint.display();
  deleteGraf.display();
}
class buton2 {
	float x,y,w,h;
	String s;
	boolean ok=false;
	int c=c6,c_o=c6_o;
	ToggleBtn privBtn;
	TextBoxTeo usrName, usrPass;

	buton2(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
	}

	public void display() {
		if (s=="Adauga tema"){
			if(privBtn==null)privBtn = new ToggleBtn(new PVector(width/2, 2*height/5), c, w, h, 0.2f, color(129, 27, 247), c_o, "PUBLIC", 1);
			else {
				privBtn.update();
				privBtn.display();				
			}
			if(usrName==null){
				usrName = new TextBoxTeo(new PVector(width/2 + w + 50, 2*height/5), color(102, 102, 102), w, h, 0.2f, color(138, 136, 140), color(166, 161, 173), 20, 20, 1);
				usrName.data = "Username / Email";
			}
			else {
				usrName.update();
				if(usrName.focus)textAlign(LEFT);
				else textAlign(CENTER, CENTER);
				usrName.display();
			}

			if(usrPass==null){
				usrPass = new TextBoxTeo(new PVector(width/2 + w + 50, 2*height/5 + h + 50), color(102, 102, 102), w, h, 0.2f, color(138, 136, 140), color(166, 161, 173), 20, 20, 1);
				usrPass.data = "Password";
			}
			else {
				usrPass.update();
				if(usrPass.focus)textAlign(LEFT);
				else textAlign(CENTER, CENTER);
				usrPass.display();
			}
		}
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) fill(c_o);
		else fill(c);
		rect(x,y,w,h);
		textSize(R/4);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);
	}

	public void mousePress(){
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) {
			if (!ok) {
				ok=true;
				if (s=="Adauga tema") {		//INSERT INTO DB OR CREATE FILE
					temaFinala="";
					int i,j;
					db = new MySQL(thisPapplet, "localhost", "ezgraphs", "root", "");    //localhost

					if(db.connect() && (!usrPass.data.equals("Password") && !usrPass.data.equals("")) && (!usrName.data.equals("Username / Email") && !usrName.data.equals("")) ){
						temaFinala=questions[nQuestionsMax-1].t.s;
						temaFinala+="+++sf";
						temaFinala+="+++sf";

						for (i=0;i<nQuestionsMax-1;i++) {
							temaFinala+=questions[i].tip1;
							temaFinala+="+++sf";
							temaFinala+=questions[i].t.s;
							temaFinala+="+++sf";
							temaFinala+=questions[i].tip2;
							temaFinala+="+++sf";

							if (questions[i].tip1==1) {
								temaFinala+=questions[i].or;
								temaFinala+="+++sf";
								temaFinala+=questions[i].nGrafs;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nGrafs;j++) {
									temaFinala+=PApplet.parseInt(questions[i].g[j].x) + " " + PApplet.parseInt(questions[i].g[j].y) + " "
											+ act(questions[i].g[j].active);
									temaFinala+="+++sf";

								}
								temaFinala+=questions[i].nEdges;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nEdges;j++) {
									temaFinala+=PApplet.parseInt(questions[i].e[j].a+1) + " " + PApplet.parseInt(questions[i].e[j].b+1) + " "
											+ act(questions[i].e[j].active);
									temaFinala+="+++sf";

								}
							}
							if (questions[i].tip2==1) {
								temaFinala+=questions[i].textb.s;
								temaFinala+="+++sf";

							}
							else if (questions[i].tip2==3) {
								temaFinala+=questions[i].raspunsuri[0].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[1].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[2].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].rasp;
								temaFinala+="+++sf";

							}
							temaFinala+="+++sf";
						}
						//DONE
						temaFinala=elimEndl(temaFinala);
						db.query("SELECT userID, nickname, email, pass, classID FROM users WHERE (nickname='"+usrName.data+"' OR email='"+usrName.data+"')");
						while(db.next()){
							String tmpPass = db.getString("pass");
							if(checkCrypted(usrPass.data, tmpPass)){
								int usrID = db.getInt("userID");
								int clsID = (!privBtn.toggle) ? db.getInt("classID") : -1;
								db.execute("INSERT INTO temadata VALUES(NULL, "+usrID+", "+clsID+", '"+temaFinala+"', '"+questions[nQuestionsMax-1].t.s+"', NOW())");
							}
						}
					}
					else{	//print to file
						PrintWriter output;
						output = createWriter("TEMA.txt");
						temaFinala=questions[nQuestionsMax-1].t.s;
						temaFinala+="+++sf";
						temaFinala+="+++sf";

						for (i=0;i<nQuestionsMax-1;i++) {
							temaFinala+=questions[i].tip1;
							temaFinala+="+++sf";
							temaFinala+=questions[i].t.s;
							temaFinala+="+++sf";
							temaFinala+=questions[i].tip2;
							temaFinala+="+++sf";

							if (questions[i].tip1==1) {
								temaFinala+=questions[i].or;
								temaFinala+="+++sf";
								temaFinala+=questions[i].nGrafs;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nGrafs;j++) {
									temaFinala+=PApplet.parseInt(questions[i].g[j].x) + " " + PApplet.parseInt(questions[i].g[j].y) + " "
											+ act(questions[i].g[j].active);
									temaFinala+="+++sf";

								}

								temaFinala+=questions[i].nEdges;
								temaFinala+="+++sf";

								for (j=0;j<questions[i].nEdges;j++) {
									temaFinala+=PApplet.parseInt(questions[i].e[j].a+1) + " " + PApplet.parseInt(questions[i].e[j].b+1) + " "
											+ act(questions[i].e[j].active);
									temaFinala+="+++sf";

								}
							}
							if (questions[i].tip2==1) {
								temaFinala+=questions[i].textb.s;
								temaFinala+="+++sf";

							}
							else if (questions[i].tip2==3) {
								temaFinala+=questions[i].raspunsuri[0].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[1].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].raspunsuri[2].t.s;
								temaFinala+="+++sf";
								temaFinala+=questions[i].rasp;
								temaFinala+="+++sf";

							}
							temaFinala+="+++sf";
						}
						output.print(temaFinala);
						output.flush();
						output.close();
					}
				}
			}
			fill(c_o);
		}
	}

}

public int act(boolean a) {
	if (a) return 1;
	else return 0;
}

public String elimEndl(String s) {
	int i,n=0;
	String ss="";
	for (i=0;i<s.length();i++)
		if (s.charAt(i)!='\n')
			ss+=s.charAt(i);
	println(ss);
	return ss;
}
int c1=color(0, 175, 234); //light blue
int c2=color(163, 205, 57); //green
int c3=color(28, 34, 40);  //black-blue
int c4=color(247, 240, 150); //light yellow
int c5=color(255, 89, 94); //red-pink
int c6=color(125, 131, 255); //light purple
int c7=color(19, 60, 85); //dark purple-blue
int c8=color(97, 83, 204); //purple

int c1_o=color(60, 235, 294); //light blue
int c2_o=color(183, 225, 77); //green
int c3_o=color(48, 54, 60);  //black-blue
int c4_o=color(267, 260, 170); //light yellow
int c5_o=color(275, 109, 114); //red-pink
int c6_o=color(145, 151, 275); //light purple
int c7_o=color(39, 80, 105); //dark purple-blue
int c8_o=color(117, 103, 224); //purple
float[] desx=new float[600];
float[] desy=new float[600];
float[] desr=new float[600];
float[] desx2=new float[600];
float[] desy2=new float[600];
float[] desr2=new float[600];
int[] perechiDesen1=new int[60000];
int[] perechiDesen2=new int[60000];
int nrDes=0,nrDes2=0,okDes=0;

float nod1x=1140;
float nod2x=1140;
float nod3x=1050;
float nod4x=1220;
float nod5x=1270;
float nod6x=1270;
float nod7x=1220;
float nod8x=1220;

float nod1y=110;
float nod2y=240;
float nod3y=175;
float nod4y=175;
float nod5y=110;
float nod6y=240;
float nod7y=40;
float nod8y=290;

////////////////////////////////

float nnod1x=1130;
float nnod2x=1130;
float nnod3x=1270;
float nnod4x=1050;
float nnod5x=1050;
float nnod6x=1050;
float nnod7x=1230;
float nnod8x=1180;

float nnod1y=500;
float nnod2y=650;
float nnod3y=575;
float nnod4y=575;
float nnod5y=500;
float nnod6y=650;
float nnod7y=575;
float nnod8y=575;

////////////////////////////////

float nnnod1x=1140;
float nnnod2x=1140;
float nnnod3x=1050;
float nnnod4x=1220;
float nnnod5x=1270;
float nnnod6x=1270;
float nnnod7x=1220;
float nnnod8x=1220;

float nnnod1y=110;
float nnnod2y=240;
float nnnod3y=175;
float nnnod4y=175;
float nnnod5y=110;
float nnnod6y=240;
float nnnod7y=40;
float nnnod8y=290;

int nnnok=1;
float nnnr=10;

public void updateGraf(float a,float b,int x) {
	if (x==1) {
		nnnod1x=lerp(nnnod1x,a,0.2f);
		nnnod1y=lerp(nnnod1y,b,0.2f);
	}
	else if (x==2) {
		nnnod2x=lerp(nnnod2x,a,0.2f);
		nnnod2y=lerp(nnnod2y,b,0.2f);
	}
	else if (x==3) {
		nnnod3x=lerp(nnnod3x,a,0.2f);
		nnnod3y=lerp(nnnod3y,b,0.2f);
	}
	else if (x==4) {
		nnnod4x=lerp(nnnod4x,a,0.2f);
		nnnod4y=lerp(nnnod4y,b,0.2f);
	}
	else if (x==5) {
		nnnod5x=lerp(nnnod5x,a,0.2f);
		nnnod5y=lerp(nnnod5y,b,0.2f);
	}
	else if (x==6) {
		nnnod6x=lerp(nnnod6x,a,0.2f);
		nnnod6y=lerp(nnnod6y,b,0.2f);
	}
	else if (x==7) {
		nnnod7x=lerp(nnnod7x,a,0.2f);
		nnnod7y=lerp(nnnod7y,b,0.2f);
	}
	else if (x==8) {
		nnnod8x=lerp(nnnod8x,a,0.2f);
		nnnod8y=lerp(nnnod8y,b,0.2f);
	}
}

public void drawGraf() {
	fill(-1,100);
	stroke(-1,100);
	strokeWeight(2);

	ellipse(nnnod1x,nnnod1y,nnnr*2,nnnr*2);
	ellipse(nnnod2x,nnnod2y,nnnr*2,nnnr*2);
	ellipse(nnnod3x,nnnod3y,nnnr*2,nnnr*2);
	ellipse(nnnod4x,nnnod4y,nnnr*2,nnnr*2);
	ellipse(nnnod5x,nnnod5y,nnnr*2,nnnr*2);
	ellipse(nnnod6x,nnnod6y,nnnr*2,nnnr*2);
	ellipse(nnnod7x,nnnod7y,nnnr*2,nnnr*2);
	ellipse(nnnod8x,nnnod8y,nnnr*2,nnnr*2);

	line(nnnod1x,nnnod1y,nnnod2x,nnnod2y);
	line(nnnod1x,nnnod1y,nnnod3x,nnnod3y);
	line(nnnod1x,nnnod1y,nnnod4x,nnnod4y);
	line(nnnod1x,nnnod1y,nnnod7x,nnnod7y);
	line(nnnod1x,nnnod1y,nnnod8x,nnnod8y);
	line(nnnod3x,nnnod3y,nnnod2x,nnnod2y);
	line(nnnod8x,nnnod8y,nnnod2x,nnnod2y);
	line(nnnod4x,nnnod4y,nnnod2x,nnnod2y);
	line(nnnod7x,nnnod7y,nnnod2x,nnnod2y);
	line(nnnod5x,nnnod5y,nnnod4x,nnnod4y);
	line(nnnod6x,nnnod6y,nnnod4x,nnnod4y);

	if (dist(nnnod1x,nnnod1y,mouseX,mouseY)<nnnr || dist(nnnod2x,nnnod2y,mouseX,mouseY)<nnnr || dist(nnnod3x,nnnod3y,mouseX,mouseY)<nnnr || 
		dist(nnnod4x,nnnod4y,mouseX,mouseY)<nnnr || dist(nnnod5x,nnnod5y,mouseX,mouseY)<nnnr || dist(nnnod6x,nnnod6y,mouseX,mouseY)<nnnr || 
		dist(nnnod7x,nnnod7y,mouseX,mouseY)<nnnr || dist(nnnod8x,nnnod8y,mouseX,mouseY)<nnnr)
		nnnok*=(-1);

	if (nnnok==1) {
		updateGraf(nod1x,nod1y,1);
		updateGraf(nod2x,nod2y,2);
		updateGraf(nod3x,nod3y,3);
		updateGraf(nod4x,nod4y,4);
		updateGraf(nod5x,nod5y,5);
		updateGraf(nod6x,nod6y,6);
		updateGraf(nod7x,nod7y,7);
		updateGraf(nod8x,nod8y,8);
	}
	else {
		updateGraf(nnod1x,nnod1y,1);
		updateGraf(nnod2x,nnod2y,2);
		updateGraf(nnod3x,nnod3y,3);
		updateGraf(nnod4x,nnod4y,4);
		updateGraf(nnod5x,nnod5y,5);
		updateGraf(nnod6x,nnod6y,6);
		updateGraf(nnod7x,nnod7y,7);
		updateGraf(nnod8x,nnod8y,8);
	}
}

public void drawStart() {
	//text(mouseX+" "+mouseY,mouseX,mouseY);
	fill(-1,13);
    beginShape();
    vertex(R*40,0);
    vertex(R*50,0);
    vertex(R*11,height);
    vertex(R*41,height);
    endShape();

    fill(234, 255, 10,13);
    beginShape();
    vertex(R*2,0);
    vertex(R*15,0);
    vertex(R*10,height);
    vertex(R*6,height);
    endShape();

    fill(256,0,0,13);
    beginShape();
    vertex(-R*45,0);
    vertex(-R*10,0);
    vertex(R*46,height);
    vertex(R*37,height);
    endShape();

    fill(0,256,0,13);
    beginShape();
    vertex(R*9,0);
    vertex(R*20	,0);
    vertex(R*30,height);
    vertex(R*45,height);
    endShape();

    fill(176, 244, 66,13);
    beginShape();
    vertex(R*28,0);
    vertex(R*39	,0);
    vertex(0,height);
    vertex(-R*2,height);
    endShape();

    //drawGraf();
    drawDesen();
}

public void drawDesen() {
	int i,ok,j;
	float x;
	noStroke();
	fill(-1,12);
	for (i=0;i<200;i++) {
		if (nrDes<=200) {
			nrDes++;
			ok=0;
			while (ok==0) {
				ok=1;
				desx[i]=desx2[i]=random(0,width);
				desy[i]=desy2[i]=random(0,height);
				desr[i]=desr2[i]=random(10,20);
				for (j=0;j<i;j++)
					if (dist(desx[i],desy[i],desx[j],desy[j])<50) {
						ok=0;
						break;
					}
			}
		}
		desx[i]=lerp(desx[i],desx2[i],0.2f);
		desy[i]=lerp(desy[i],desy2[i],0.2f);
		desr[i]=lerp(desr[i],desr2[i],0.2f);
		ellipse(desx[i],desy[i],desr[i],desr[i]);
	}
	stroke(-1,12);
	strokeWeight(1);
	for (i=0;i<199;i++)
		for (j=i+1;j<200;j++)
			if (dist(desx[i],desy[i],desx[j],desy[j])<100)
				line(desx[i],desy[i],desx[j],desy[j]);

	if (mousePressed && delay==0) {
		delay=DELAY;
		for (i=0;i<200;i++) {
			ok=0;
			while (ok==0) {
				ok=1;
				desx2[i]=random(0,width);
				desy2[i]=random(0,height);
				desr2[i]=random(10,20);
				for (j=0;j<i;j++)
					if (dist(desx2[i],desy2[i],desx2[j],desy2[j])<50){//desr2[i]+desr2[j]) {
						ok=0;
						break;
					}
			}
		}
	}
}

public void drawLinii() {
	int i,ok,j;
	float x;
	for (i=0;i<400;i++) {
		if (nrDes2<=400) {
			nrDes2++;
			ok=0;
			while (ok==0) {
				ok=1;
				desx[i]=random(0,width);
				desy[i]=random(0,height);
				desr[i]=random(10,20);
				if (i<200) {
					for (j=0;j<i;j++)
						if (dist(desx[i],desy[i],desx[j],desy[j])<50) {
							ok=0;
							break;
						}
				}
				else if (i<400) {
					for (j=200;j<i;j++)
						if (dist(desx[i],desy[i],desx[j],desy[j])<50) {
							ok=0;
							break;
						}
				}
			}
		}
	}
	if (okDes==0) {
		for (i=0;i<199;i++)
			for (j=i+1;j<200;j++)
				if (dist(desx[i],desy[i],desx[j],desy[j])<100) {
					perechiDesen1[okDes]=i;
					perechiDesen2[okDes]=j;
					okDes++;
				}

					//line(desx[i],desy[i],desx[j],desy[j]);
		for (i=200;i<399;i++)
			for (j=i+1;j<400;j++)
				if (dist(desx[i],desy[i],desx[j],desy[j])<100) {
					perechiDesen1[okDes]=i;
					perechiDesen2[okDes]=j;
					okDes++;
				}
					//line(desx[i],desy[i],desx[j],desy[j]);
	}
	strokeWeight(1);
	stroke(-1,20);
	for (i=0;i<okDes/2;i++)
		if (dist(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]])<100)
			line(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]]);
	stroke(-1,10);
	for (i=okDes/2;i<okDes;i++)
		if (dist(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]])<100)
			line(desx[perechiDesen1[i]],desy[perechiDesen1[i]],desx[perechiDesen2[i]],desy[perechiDesen2[i]]);
}
class drawing {
	float x,y,r,r1;
	int val;

	drawing(float xx,float yy,float rr,int vall) {
		val=vall;
		x=xx;
		y=yy;
		r=rr;
	}

	public void display() {
		noStroke();
		if (val>=8) fill(0,256,0);
		else if (val>=5) fill(256,256,0);
		else fill(256,0,0);
		ellipse(x,y,r*2,r*2);
		fill(questions[0].c_Fill2);
		ellipse(x,y,(r-r/10)*2,(r-r/10)*2);
		if (val>=8) fill(0,256,0);
		else if (val>=5) fill(256,256,0);
		else fill(256,0,0);
		ellipse(x-r/2,y-r/2+r/5,r/7*2,r/7*2);
		ellipse(x+r/2,y-r/2+r/5,r/7*2,r/7*2);
		fill(questions[0].c_Fill2);
		ellipse(x-r/2,y-r/2+r/5,r/10*2,r/10*2);
		ellipse(x+r/2,y-r/2+r/5,r/10*2,r/10*2);
		if (val>=8) {
			fill(0,256,0);
			arc(x,y+r/8,r,r,0,PI);
			fill(questions[0].c_Fill2);
			arc(x,y+r/8-3,r-r/10,r-r/10,0,PI);
		}
		else if (val>=5) {
			fill(256,256,0);
			rect(x-r/2-r/8,y+r/5,r+r/4,r/10);
		}
		else {
			fill(256,0,0);
			arc(x,y+r/2,r,r,PI,2*PI);
			fill(questions[0].c_Fill2);
			arc(x,y+r/2+3,r-r/10,r-r/10,PI,2*PI);	
			fill(0,256,256);
			beginShape();
			vertex(x-r/2,y-r/2+r/5+r/7);
			vertex(x-r/2-r/12,y-r/2+r/5+r/4+r/7);
			vertex(x-r/2+r/12,y-r/2+r/5+r/4+r/7);
			endShape();
			arc(x-r/2,y-r/2+r/5+r/4-1+r/7,r/6,r/6,0,PI);
		}
	}

}
class edge {
  float x,y,x2,y2,w1,w2,l=20,w3,w11,w22,q;
  int cStroke=c1;
  int cStroke_o=c1_o;
  int number;
  int a,b,nr;
  boolean active=true;
  graf a1,b1;
  
  edge(int a_,int b_,int nrr) {
    a=a_; ///nodul 1
    b=b_; ///nodul2
    nr=nrr;
    number=questions[nr].nEdges+1;
  }
  
  public void display() {
    number=questions[nr].nEdges;
    x=questions[nr].g[a].x;
    y=questions[nr].g[a].y;
    x2=questions[nr].g[b].x;
    y2=questions[nr].g[b].y;
    
    if (a==isToMove || b==isToMove) ///daca nodul se misca, muchiile sunt rosii
      stroke(256,0,0);
    else if (abs(dist(mouseX,mouseY,x,y)+dist(mouseX,mouseY,x2,y2)-dist(x,y,x2,y2))<0.5f) { ///daca muchia are cursorul peste ea
      stroke(cStroke_o);
      if (butonActive=="Delete edge") { ///stergere muchie
        stroke(256,0,0); ///daca muchia are cursorul peste ea si este pe cale sa fie stearsa este rosie
        if (mousePressed)
           delete_edge(this,nr);///dezactivarea/stergerea muchiei
      }
    }
    else
      stroke(cStroke);
    
    if (butonActive=="Delete point") { ///daca nodul este pe cale sa fie sters, muchia este rosie
      if (active && (dist(mouseX,mouseY,questions[nr].g[a].x,questions[nr].g[a].y)<questions[nr].g[a].r ||
          dist(mouseX,mouseY,questions[nr].g[b].x,questions[nr].g[b].y)<questions[nr].g[b].r))
        stroke(256,0,0);
    }
    
    strokeWeight(R/10);
    //line(x,y,x2,y2);
    noFill();
    if (questions[nr].or==2) {
      if (x!=x2)
        w3=atan((y-y2)/(x-x2));
      else w3=PI/2;
      if (y2<y) w3=-w3;
      PVector v1=new PVector(x2-x,y2-y);
      PVector v2=new PVector(width,0);
      w3=radians(PVector.angleBetween(v2, v1));
      if (y2<y) w3=-w3;
      w3=w3*180/PI;
      q=dist(x,y,x2,y2)/3;
      w1=q*cos(w3-PI/8);
      w2=q*sin(w3-PI/8);
      w11=q*cos(w3+PI/8+PI);
      w22=q*sin(w3+PI/8+PI);
      /*line(x,y,x+w1,y+w2);
      line(x+w1,y+w2,x2+w11,y2+w22);
      line(x2,y2,x2+w11,y2+w22);
      //*/bezier(x,y,x+w1,y+w2,x2+w11,y2+w22,x2,y2);
    }
    else line(x,y,x2,y2);
    fill(256,0,0);
    a1=questions[nr].g[a];
    b1=questions[nr].g[b];
    if (questions[nr].or==2) {
      //noStroke();
      //stroke(0,256,0);
      //fill(0,256,0);
      q=R/2;
      //w1=R*(x2-x)/dist(x,y,x2,y2);
      //w2=R*(y2-y)/dist(x,y,x2,y2);
      w1=q*cos(w3+PI+PI/8);
      w2=q*sin(w3+PI+PI/8);
      w11=R*cos(w3+PI/10+PI+PI/8);
      w22=R*sin(w3+PI/10+PI+PI/8);
      line(x2+w1,y2+w2,x2+w1+w11/2,y2+w2+w22/2);
      //ellipse(x2+w1,y2+w2,20,20);
      w11=R*cos(w3-PI/5+PI+PI/8);
      w22=R*sin(w3-PI/5+PI+PI/8);
      line(x2+w1,y2+w2,x2+w1+w11/2,y2+w2+w22/2);
      /*q=R+10;
      w11=q*cos(w3+PI+PI/8);
      w22=q*sin(w3+PI+PI/8);
      ellipse(x2+w11,y2+w22,20,20);*/
    }
    if (butonActive=="Delete edge" && questions[nr].or==2) {
      noStroke();
      int j=(int)(dist(x,y,x2,y2)/5);
      for (int i=1;i<=j;i++)
        ellipse(x+(x2-x)/j*i,y+(y2-y)/j*i,2,2);
    }
  }
  
}

public void delete_edge(edge a,int nr) {
  a.active=false;
}

public void add_edge(graf a,graf b,int nr) {
  int k=1;
  for (int kk=0;kk<questions[nr].nEdges;kk++) ///verifica daca muchia este deja existenta
    if (questions[nr].e[kk].active) {
      if (questions[nr].or==1) {
        if (questions[nr].e[kk].a==a.number-1 && questions[nr].e[kk].b==b.number-1 || questions[nr].e[kk].a==b.number-1 &&
           questions[nr].e[kk].b==a.number-1) {
          k=0;
          break;
        }
      }
      else 
        if (questions[nr].or==2)
          if (questions[nr].e[kk].a==a.number-1 && questions[nr].e[kk].b==b.number-1) {
            k=0;
            break;
          }
    }
    else {
      questions[nr].e[kk].active=true; ///daca exista o muchie inactiva, aceea devine noua muchie
      questions[nr].e[kk].a=a.number-1;
      questions[nr].e[kk].b=b.number-1;
      k=-1;
      break;
    }
  if (k==1) { ///daca muchia nu exista, o adauga
    questions[nr].e[questions[nr].nEdges++]=new edge(a.number-1,b.number-1,nr);
    selected1=-1;
  }
}

public void display_all_edges(int nr) {
  int i;
  for (i=0;i<questions[nr].nEdges;i++)
    if (questions[nr].e[i].active)
      questions[nr].e[i].display();
}
PImage logo;
PImage fundal2; 
int nnGrafs;
int questionActive;
int okSend=1;
int nQuestions,nQuestionsMax;
int delay=0,DELAY=20;
int selected1=-1;
int isToMove=-1;

buton move;
buton deleteEdge;
buton deletePoint;
buton addEdge;
buton addPoint;
buton deleteGraf;
buton2 start;

question[] questions=new question[200];

float R;
float margTop;
float margLeft;

boolean STARTTEST = false;
boolean  or=false;

String nume_test="";
String butonActive="";
String temaFinala="";
class graf {
  float x,y,r;
  int cFill=c2,cStroke=c5;
  int cFill_o=c2_o,cStroke_o=c5_o;
  int number;
  int nr;
  boolean selected=false,active=true,or=false;
  graf(float x_,float y_,float r_,int nrr) {
    x=x_;
    y=y_;
    r=r_;
    nr=nrr;
    number=questions[nr].nGrafs+1;
  }
  
  public void display() {
    if (questionActive==nr) {
      if (dist(mouseX,mouseY,x,y)<r || isToMove==number-1) {
        if (r<(R+R/3)/2) r++; ///mareste nodul daca cursorul este pe el
        if (mousePressed)
          if (butonActive=="Move") { ///move
            if (isToMove==-1)
              isToMove=number-1;
          }
          else if (butonActive=="Add edge" && delay==0) { ///adauga muchie
            delay=DELAY;
            if (selected1!=-1)
              if (selected1!=number-1)
                add_edge(questions[nr].g[selected1],questions[nr].g[number-1],nr);
              else selected1=-1;
            else selected1=number-1;
          }
          else if (butonActive=="Delete point") //sterge/dezactiveaza nodul si muchiile lui
            delete_point(questions[nr].g[number-1],nr);
        fill(cFill_o);
        stroke(cStroke_o);
      }
      else {
        fill(cFill);
        stroke(cStroke);
        if (r>R/2) r--; ///daca cursorul nu este pe el raza scade pana ajunge la forma initiala
      }
      
      if (butonActive=="Add edge") {
        if (selected1==number-1) ///daca nodul este primul nod selectat pentru o crea o muchie atunci el are conturul rosu
          stroke(256,0,0);
      }
      else if (selected1!=-1)
        selected1=-1;
      
      if (isToMove==number-1 && isBetween(width/2+r,width-r,mouseX) && isBetween(move.y+R*2,height-r,mouseY)) {// && mouseX-R>margLeft+R && mouseY>margTop+R && mouseY+R<ex.y) { ///se muta nodul unde este cursorul
        x=mouseX;
        y=mouseY;
      }
      
      strokeWeight(r/5);
      ellipse(x,y,r*2,r*2);
      fill(-1);
      textAlign(CENTER,CENTER);
      textSize(r);
      text(str(number),x-r,y-r,r*2,r*2);
      
      if (butonActive=="Delete point" && active && dist(mouseX,mouseY,x,y)<r) { ///daca este pe cale sa fie sters, are un X rosu desenat peste
          stroke (256,0,0);
          line(x-r,y-r,x+r,y+r);
          line(x+r,y-r,x-r,y+r);
      }
    }
  }
}

public void delete_point(graf a,int nr) {
  a.active=false;
  if (questionActive==nr) {
    for (int k=0;k<questions[nr].nEdges;k++)
      if (questions[nr].e[k].active && (questions[nr].e[k].a==a.number-1 || questions[nr].e[k].b==a.number-1))
        delete_edge(questions[nr].e[k],nr);
    while (questions[nr].nGrafs>=1 && !questions[nr].g[questions[nr].nGrafs-1].active)
      questions[nr].nGrafs--;
  }
}

public void add_graf(float x,float y,int nr) {
  int k,ok=-1;
  if (questionActive==nr) {
    for (k=0;k<questions[nr].nGrafs;k++)
      if (!questions[nr].g[k].active) {
        ok=k;
        break;
      }
      
    if (ok==-1) {
      questions[nr].g[questions[nr].nGrafs]=new graf(x,y,R/2,nr);
      questions[nr].nGrafs++;
    }
    else {
      questions[nr].g[ok].active=true;
      questions[nr].g[ok].x=x;
      questions[nr].g[ok].y=y;
    }
    delay=DELAY;
  }
}

public void display_all_grafs(int nr) {
  int i;
  if (questionActive==nr) {
    for (i=0;i<questions[questionActive].nGrafs;i++)
      if (questions[questionActive].g[i].active)
        questions[questionActive].g[i].display();
    }
}

public void mouseReleased() {
  if (isToMove!=-1) ///daca am un nodul selectat pentru mutare, dar nu mai tin apasat pe el
    isToMove=-1;
}
public void initialize() {
	int i;
	float x;
	logo = loadImage("icon2_1-01.png");
	surface.setIcon(logo);

	graf[] g=new graf[200];
	edge[] e=new edge[200];

	//add_test("tema1");

	R=width/20;

	add_question("1","","","",0,0,0,g,e,0,0,0);
	graf[] g1=new graf[200];
	edge[] e1=new edge[200];
	add_question("2","","","",0,0,0,g1,e1,0,0,0);
	graf[] g2=new graf[200];
	edge[] e2=new edge[200];
	add_question("3","","","",0,0,0,g2,e2,0,0,0);
	graf[] g3=new graf[200];
	edge[] e3=new edge[200];
	add_question("4","","","",0,0,0,g3,e3,0,0,0);
	graf[] g4=new graf[200];
	edge[] e4=new edge[200];
	add_question("5","","","",0,0,0,g4,e4,0,0,0);
	graf[] g5=new graf[200];
	edge[] e5=new edge[200];
	add_question("Nume tema","","","",0,0,0,g5,e5,0,0,0);
	graf[] g6=new graf[200];
	edge[] e6=new edge[200];
	add_question("Submit","","","",0,0,0,g6,e6,0,0,0);

	questionActive=0;
	nQuestions=0;
	nQuestionsMax=6;
	nnGrafs=5;

	start=new buton2(width/2-R*2,height/2-R/2,R*4,R,"Incepe crearea temei");
	nQuestions=5;
	
	isToMove=-1;


	margLeft=width/2;
    margTop=R*5;
    x=width-margLeft;
	x=x/6-2*R;
  	x=x*2;
    move=new buton(width/2+R,3*R,R/2,"Move");
    deleteEdge=new buton(width/2+R*3/2+R,3*R,R/2,"Delete edge");
    deletePoint=new buton(width/2+R*2*3/2+R,3*R,R/2,"Delete point");
    addEdge=new buton(width/2+R*3*3/2+R,3*R,R/2,"Add edge");
    addPoint=new buton(width/2+R*4*3/2+R,3*R,R/2,"Add point");
    deleteGraf=new buton(width/2+R*5*3/2+R,3*R,R/2,"Delete graph");

    fundal2=loadImage("backgr5-01.png");
    if (fundal2.width*height/width>=height)
		fundal2.resize(width,fundal2.width*height/width);
	else 
		fundal2.resize(fundal2.height*width/height,height);
}

/*

tip1:
1. Cu graf
2. Deseneaza graf
3. Fara graf

tip2:
1. Cu textbox
2. Doar desenare (pentru 2)
3. Cu variante a,b,c

numar intrebari

tip1
intrebare
tip2
tip2==1: varianta raspuns
tip2==2: nimic
tip2==3: var1,var2,var3,varianta corecta

*/
public boolean isBetween(float a,float b,float x) {
  if (a<=x && x<=b) return true;
  else return false;
}
class list {
	float x,y,w,h,h2;
	int nr,selectat,number;
	int c=c6,c_o=c8,c2=c8_o;
	String s;
	String[] elemente;
	boolean ok;

	list(float xx,float yy,float ww,float hh,float hh2,String ss,int numberr) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		h2=hh2;
		s=ss;
		nr=0;
		selectat=-1;
		elemente=new String[30];
		ok=false;
		number=numberr;
	}

	public void display() {
		int i;
		boolean ok2;
		if (isBetween(x,x+w,mouseX) && (ok && isBetween(y,y+h+nr*h,mouseY) || isBetween(y,y+h,mouseY))) {
			fill(c_o);
		}
		else {
			ok=false;
			fill(c);
		}
		fill(c);
		noStroke();
  		textAlign(CENTER,CENTER);
		rect(x,y,w,h);
		fill(0,256,0);
		textSize(h/3);
		if (selectat==-1)// || ok)
			text(s,x,y,w,h);
		else 
			text(s+": "+elemente[selectat],x,y,w,h);

		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY))
			ok=true;
		if (ok) {
			for (i=0;i<nr;i++) {
				if (selectat==i) fill(c_o);
				else if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY)) fill(c2);
				else fill(c);
				if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY)) {
					fill(c2);
					ok2=true;
				}
				rect(x,y+h+i*h2,w,h2);
				fill(-1);
				textSize(h2/3);
				text(elemente[i],x,y+h+i*h2,w,h2);
			}
		}
		
	}

	public void mousePress(){
		int i;
		if (ok) {
			for (i=0;i<nr;i++) {
				if (isBetween(x,x+w,mouseX) && isBetween(y+h+i*h2,y+h+(i+1)*h2,mouseY)) {
					if (selectat!=i)
						selectat=i;
					else selectat=-1;
				}
			}
		}
	}
}

public void addElement(String s,list l) {
	if (l.nr<30) {
		l.elemente[l.nr]=s;
		l.nr++;
	}
}
class question {
	float x,y,w,h,w2,x2,y2,h2,h3;
	int c_Fill=c8,c_Fill_o=c8,c_Fill2=c7,c_Fill2_o=c7_o,c_Fill3=c6;
	int number=0,rasp=-1,rc,tip1,tip2,nGrafs,nEdges,tb,or;
	String s,r1,r2,r3,r4;
	raspuns[] raspunsuri=new raspuns[3];
	buton2 b;
	drawing desen=null;
	graf[] g;
	edge[] e;
	textbox textb,t;
	list choose,choose2,choose3;

	question(float xx,float yy,float ww,float hh,float xx2,float yy2,float ww2,float hh2,float hh3,int nrr,
					String ss,String rr1,String rr2,String rr3,int rcc,int tipp1,int tipp2,graf[] grafss,
					edge[] edgess,int nGrafss,int nEdgess,int tbb) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		x2=xx2;
		y2=yy2;
		w2=ww2;
		h2=hh2;
		h3=hh3;
		number=nrr;
		s=ss;
		r1=rr1;
		r2=rr2;
		r3=rr3;
		rc=rcc;
		tip1=tipp1;
		tip2=tipp2;
		g=grafss;
		e=edgess;
		nGrafs=nGrafss;
		nEdges=nEdgess;
		or=0;
		tb=tbb;
		if (number==nQuestionsMax) {
			w2=width-R/10-questions[number-1].x2-questions[number-1].w2;
			x2=questions[number-1].x2+questions[number-1].w2+R/10;
			b=new buton2(x+R,y+R*4,R*2,R,"Adauga tema");
		}
		else if (number==nQuestionsMax-1) {
			w2=width-R/10-questions[number-1].x2-questions[number-1].w2;
			w2/=2;
		}
		
		textb=new textbox(x+R,y+R*4,width/2-R,R,R/4,1,0,number);
		raspunsuri[0]=new raspuns(x+R,y+R*4,width/2-R,R,r1,nrr,0);
		raspunsuri[1]=new raspuns(x+R,y+R*5+R/10,width/2-R,R,r2,nrr,1);
		raspunsuri[2]=new raspuns(x+R,y+R*6+R/10*2,width/2-R,R,r3,nrr,2);

		choose=new list(x,y,R*4,R*2/3,R/2,"Tip1 intrebare",number);
		addElement("Cu graf",choose);
		addElement("Fara graf",choose);

		choose2=new list(choose.x+choose.w+1,y,R*4,R*2/3,R/2,"Tip2 intrebare",number);
		addElement("Cu textBox",choose2);
		addElement("Cu variante multiple",choose2);

		choose3=new list(choose2.x+choose2.w+1,y,R*4,R*2/3,R/2,"Tip graf",number);
		addElement("Neorientat",choose3);
		addElement("Orientat",choose3);

		t=new textbox(x+R,y+R,w-R*2,R*2,R/3,0,0,number);
	}

	public void display() {
		int i;
		noStroke();
		if (number<nQuestionsMax-1) {
			if (questionActive==number) {
				if (choose.selectat==0) tip1=1;
				else if (choose.selectat==1) tip1=3;
				else tip1=0;
				if (choose2.selectat==0) tip2=1;
				else if (choose2.selectat==1) tip2=3;
				else tip2=0;
				if (choose3.selectat==0) or=1;
				else if (choose3.selectat==1) or=2;
				else or=0;

				if (tip2==1)
					if (tip1==3)
						textb.w=width-R*2;
					else
						textb.w=width/2-R;
				if (tip1==1) {
					raspunsuri[0].w=width/2-R;
					raspunsuri[1].w=width/2-R;
					raspunsuri[2].w=width/2-R;
				}
				else if (tip1==3) {
					raspunsuri[0].w=width-R*2;
					raspunsuri[1].w=width-R*2;
					raspunsuri[2].w=width-R*2;
				}

				fill(c_Fill2);
				if (questions[nQuestionsMax].b.ok)
					fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				if (tip1!=3)
					t.w=w/2-R;
				else
					t.w=w-R*2;
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3))
					t.display();
				fill(-1);
				textSize(R/4);
				textAlign(CENTER,CENTER);
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3)) {
					if (tip2==1) {
						textb.display();
					}
					else if (tip2==3) {
						raspunsuri[0].display();
						raspunsuri[1].display();
						raspunsuri[2].display();
					}
					if (tip1==1) {
						display_all_edges(questionActive);
						display_all_grafs(questionActive);
						display_all_butons();
						/*if (mousePressed && delay==0 && butonActive=="Add point" && nGrafs<200 &&
								isBetween(width/2+R,width,mouseX) && isBetween(move.y+R,height,mouseY)) {
				        	add_graf(mouseX, mouseY,questionActive);
				    	}*/
					}
				}
				choose.display();
				choose2.display();
				if (tip1==1)
					choose3.display();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions[nQuestionsMax].b.ok)
						fill(80,256,80);
					//if (mousePressed) questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions[nQuestionsMax].b.ok)
						 fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else if (number==nQuestionsMax-1) {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				t.display();
				s=t.s;
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					//if (mousePressed) questionActive=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text("Nume tema",x2,y2,w2,h2);
		}
		else {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//desen=new drawing(w/2,h/4*3,R*3,10);
				//desen.display();
				if (questions[nQuestionsMax].b.ok) {
					text("Tema adaugata.",x+R,y+R,w-R*2,R*2);
				}
				else if (verif_rasp()<nQuestionsMax)
					text("Adauga toate intrebarile!",x+R,y+R,w-R*2,R*2);
				else {
					text("Poti adauga tema.",x+R,y+R,w-R*2,R*2);
					b.display();
				}
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					//if (mousePressed) questionActive=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text("Adauga tema",x2,y2,w2,h2);
		}
	}

	public void mousePress(){
		if(b!=null && b.s.equals("Adauga tema") && questionActive==number){
			if(b.privBtn!=null && b.privBtn.isHovered(mouseX, mouseY))
				b.privBtn.toggle = (b.privBtn.toggle) ? false : true;
			if(b.usrName!=null)
				b.usrName.focus = (b.usrName.isHovered(mouseX, mouseY)) ? true : false;
			if(b.usrPass!=null)
				b.usrPass.focus = (b.usrPass.isHovered(mouseX, mouseY)) ? true : false;
		}
		int i;
		if (number<nQuestionsMax-1) {
			if (questionActive==number) {
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3))
					t.display();			//keyPress
				
				textAlign(CENTER,CENTER);
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3)) {
					if (tip2==1) {
						textb.display();	//keyPress
					}
					else if (tip2==3) {
						raspunsuri[0].mousePress();
						raspunsuri[1].mousePress();
						raspunsuri[2].mousePress();
					}
					if (tip1==1) {
						display_all_edges(questionActive);
						display_all_grafs(questionActive);
						display_all_butons();
						if (delay==0 && butonActive=="Add point" && nGrafs<200 && isBetween(width/2+R,width,mouseX) && isBetween(move.y+R,height,mouseY)) {
				        	add_graf(mouseX, mouseY,questionActive);
				    	}
					}
				}
				choose.mousePress();			//mouse Press????? maybe		===>  !!
				choose2.mousePress();
				if (tip1==1)
					choose3.mousePress();
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY))questionActive=number;
		}
		else if (number==nQuestionsMax-1) {
			if (questionActive==number) {
				textSize(R/4);
				t.display();		//keyPress
				s=t.s;
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY))questionActive=number;
		}
		else {
			if (questionActive==number) {
				if (questions[nQuestionsMax].b.ok) {
					int kkk;
				}
				else if (verif_rasp()<nQuestionsMax){
					int kkk;
				}
				else {
					int kkk;
					b.mousePress();
				}
			}
			else if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) questionActive=number;
		}
	}

	public void keyPress(){
		if(b!=null && b.s.equals("Adauga tema") && questionActive==number){
			if(b.usrName!=null && b.usrName.focus)
				b.usrName.keyIsPressed();
			if(b.usrPass!=null && b.usrPass.focus)
				b.usrPass.keyIsPressed();
		}
		int i;
		if (number<nQuestionsMax-1) {
			if (questionActive==number) {
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3))
					t.keyPress();			//keyPress
				
				textAlign(CENTER,CENTER);
				if (tip1>0 && tip2>0 && (tip1==1 && or>0 || tip1==3)) {
					if (tip2==1) {
						textb.keyPress();	//keyPress
					}
					else if (tip2==3) {
						raspunsuri[0].keyPress();
						raspunsuri[1].keyPress();
						raspunsuri[2].keyPress();
					}
					if (tip1==1) {
						display_all_edges(questionActive);
						display_all_grafs(questionActive);
						display_all_butons();
						/*if (mousePressed && delay==0 && butonActive=="Add point" && nGrafs<200 && isBetween(width/2+R,width,mouseX) && isBetween(move.y+R,height,mouseY)) {
				        	add_graf(mouseX, mouseY,questionActive);
				    	}*/
					}
				}
			}
		}
		else if (number==nQuestionsMax-1) {
			if (questionActive==number) {
				textSize(R/4);
				t.keyPress();		//keyPress
				s=t.s;
			}
		}
		else {
			if (questionActive==number) {
				if (questions[nQuestionsMax].b.ok) {
					int kkk;
				}
				else if (verif_rasp()<nQuestionsMax){
					int kkk;
				}
				else {
					int kkk;
				}
			}
		}
	}
}

public void mousePress_all_questions(){
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].mousePress();
}

public void keyPress_all_questions(){
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].keyPress();
}

public void display_all_questions() {
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].display();
}

public int verif_rasp() {
	int i,ok=0;
	for(i=0;i<nQuestionsMax;i++)
		if (questions[i].t.s.length()>0 && (questions[i].tip1>0 && questions[i].tip2>0 && (questions[i].tip1==1
				&& questions[i].or>0 || questions[i].tip1==3))) {
			if (questions[i].tip2==3) {
				if (questions[i].rasp!=-1 && questions[i].raspunsuri[0].t.s.length()>0 && questions[i].raspunsuri[1].t.s.length()>0
					 && questions[i].raspunsuri[2].t.s.length()>0) {
					ok++;
					//print(1);
				}
				//else print(0);
			}
			else if (questions[i].tip2==1) {
				if (questions[i].textb.s.length()>0) {
					ok++;
					//print(1);
				}
				//else print(0);
			}
		}
		//else print(0);
	if (questions[nQuestionsMax-1].s.length()>0)
		ok++;
	//print("  :     ",ok,'\n');
	return ok;
}

public boolean compareStrings(String a,String b) {
	String aa="",bb="";
	int i;
	boolean ok=true;
	for (i=0;i<a.length();i++)
		if (textWidth(a.charAt(i))>0)
			aa+=a.charAt(i);
	for (i=0;i<b.length();i++)
		if (textWidth(b.charAt(i))>0)
			bb+=b.charAt(i);
	if (aa.length()!=bb.length()) ok=false;
	else
		for (i=0;i<aa.length();i++)
			if (aa.charAt(i)!=bb.charAt(i)) {
				ok=false;
				break;
			}
	return ok;
}

public int verif_rasp_rez() {
	int i,ok=0;
	for(i=0;i<nQuestions;i++) {
		if (questions[i].tip2==3) {
			if (questions[i].raspunsuri[questions[i].rc].bif==1) ok++;
		}
		else if (questions[i].tip2==1) {
			if (to_nr(questions[i].textb.s)==questions[i].rc)
				ok++;
		}
	}
	return ok*2;
}

public int to_nr(String s) {
	int nr=0,i;
	for (i=0;i<s.length();i++)
		nr=nr*10+PApplet.parseInt(s.charAt(i))-'0';
	return nr;
}

public void add_question(String s1,String s2,String s3,String s4,int rc,int tip1,int tip2,graf[] g,edge[] e,int n1,int n2,int tb) {
	nQuestionsMax=6;
	R=width/20;
	if (nQuestions>=1)
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,questions[nQuestions-1].x2+R+R/10,
			0,R,R,R*2,nQuestions,s1,s2,s3,s4,rc,tip1,tip2,g,e,n1,n2,tb);
	else {
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,0,0,R,R,R*2,0,s1,s2,s3,s4,rc,tip1,tip2,g,e,n1,n2,tb);
		questionActive=0;
	}
	nQuestions++;
}


/*

tip1:
1. Cu graf
2. Deseneaza graf
3. Fara graf

tip2:
1. Cu textbox
2. Doar desenare (pentru 2)
3. Cu variante a,b,c

numar intrebari

tip1
intrebare
tip2
tip2==1: varianta raspuns
tip2==2: nimic
tip2==3: var1,var2,var3,varianta corecta

*/
class raspuns {
	float x,y,w,h,r1=R/6,r2=R/12;
	String s;
	int number,bif,rasp,ctr,ok;
	int c_Fill=c6,c_Fill_o=c6_o;
	textbox t;

	raspuns(float xx,float yy,float ww,float hh,String ss,int nrr,int ctrr) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
		number=nrr;
		ctr=ctrr;
		bif=0;
		rasp=-1;
		ok=0;
		t=new textbox(x+R,y,w-R,h,R/4,1,0,number);
	}

	public void display() {
		noStroke();
		t.w=w-R;
		
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			fill(c_Fill_o);
			fill(-1,60);
		}
		else {
			fill(c_Fill);
			fill(-1,30);
		}
		stroke(-1);
		strokeWeight(2);
		rect(x,y,w,h);
		textSize(R/4);
		fill(-1);
		textAlign(LEFT,CENTER);
		fill(-1);
		ellipse(x+R/2,y+h/2,r1*2,r1*2);
		if (bif==0) fill(-1);
		else fill(0);
		noStroke();
		ellipse(x+R/2,y+h/2,r2*2,r2*2);
		s=t.s;
		t.display();
	}

	public void mousePress(){
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && !questions[nQuestionsMax].b.ok){
       		delay=DELAY;
			if (bif==0) {
				questions[number].raspunsuri[0].bif=0;
				questions[number].raspunsuri[1].bif=0;
				questions[number].raspunsuri[2].bif=0;
				questions[number].rasp=ctr;
				bif=1;
			}
			else {
				bif=0;
				questions[number].rasp=-1;
			}
		}
	}

	public void keyPress(){
		t.keyPress();
	}
}
class textbox {
	float x,y,w,h,sz;
	String s,sP;
	int c=c6,c_o=c6_o;
	int cursor,randuri,rand,cursor2,ok2;
	boolean ok,freeze;
	int unRand,pass,pass2,number;

	textbox(float xx,float yy,float ww,float hh,float szz,int unRRand,int passs,int numberr) {
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
		freeze=false;
		number=numberr;
		ok2=0;
	}

	public void display() {
		textSize(sz);
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY)) {
			fill(c_o);
			fill(-1,60);
			if (mousePressed)
				ok=true;
		}
		else {
			if (!ok) {
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
		fill(-1);
		if (ok)
			textAlign(LEFT,LEFT);
		else textAlign(CENTER,CENTER);
		if (pass==1)
			text(pass(s),x,y,w,h);
		else {
			text(s,x,y,w,h);
		}
		if (pass2==1) {
			if (isBetween(x+w+R,x+w+R+R*3,mouseX) && isBetween(y,y+h,mouseY)) {
				fill(c_o);
				fill(-1,60);
				if (mousePressed && frameCount%4==0)
					pass=(pass==1)?0:1;
			}
			else {
				fill(c);
				fill(-1,30);
			}
			stroke(-1);
			strokeWeight(2);
			rect(x+w+R,y,R*3,h);
			fill(-1);
			textSize(R*2/3);
			textAlign(CENTER,CENTER);
			if (pass==0)
				text("Hide",x+w+R,y,R*3,h);
			else 
				text("Show",x+w+R,y,R*3,h);
		}
	}

	public void keyPress(){
		strokeWeight(1);
		textSize(sz);
		if (ok && !freeze) {
			if (s.length()>=1)
				if (s.charAt(cursor-1)=='\n')
					cursor--;
			delay=10;
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
			if (frameCount%60>30)
				if (pass==0)
					line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
				else 
					line(x+textWidth(pass(ss1)),y+sz*rr+rr*sz/2,x+textWidth(pass(ss1)),y+sz*rr+sz+rr*sz/2);
			if (keyPressed) {
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
class TextBoxTeo extends Obj{
	PVector addPos;
	String data = "";
	boolean focus = false;
	float leading, txtSz, descent, ascent, initW, initH, baseAngle = 10, seekAngle = 50;
	int endlines = 0, lineIndex = 0, index;
	int normal, hover, active;

	TextBoxTeo(PVector pos, int c, float w, float h, float anim, int hov, int act, float lead, float sz, int i){
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
		textSize(txtSz);
		baseAngle = lerp(baseAngle, seekAngle, animSpd);
		if(keyPressed){
			float localW = textWidth(data) + 2 * txtSz;
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
  public void settings() { 	fullScreen(); 	pixelDensity(displayDensity()); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CreareTema" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
