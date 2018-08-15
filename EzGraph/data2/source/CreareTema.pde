import de.bezier.data.sql.*;		//DB
import java.awt.*;					//Transfarable data + Clipboard
import java.awt.event.*;
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;					//EOF Clipboard
float midW, midH;
PApplet thisPapplet;
MySQL db;

void setup() {
	fullScreen();
	initialize();
	pixelDensity(displayDensity());
	thisPapplet = this;
	midW = width/2;
	midH = height/2;
	frameRate(60);
}

void draw() {
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

void mousePressed(){
	mousePress_all_questions();
	start.mousePress();
}

void keyPressed(){
	keyPress_all_questions();
}

int saltCrypt = 10;					//computing complexity for crypting
String crypt(String pass){
	String hash = BCrypt.hashpw(pass, BCrypt.gensalt(saltCrypt));

	if (BCrypt.checkpw(pass, hash)) return hash;
	else return "{ERR}";
}

boolean checkCrypted(String pass, String hash){
	return BCrypt.checkpw(pass, hash);
}
