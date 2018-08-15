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
