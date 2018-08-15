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

public class CreareTest extends PApplet {

		//DB
					//Transfarable data + Clipboard



					//EOF Clipboard
float midW, midH;

public void setup() {
	
	initialize();
	
	thisPapplet = this;
	midW = width/2;
	midH = height/2;
	frameRate(60);
}

public void draw() {
	noStroke();
	if (delay!=0)
      delay--;
	if (STARTTEST) {
		background(c3);
		display_all_questions();
	}
	else {
		background(c7);
		textSize(R);
		fill(-1);
		textAlign(CENTER,CENTER);
		text(nume_test,0,height/4,width,R*2);
		drawStart();
		start.display();
		if (start.ok)
			STARTTEST=true;
	}
}

public void mousePressed(){
	mousePress_all_questions();
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
	float x,y,w,h;
	String s;
	boolean ok=false;
	int c=c6,c_o=c6_o;
	ToggleBtn privBtn;
	TextBoxTeo usrName, usrPass;

	buton(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
	}

	public void display() {
		if (s=="Adauga test"){		//new Btn + Txt for credentials + public / class test
			if(privBtn==null)privBtn = new ToggleBtn(new PVector(width/2, 2*height/5), c, w, h, 0.2f, color(129, 27, 247), c_o, "PUBLIC", 1);
			else {
				privBtn.update();
				privBtn.display();				
			}
			//PVector pos, color c, float w, float h, float anim, color hov, color act, float lead, float sz, int i
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
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) {
			if (mousePressed && !ok) {
				ok=true;
				if (s=="Adauga test") {
					int i;
					db = new MySQL(thisPapplet, "localhost", "ezgraphs", "root", "");    //localhost
					if(db.connect() && (!usrPass.data.equals("Password") && !usrPass.data.equals("")) && (!usrName.data.equals("Username / Email") && !usrName.data.equals("")) ){		//INSERT THE TEST
						ok=true;
						PrintWriter output;
						output = createWriter(questions[nQuestionsMax].s+".txt");
						output.println(questions[nQuestionsMax].s);
						temaFinala+=questions[nQuestionsMax].s;
						temaFinala+="+++sf";

						for (i=0;i<nQuestionsMax;i++) {		//temaFinala == testData
							output.println(questions[i].s);
							output.println(questions[i].r1);
							output.println(questions[i].r2);
							output.println(questions[i].r3);
							output.println(questions[i].rc);
							output.println();

							temaFinala+=questions[i].s;
							temaFinala+="+++sf";
							temaFinala+=questions[i].r1;
							temaFinala+="+++sf";
							temaFinala+=questions[i].r2;
							temaFinala+="+++sf";
							temaFinala+=questions[i].r3;
							temaFinala+="+++sf";
							temaFinala+=questions[i].rc;
							temaFinala+="+++sf";
							temaFinala+="+++sf";
						}
						output.flush();
						output.close();
						temaFinala=elimEndl(temaFinala);
						// VERIF LOGIN + GET USER DATA
						db.query("SELECT userID, nickname, email, pass, classID FROM users WHERE (nickname='"+usrName.data+"' OR email='"+usrName.data+"')");
						while(db.next()){
							String tmpPass = db.getString("pass");
							if(checkCrypted(usrPass.data, tmpPass)){
								int usrID = db.getInt("userID");
								int clsID = (!privBtn.toggle) ? db.getInt("classID") : -1;
								db.execute("INSERT INTO testdata VALUES(NULL, "+usrID+", "+clsID+", '"+temaFinala+"', '"+questions[nQuestionsMax].t.s+"', NOW())");
							}
						}
					}
					else{	//output DaTing cuz u no hv wifi
						ok=true;
					    PrintWriter output;
						output = createWriter(questions[nQuestionsMax].s+".txt");
						output.println(questions[nQuestionsMax].s);

						for (i=0;i<nQuestionsMax;i++) {
							output.println(questions[i].s);
							output.println(questions[i].r1);
							output.println(questions[i].r2);
							output.println(questions[i].r3);
							output.println(questions[i].rc);
							output.println();
						}
						output.flush();
						output.close();
					}
					
				}
			}
			fill(c_o);
		}
		else fill(c);
		rect(x,y,w,h);
		textSize(R/4);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);
	}

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
class buton2 {
	float x,y,w,h;
	String s;
	boolean ok=false;
	int c=c6,c_o=c6_o;

	buton2(float xx,float yy,float ww,float hh,String ss) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		s=ss;
	}

