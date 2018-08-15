import de.bezier.data.sql.*;		//DB
import java.awt.*;					//Transfarable data + Clipboard
import java.awt.event.*;
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;					//EOF Clipboard
float midW, midH;

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

void mousePressed(){
	mousePress_all_questions();
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
