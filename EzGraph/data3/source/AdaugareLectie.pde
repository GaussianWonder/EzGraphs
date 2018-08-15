import de.bezier.data.sql.*;		//Database
import java.awt.*;					//Transfarable data + Clipboard
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;					//EOF Clipboard
//import java.awt.event.*;			//conflicts with MouseEvent

float midW, midH;
FormHolder currForm;
float R;
PApplet thisPapplet = this;
MySQL db;
boolean SENT = false;
PImage logo;
int saltCrypt = 10;					//computing complexity for crypting

void setup() {
	logo = loadImage("icon2-4-01.png");
	surface.setIcon(logo);
	fullScreen();
	pixelDensity(displayDensity());
	frameRate(60);
	noStroke();
	ellipseMode(RADIUS);

	midW = width/2;
	midH = height/2;
	R = (height/25);

	currForm = new FormHolder();
	currForm.addForm(new Form(new PVector(10, 20 + height/8), c3, width - 20, height - (10 + height/8), 0.2, 1));
	currForm.addForm(new Form(new PVector(10, 20 + height/8), c3, width - 20, height - (10 + height/8), 0.2, 2));
	currForm.addForm(new Form(new PVector(10, 20 + height/8), c3, width - 20, height - (10 + height/8), 0.2, 3));
	scTb=new scrollbar2(width/2-R/2 + R/3,height/6,R/2,height-R*2,(int)(lungTb()/4/R/3+1));

	db = new MySQL(thisPapplet, "localhost", "ezgraphs", "root", "");    //localhost
}

void draw() {
	background(c3);

	currForm.show();
}

void mouseWheel(MouseEvent event) {
	float e = event.getCount();

	if (isBetween(scTb.y,scTb.y+scTb.h-scTb.h2,scTb.y2+e*scTb.h3)) {
      scTb.y2+=e*scTb.h3;
      scTb.decateori+=e;
    }
}

color c1=color(0, 175, 234); //light blue
color c2=color(163, 205, 57); //green
color c3=color(0, 7, 40);  //black-blue
color c4=color(247, 240, 150); //light yellow
color c5=color(255, 89, 94); //red-pink
color c6=color(125, 131, 255); //light purple
color c7=color(3, 0, 56); //dark purple-blue
color c8=color(97, 83, 204); //purple

color c1_o=color(60, 235, 294); //light blue
color c2_o=color(183, 225, 77); //green
color c3_o=color(48, 54, 60);  //black-blue
color c4_o=color(267, 260, 170); //light yellow
color c5_o=color(275, 109, 114); //red-pink
color c6_o=color(145, 151, 275); //light purple
color c7_o=color(39, 80, 105); //dark purple-blue
color c8_o=color(117, 103, 224); //purple

int currentModule;
int delay=0, DELAY = 20;

boolean isBetween(float a,float b,float x) {
  if (a<=x && x<=b) return true;
  else return false;
}

scrollbar2 scTb;

float lungTb() {
	if(currForm.forms.get(1).txtb==null)return 0;
	return currForm.forms.get(1).txtb.y+currForm.forms.get(1).txtb.h+R*3;
}

String faCodGraf() {
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

String crypt(String pass){
	String hash = BCrypt.hashpw(pass, BCrypt.gensalt(saltCrypt));

	if (BCrypt.checkpw(pass, hash)) return hash;
	else return "{ERR}";
}

boolean checkCrypted(String pass, String hash){
	return BCrypt.checkpw(pass, hash);
}