	public void display() {
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && okSend==1) {
			if (mousePressed && !ok) {
				ok=true;
				START=true;
			}
			fill(c_o);
		}
		else fill(c);
		rect(x,y,w,h);
		textSize(R/4);
		textAlign(CENTER,CENTER);
		fill(-1);
		text(s,x,y,w,h);
	}

}
int c1=color(0, 175, 234); //light blue
int c2=color(163, 205, 57); //green
int c3=color(28, 34, 40);  //black-blue
int c4=color(247, 240, 150); //light yellow
int c5=color(255, 89, 94); //red-pink
int c6=color(125, 131, 255); //light purple
int c7=color(19, 60, 85); //dark purple-blue
int c8=color(97, 83, 204); //purple
int c9=color(191, 40, 72); //red-pink

int c1_o=color(60, 235, 294); //light blue
int c2_o=color(183, 225, 77); //green
int c3_o=color(48, 54, 60);  //black-blue
int c4_o=color(267, 260, 170); //light yellow
int c5_o=color(275, 109, 114); //red-pink
int c6_o=color(145, 151, 275); //light purple
int c7_o=color(39, 80, 105); //dark purple-blue
int c8_o=color(117, 103, 224); //purple
int c9_o=color(175, 91, 91); //red-pink
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
	PImage artificii=loadImage("artificii.gif");

	drawing(float xx,float yy,float rr,int vall) {
		val=vall;
		x=xx;
		y=yy;
		r=rr;
		artificii.resize((int)r,(int)r);
	}

	public void display() {
		noStroke();
		fill(-1);
		ellipse(x,y,r*2,r*2);
		fill(questions[0].c_Fill2);
		ellipse(x,y,(r-r/10)*2,(r-r/10)*2);
		fill(-1);
		ellipse(x-r/2,y-r/2+r/5,r/7*2,r/7*2);
		ellipse(x+r/2,y-r/2+r/5,r/7*2,r/7*2);
		fill(questions[0].c_Fill2);
		ellipse(x-r/2,y-r/2+r/5,r/10*2,r/10*2);
		ellipse(x+r/2,y-r/2+r/5,r/10*2,r/10*2);
		if (val>=8) {
			fill(-1);
			arc(x,y+r/8,r,r,0,PI);
			fill(questions[0].c_Fill2);
			arc(x,y+r/8-3,r-r/10,r-r/10,0,PI);
			if (val==10) {
				//image(artificii,x-r*3,y-r/2);
				//image(artificii,x+r,y-r/2);
			}
		}
		else if (val>=5) {
			fill(-1);
			rect(x-r/2-r/8,y+r/5,r+r/4,r/10);
		}
		else {
			fill(-1);
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
PImage fundal2, logo; 
int questionActive;
int okSend=1;
int nQuestions,nQuestionsMax;
int delay,DELAY;

textbox tb2=new textbox(30,30,200,400,20);

question[] questions=new question[200];

float R;

boolean STARTTEST = false,START=false;

buton start;

String nume_test="";
String temaFinala="";

PApplet thisPapplet;
MySQL db;
public void initialize() {
	R=width/20;

	logo = loadImage("icon2-3-01.png");
	surface.setIcon(logo);

	questionActive=0;
	nQuestions=0;
	nQuestionsMax=10;

	delay=0;
	DELAY=7;

	start=new buton(width/2-R*2,height/2-R/2,R*4,R,"Incepe crearea testului");

	add_test();
	add_question("","","","",1);
	add_question("","","","",1);

	fundal2=loadImage("backgr5-01.png");
	if (fundal2.width*height/width>=height) //init
		fundal2.resize(width,fundal2.width*height/width);
	else 
		fundal2.resize(fundal2.height*width/height,height);

}
public boolean isBetween(float a,float b,float x) {
  if (a<=x && x<=b) return true;
  else return false;
}
class question {
	float x,y,w,h,w2,x2,y2,h2,h3;
	int c_Fill=c8,c_Fill_o=c8,c_Fill2=c7,c_Fill2_o=c7_o,c_Fill3=c6;
	int number=0,rasp=-1,rc;
	String s,r1,r2,r3,r4;
	raspuns[] raspunsuri=new raspuns[3];
	buton b;
	drawing desen=null;
	textbox t;

	question(float xx,float yy,float ww,float hh,float xx2,float yy2,float ww2,float hh2,float hh3,int nrr,
					String ss,String rr1,String rr2,String rr3,int rcc) {
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
		raspunsuri[0]=new raspuns(x+R,y+R*4,width-R*2,R,r1,nrr,0);
		raspunsuri[1]=new raspuns(x+R,y+R*5+R/10,width-R*2,R,r2,nrr,1);
		raspunsuri[2]=new raspuns(x+R,y+R*6+R/10*2,width-R*2,R,r3,nrr,2);
		if (number==nQuestionsMax) {
			w2=(width-R/10-questions[number-1].x2-questions[number-1].w2)/2;
			x2=questions[number-1].x2+questions[number-1].w2+R/10;
		}
		else if (number==nQuestionsMax+1) {
			w2=questions[number-1].w2;
			x2=questions[number-1].x2+w2+R/10;
			b=new buton(x+R,y+R*4,R*2,R,"Adauga test");
		}
		t=new textbox(x+R,y+R,w-R*2,R*2,R/3);
	}

	public void display() {
		int i;
		noStroke();
		if (number<nQuestionsMax) {
			r1=raspunsuri[0].s;
			r2=raspunsuri[1].s;
			r3=raspunsuri[2].s;
			if (questionActive==number) {
				fill(c_Fill2);
				if (questions[nQuestionsMax+1].b.ok)
					if (raspunsuri[rc].bif==0)
						fill(256,80,80);
					else fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//text(s,x+R,y+R,w-R*2,R*2);
				textAlign(CENTER,CENTER);
				raspunsuri[0].display();
				raspunsuri[1].display();
				raspunsuri[2].display();
				s=t.s;
				t.display();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,80,80);
						else fill(80,256,80);
					//if (mousePressed) questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,0,0);
						else fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else if (number==nQuestionsMax) {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//desen=new drawing(w/2,h/4*3,R*3,10);
				//desen.display();
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
			text("Nume test",x2,y2,w2,h2);
		}
		else {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				image(fundal2,0,y);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//desen=new drawing(w/2,h/4*3,R*3,10);
				//desen.display();
				if (questions[nQuestionsMax+1].b.ok) {
					text("Test adaugat.",x+R,y+R,w-R*2,R*2);
				}
				else if (verif_rasp()<=nQuestionsMax)
					text("Adauga toate intrebarile!",x+R,y+R,w-R*2,R*2);
				else {
					text("Poti adauga testul.",x+R,y+R,w-R*2,R*2);
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
			text("Adauga test",x2,y2,w2,h2);
		}
	}

	public void mousePress(){
		if(b!=null && b.s.equals("Adauga test") && questionActive==number){
			if(b.privBtn!=null && b.privBtn.isHovered(mouseX, mouseY))
				b.privBtn.toggle = (b.privBtn.toggle) ? false : true;
			if(b.usrName!=null)
				b.usrName.focus = (b.usrName.isHovered(mouseX, mouseY)) ? true : false;
			if(b.usrPass!=null)
				b.usrPass.focus = (b.usrPass.isHovered(mouseX, mouseY)) ? true : false;
		}
		int i;
		noStroke();
		if (number<nQuestionsMax) {
			r1=raspunsuri[0].s;
			r2=raspunsuri[1].s;
			r3=raspunsuri[2].s;
			if (questionActive==number) {
				fill(c_Fill2);
				if (questions[nQuestionsMax+1].b.ok)
					if (raspunsuri[rc].bif==0)
						fill(256,80,80);
					else fill(80,256,80);
				rect(x2,y2,w2,h3);
				fill(c_Fill2);
				rect(x,y,w,h);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				//text(s,x+R,y+R,w-R*2,R*2);
				textAlign(CENTER,CENTER);
				raspunsuri[0].mousePress();
				raspunsuri[1].mousePress();
				raspunsuri[2].mousePress();
				s=t.s;
				t.display();
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,80,80);
						else fill(80,256,80);
					questionActive=number;
				}
				else {
					fill(c_Fill3);
					if (questions[nQuestionsMax+1].b.ok)
						if (raspunsuri[rc].bif==0)
							fill(256,0,0);
						else fill(0,256,0);
				}
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text(str(number+1),x2,y2,w2,h2);
		}
		else if (number==nQuestionsMax) {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				t.display();
				s=t.s;
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					questionActive=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text("Nume test",x2,y2,w2,h2);
		}
		else {
			if (questionActive==number) {
				fill(c_Fill2);
				rect(x2,y2,w2,h3);
				rect(x,y,w,h);
				fill(c_Fill3);
				//rect(x+R,y+R,w-R*2,R*2);
				fill(-1);
				textSize(R/4);
				if (questions[nQuestionsMax+1].b.ok) {
					text("Test adaugat.",x+R,y+R,w-R*2,R*2);
				}
				else if (verif_rasp()<=nQuestionsMax)
					text("Adauga toate intrebarile!",x+R,y+R,w-R*2,R*2);
				else {
					text("Poti adauga testul.",x+R,y+R,w-R*2,R*2);
					b.display();
				}
				
			}
			else {
				if (isBetween(x2,x2+w2,mouseX) && isBetween(y2,y2+h2,mouseY)) {
					fill(c_Fill2);
					questionActive=number;
				}
				else  fill(c_Fill3);
				rect(x2,y2,w2,h2);
			}
			textAlign(CENTER,CENTER);
			fill(-1);
			textSize(R/3);
			text("Adauga test",x2,y2,w2,h2);
		}
	}

	public void keyPress(){
		if(questionActive==number){
			t.keyPress();
			raspunsuri[0].keyPress();
			raspunsuri[1].keyPress();
			raspunsuri[2].keyPress();
		}

		if(b!=null && b.s.equals("Adauga test") && questionActive==number){
			if(b.usrName!=null && b.usrName.focus)
				b.usrName.keyIsPressed();
			if(b.usrPass!=null && b.usrPass.focus)
				b.usrPass.keyIsPressed();
		}
	}
}

public void display_all_questions() {
	int i;
	for(i=0;i<nQuestions;i++)
		questions[i].display();
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

public void add_question(String s1,String s2,String s3,String s4,int rc) {
	if (nQuestions>=1)
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,questions[nQuestions-1].x2+R+R/10,
			0,R,R,R*2,nQuestions,s1,s2,s3,s4,rc);
	else {
		questions[nQuestions]=new question(0,R+R/10,width,height-R-R/10,0,0,R,R,R*2,0,s1,s2,s3,s4,rc);
		questionActive=0;
	}
	nQuestions++;
}

public int verif_rasp() {
	int i,ok=1;
	for(i=0;i<nQuestions;i++)
		if (questions[i].rasp!=-1) ok++;
	return ok;
}

public int verif_rasp_rez() {
	int i,ok=0;
	for(i=0;i<nQuestions;i++)
		if (questions[i].raspunsuri[questions[i].rc].bif==1) ok++;
	return ok;
}

public int to_nr(String s) {
	int nr=0,i;
	for (i=0;i<s.length();i++)
		nr=nr*10+PApplet.parseInt(s.charAt(i))-'0';
	return nr;
}

public void add_test() {
	int i=0;
    for (i=0;i<nQuestionsMax;i++)
    	add_question("","","","",0);
}
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
		t=new textbox(x+R,y,w-R,h,R/4);
	}

	public void display() {
		noStroke();
		
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
		//text(s,x+R,y,w,h);
		fill(-1);
		ellipse(x+R/2,y+h/2,r1*2,r1*2);
		if (bif==0) fill(-1);
		else {
			fill(0);
			questions[number].rc=ctr;
		}
		noStroke();
		ellipse(x+R/2,y+h/2,r2*2,r2*2);
		s=t.s;
		t.display();
	}

	public void mousePress(){
		if (isBetween(x,x+w,mouseX) && isBetween(y,y+h,mouseY) && !questions[nQuestionsMax+1].b.ok){//if (delay==0) {
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
			//print(bif);
		}
	}

	public void keyPress(){
		t.keyPress();
	}
}
class textbox {
	float x,y,w,h,sz;
	String s;
	int c=c6,c_o=c6_o;
	int cursor,randuri,rand,cursor2;
	boolean ok;

	textbox(float xx,float yy,float ww,float hh,float szz) {
		x=xx;
		y=yy;
		w=ww;
		h=hh;
		sz=szz;
		s="";
		ok = false;
		cursor=0; //global
		cursor2=0; //linie
		randuri=1;
		rand=0;
	}

	public void display() {
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
		textSize(sz);
		fill(-1);
		if (ok){
			textAlign(LEFT,LEFT);
			if (s.length()>=1)
				if (s.charAt(cursor-1)=='\n')
					cursor--;
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
				line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
		}
		else textAlign(CENTER,CENTER);
		text(s,x,y,w,h);
	}

	public void keyPress(){
		if(key==CODED && keyCode == SHIFT) return;
		textSize(sz);
		if (ok) {
			textAlign(LEFT,LEFT);
			if (s.length()>=1)
				if (s.charAt(cursor-1)=='\n')
					cursor--;
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
				line(x+textWidth(ss1),y+sz*rr+rr*sz/2,x+textWidth(ss1),y+sz*rr+sz+rr*sz/2);
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
						ss=ss2="";
						for (i=0;i<ll;i++)
							ss+=s.charAt(i);
						for (i=ll;i<s.length();i++) {
							ss2+=s.charAt(i);
							if (textWidth(ss2)>w) {
								ss+='\n';
								ss2="";
							}
							ss+=s.charAt(i);
						}
						s=ss;
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
				else {
					int i;
					String ss="",ss2="";
					
					for (i=0;i<cursor;i++)
						ss+=s.charAt(i);
					ss+=key;
					for (i=cursor;i<s.length();i++)
						if (s.charAt(i)!='\n')
							ss+=s.charAt(i);
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
		}
		else textAlign(CENTER,CENTER);
	}
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
    String[] appletArgs = new String[] { "CreareTest" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
