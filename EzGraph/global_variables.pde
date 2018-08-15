PImage icon; PImage logo; PImage cursorImg;PImage fundal1;PImage fundal2;
PImage steaPlina;PImage backgr2;
PImage steaNeplina;
int saltCrypt = 10;				//computing complexity for crypting

inapoiButon inapoiButon1;
int idNOTE3 = -1;
boolean pressedFromMyClass = false;
GrafLectie grafLectie = null;
boolean testLaunch =false, temaLaunch = false, lectieLaunch=false;
buton2 trimitereFeedback;
int trimis=0,TRIMIS=70;
buton2 veziFeedback;
graf[] grafs;
edge[] edges;
sagetiSchimb ssTemeT;
sagetiSchimb ssTesteT;
votStele votSt;
textbox opinie;
boolean sentData = false;
boolean testSetup = false, temaSetup = false;
boolean getData22 = false, getData23 = false, getData09 = false, getData20 = false, getData21 = false, getData26 = false, okClasa = false;
boolean stopTEST = false, stopTEMA = false;
int lastTest = 1, lastTema = 1;
scrollbar2 scrollbarComentarii;		//sunt variabile de test, in realitate sunt extrase din database
String[] com={"Wikipedia în limba română este versiunea în limba română a Wikipediei și a fost lansată la 19 iunie 2003. La 11 iulie 2018, ora 14:59, pe ro.wp există 387.362 articole scrise și 442.967 utilizatori înregistrați.","România este un stat situat în sud-estul Europei Centrale, pe cursul inferior al Dunării, la nord de peninsula Balcanică și la țărmul nord-vestic al Mării Negre.[9] Pe teritoriul ei este situată aproape toată suprafața Deltei Dunării și partea sudică și centrală a Munților Carpați.","În ajunul celui de-al Doilea Război Mondial (1940), România Mare, sub presiunea Germaniei naziste, a cedat teritorii Ungariei (nord-estul Transilvaniei), Bulgariei (Cadrilaterul) și Uniunii Sovietice (Basarabia, Herța și Bucovina de nord)."};
String[] numeCom={"Maria Popescu - popmaria20","Ion Barbuceanu - ion_barb","Martin Julian - jmartin"};
int[] notaCom={4,5,2};
comentariu[] comentarii;
int nComentarii=3;
int okIntraClasa=0;
int intraM8=0;
int intraM10=0;
buton2 intraClasa;
buton2 conectareClasa;


buton move;
buton deleteEdge;
buton deletePoint;
buton addEdge;
buton addPoint;
buton deleteGraf;
butonGrafic butGrTeme;
butonGrafic butGrTeste;
panouDr notePanou;

perecheButoane[] atribsivizTeme;
perecheButoane[] atribsivizTeste;

buton2 start;
buton2 login;
buton2 inregistrare;
buton2 modificare;
buton2 modifCont;
buton2 note;
buton2 clasa;
buton2 clasa2;
buton2 adaugaTest;
buton2 adaugaTema;

ArrayList<textbox> textboxes = new ArrayList<textbox>();
textbox numeUtilizator;
textbox nume;
textbox prenume;
textbox parola;
textbox parola2;
textbox email;
textbox clasa_pass;
textbox clasa_name;

String butonActive="Move";
String CONTACTIV="";
String EMAIL="";
String PAROLA="";
int STATUT=0;
String CLASA="";
String PROFESOR="";
String CLASAID="";

//sunt variabile de test, in realitate sunt extrase din database
boolean getDataTeste = false;
String[] clase={"11M3","12M3","8G","7E"};//=new String[100];
String[] teste={"Test1","Test2","Test3","Teste4","Teste5","Test6","Test7","Test8","Teste9","Teste10"};//=new String[100];
String[] teme={"Tema1","Tema2","Tema3","Tema4","Tema5","Tema6","Tema7","Tema8","Tema9","Tema10","Tema11","Tema12"}; ;//=new String[100];
String[] elevi={"Maria","Ioana","Mihaela","Alina","Cata","Mat"};
String[] noteEleviTest={"5","2","6","4","10","9"};
String[] noteEleviTema={"7","5","9","3","10","8"};

int lessonActive=1;
int isToScroll=-1;
int vit=20;
int nTeste = 10;
int nClase;
int nTeme = 12;
int nElevi=6;

scrollbar2 scrollbarModif;
scrollbar2 scrollbarInreg;
scrollbar2 scrollbarCont;
scrollbar2 scrollbarNoteElevi;
scrollbar2 scrollbarNoteElev;

list lista1=new list(70,70,400,60,40,"Lista");
list statut;
list alegeTest;
list alegeTema;
list alegeTemasauTest;

tabel noteElevi;
tabel noteElevi2;
tabel temeT;
tabel testeT;
tabel claseT;
tabel noteElevTemaa;
tabel noteElevTestt;

float R;
float margLeft,margTop;
float speed;

boolean or=false;
boolean lines=false;
boolean lines2=false;
boolean START=false;
boolean EROARELOGARE=false;
boolean EROAREINREGISTRARE=false;
boolean isProfesor=false;
boolean ERRCLS = false;
boolean alg=false;
boolean stopAlg=true;

int delay=0,DELAY=20;
int selected1=-1;
int nEdges,nGrafs,nBars=0,nLessons, n2Bars=0,n0Bars=0;
int isToMove=-1;
int currentModule = 4;
int gameNo = 0;
int timer = 0;
int timerAlg = 0;
int TIMER2 = 10;
int nod=0;
int ng2=0,ne2=0,nt2=0;
int ramasG=0,ramasE=0,ramas=0;
int tipAlg=0,nrLess=0;
int nrMenu=0;

int[] ordine=new int[400];
int[] noduri=new int[200];
int[] muchii=new int[200];
int[] atribuireAnulareTeste={0,0,1,1,0,0,0,1,0,0};
int[] atribuireAnulareTeme={1,0,0,1,0,0,1,0,1,0,1,1};

menu menuD;
menu menu;
menu menuOrientate;
//ModuleSelector menu2;
DropDown menu2;
gameHub hub;

example ex;

MySQL db;
boolean FORCEQUIT;
boolean error = false, LOGGED = false;
PApplet  thisPapplet;
float ERRtime;
int IDUSER;
boolean usrProf = false;
String nicknmUsr = "", nmUsr = "", surnmUsr = "", emailUsr = "", profUsr = "", statutUsr = "", clsNM = "";
int statutUsrCoded = 0, clsUsr = 0;
float MAXSCOREGAINED;
boolean updatedScore = true, succesConnectClass = false;
int gameMaxScore = -1;
ClassMembers membriiClasa;
GameRanking rankingScore;
FlyingBox classConnect;

/* HEXSWEEPER */
boolean OKSETUP = false;
HexGrid[][] grid;

float ERR, SCL, SQR3, SQR2;
float cellSpdAnim, cellSpdCol;

int lin, col;
int[] dx = {-1, -1, 0, -1, 0, 1, 1, 1};  //8 directii
int[] dy = {-1, 1, -1, 0, 1, 0, -1, 1};  //6 vecini pt fiecare caz (2 cazuri)
int[][] dir1 = {{-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {1, 0}, {0, -1}, {-1, -1}};  //verif pt continuitate
int[][] dir0 = {{-1, 0}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, 0}};

color bgCol, darkGray;
color onCell, offCell;

int CORRECT = 0, WRONG = 0, HINT = 0, ACTIVES = 0, FLAG = 0, TOTBOMBS = 0, MXSCR, MNSCR;
float DIFFICULTY, SCORE;

PFont kirbyss;
/* HEXSWEEPER */

/* FILL THE LAND */
Square[][] map;
PVector[] players, initPlayers;
int playerCount = 0, LIN, COL, BLOCKS, MOVES;
int[] dirx = {-1, 0, 1, 0};
int[] diry = {0, 1, 0, -1};
boolean UP_ARR = false, DOWN_ARR = false, RIGHT_ARR = false, LEFT_ARR = false;
color inactiveCol = color(180, 180, 180);
/* FILL THE LAND */

/*HEX COLLECTOR*/
float midW, midH;
int nmax,mmax,omax=0,TIME=40,FALL=0,Time=0,number=1,score1,score2,score3,mscore1,mscore2,mscore3;
int[] DX=new int[6];
int[] DY=new int[6];
int[] DX2=new int[6];
int[] DY2=new int[6];
int[] orderx=new int[2500];
int[] ordery=new int[2500];
int[][] use=new int[50][50];
float[][] target=new float[50][50];
int[][] target2=new int[50][50];
float RR=40,margin=100;
color color4,color1,color2,color3,c12,c22,c32;
hexHC[][] hexagons=new hexHC[50][50];
hexHC s1,s2,s3;
float vel=0.2;
butonHC restart;
/*HEX COLLECTOR*/

/* Graph Path */
boolean OKGAME = false;
ArrayList<Node> nodes;
int nodeNum, indexPrev = -1, indexCurr = -1;
int nrMuchiiGR = 0;
color offGR, onGR, hoverGR, darkGR;
MuchiiGR muchiiGr, muchiiGr2;
int tabSelected = 2;
int[] usee, xx;
int REZ, nrLanturi = 0, pGR, qGR;
//2 -> Hamitlon; 1 -> Euler; 0 -> Eval
/* Graph Path */

//sunt variabile de test, in realitate sunt extrase din database
scrollbar2 scrollbarLectii;
scrollbar2 scrollbarLectie;
String[] lectii={"În prezent, informatica își găsește aplicații în toate domeniile vieții. Prezența ei este puternic amplificată de impactul pe care îl are Internetul. Rețeaua la nivel mondial a revoluționat comunicarea dintre companii, logistica, mass-media, dar și viața privată a fiecărui individ. Mai puțin vizibil, dar totuși omniprezent, informatica și-a câștigat un loc stabil până și în aparatele casnice, ca de exemplu înregistratorul video sau mașina de spălat, în care sunt înglobate așa-numitele sisteme înglobate sau îmbarcate (în engleză embedded Systems), care fac parte integrantă din aparat și care asigură acestor aparate un comportament mai mult sau mai puțin inteligent. Printre altele, telefoanele inteligente, care sunt adevărate calculatoare, au permis democratizarea utilizării informatice pe scară extrem de largă. Calculatoarele sau computerele pot administra, memoriza, transmite și prelucra o mare cantitate de date într-un timp scurt. Pentru efectuarea unor astfel de operații este necesară o interacțiune complexă între partea fizică sau echipament (în engleză hardware) și partea logică sau programele (în engleză software), care reprezintă domeniile fundamentale de cercetare în Informatică. Marele avantaj al sistemelor computaționale constă în capacitatea lor de a prelucra în mod schematic cantități enorme de informații la o viteză foarte mare. S-a încercat și implementarea capacităților perceptive ale omului în sistemele informatice, însă până în prezent cu un succes foarte limitat. Un exemplu în această direcție îl constituie sistemele de recunoaștere a chipului uman, sau/și de luare a deciziilor atunci când nu se dispune de toate datele necesare. Astfel de procese sunt studiate de o ramură specializată a informaticii, inteligența artificială. Astfel, în anumite discipline restrânse pot fi obținute deja rezultate remarcabile. Totuși nu se poate încă vorbi despre o modelizare a inteligenței umane. Ca sistem științific fundamental, informatica are, la fel ca și matematica, implicații profunde în multe alte domenii ale științei. Dacă prin matematică se înțelege un sistem de gândire formal, atunci informatica se concentrează pe ceea ce este formal realizabil, adică ceea ce este realizabil din punctul de vedere al mașinii. Studierea problemelor informaticii poate să se apropie foarte mult de filozofie. ", "În teoria computațională, informatica teoretică studiază posibilitățile de rezolvare a unei probleme cu o anumită mașină. Teza Curch-Turing susține că orice problemă intuitivă care poate avea o soluție, deci computabilă, poate fi rezolvată de o mașină MAA - mașină cu acces aleator sau și de mașina Turing, prin urmare neexistând o mașină care să fie limitată computațional. Aceasta teză nu este demonstrabilă în mod formal, fiind totuși universal acceptată. Se spune că un model de sistem computațional, respectiv un limbaj de programare, este Turing complet compatibil, dacă cu acesta se poate simula mașina universală Turing. Toate computerele actuale sunt Turing complet compatibile, aceasta însemnând că se poate găsi o soluție pentru orice problemă decidabilă. Termenul de decidabilitate poate fi descris ca o întrebare dacă o problemă anume este rezolvabilă algoritmic sau nu. Astfel, de exemplu, problema celui mai mic multiplu comun a două numere este o problemă decidabilă. O problemă nedecidabilă este de exemplu întrebarea dacă un computer, dându-i-se anumiți parametri de intrare, va ajunge vreodată la rezultat, fapt cunoscut sub numele de problema Halt. În teoria computațională se cercetează ce mașini se pot utiliza pentru efectuarea unei funcții date. Astfel funcția Ackermann de exemplu este rezolvată nu prin clasa programelor de tip loop, ci prin mai eficienta clasă a programelor de tip while. În teoria computațională, informatica teoretică studiază posibilitățile de rezolvare a unei probleme cu o anumită mașină. Teza Curch-Turing susține că orice problemă intuitivă care poate avea o soluție, deci computabilă, poate fi rezolvată de o mașină MAA - mașină cu acces aleator sau și de mașina Turing, prin urmare neexistând o mașină care să fie limitată computațional. Aceasta teză nu este demonstrabilă în mod formal, fiind totuși universal acceptată. Se spune că un model de sistem computațional, respectiv un limbaj de programare, este Turing complet compatibil, dacă cu acesta se poate simula mașina universală Turing. Toate computerele actuale sunt Turing complet compatibile, aceasta însemnând că se poate găsi o soluție pentru orice problemă decidabilă. Termenul de decidabilitate poate fi descris ca o întrebare dacă o problemă anume este rezolvabilă algoritmic sau nu. Astfel, de exemplu, problema celui mai mic multiplu comun a două numere este o problemă decidabilă. O problemă nedecidabilă este de exemplu întrebarea dacă un computer, dându-i-se anumiți parametri de intrare, va ajunge vreodată la rezultat, fapt cunoscut sub numele de problema Halt. În teoria computațională se cercetează ce mașini se pot utiliza pentru efectuarea unei funcții date. Astfel funcția Ackermann de exemplu este rezolvată nu prin clasa programelor de tip loop, ci prin mai eficienta clasă a programelor de tip while. În teoria computațională, informatica teoretică studiază posibilitățile de rezolvare a unei probleme cu o anumită mașină. Teza Curch-Turing susține că orice problemă intuitivă care poate avea o soluție, deci computabilă, poate fi rezolvată de o mașină MAA - mașină cu acces aleator sau și de mașina Turing, prin urmare neexistând o mașină care să fie limitată computațional. Aceasta teză nu este demonstrabilă în mod formal, fiind totuși universal acceptată. Se spune că un model de sistem computațional, respectiv un limbaj de programare, este Turing complet compatibil, dacă cu acesta se poate simula mașina universală Turing. Toate computerele actuale sunt Turing complet compatibile, aceasta însemnând că se poate găsi o soluție pentru orice problemă decidabilă. Termenul de decidabilitate poate fi descris ca o întrebare dacă o problemă anume este rezolvabilă algoritmic sau nu. Astfel, de exemplu, problema celui mai mic multiplu comun a două numere este o problemă decidabilă. O problemă nedecidabilă este de exemplu întrebarea dacă un computer, dându-i-se anumiți parametri de intrare, va ajunge vreodată la rezultat, fapt cunoscut sub numele de problema Halt. În teoria computațională se cercetează ce mașini se pot utiliza pentru efectuarea unei funcții date. Astfel funcția Ackermann de exemplu este rezolvată nu prin clasa programelor de tip loop, ci prin mai eficienta clasă a programelor de tip while. În teoria computațională, informatica teoretică studiază posibilitățile de rezolvare a unei probleme cu o anumită mașină. Teza Curch-Turing susține că orice problemă intuitivă care poate avea o soluție, deci computabilă, poate fi rezolvată de o mașină MAA - mașină cu acces aleator sau și de mașina Turing, prin urmare neexistând o mașină care să fie limitată computațional. Aceasta teză nu este demonstrabilă în mod formal, fiind totuși universal acceptată. Se spune că un model de sistem computațional, respectiv un limbaj de programare, este Turing complet compatibil, dacă cu acesta se poate simula mașina universală Turing. Toate computerele actuale sunt Turing complet compatibile, aceasta însemnând că se poate găsi o soluție pentru orice problemă decidabilă. Termenul de decidabilitate poate fi descris ca o întrebare dacă o problemă anume este rezolvabilă algoritmic sau nu. Astfel, de exemplu, problema celui mai mic multiplu comun a două numere este o problemă decidabilă. O problemă nedecidabilă este de exemplu întrebarea dacă un computer, dându-i-se anumiți parametri de intrare, va ajunge vreodată la rezultat, fapt cunoscut sub numele de problema Halt. În teoria computațională se cercetează ce mașini se pot utiliza pentru efectuarea unei funcții date. Astfel funcția Ackermann de exemplu este rezolvată nu prin clasa programelor de tip loop, ci prin mai eficienta clasă a programelor de tip while. În teoria computațională, informatica teoretică studiază posibilitățile de rezolvare a unei probleme cu o anumită mașină. Teza Curch-Turing susține că orice problemă intuitivă care poate avea o soluție, deci computabilă, poate fi rezolvată de o mașină MAA - mașină cu acces aleator sau și de mașina Turing, prin urmare neexistând o mașină care să fie limitată computațional. Aceasta teză nu este demonstrabilă în mod formal, fiind totuși universal acceptată. Se spune că un model de sistem computațional, respectiv un limbaj de programare, este Turing complet compatibil, dacă cu acesta se poate simula mașina universală Turing. Toate computerele actuale sunt Turing complet compatibile, aceasta însemnând că se poate găsi o soluție pentru orice problemă decidabilă. Termenul de decidabilitate poate fi descris ca o întrebare dacă o problemă anume este rezolvabilă algoritmic sau nu. Astfel, de exemplu, problema celui mai mic multiplu comun a două numere este o problemă decidabilă. O problemă nedecidabilă este de exemplu întrebarea dacă un computer, dându-i-se anumiți parametri de intrare, va ajunge vreodată la rezultat, fapt cunoscut sub numele de problema Halt. În teoria computațională se cercetează ce mașini se pot utiliza pentru efectuarea unei funcții date. Astfel funcția Ackermann de exemplu este rezolvată nu prin clasa programelor de tip loop, ci prin mai eficienta clasă a programelor de tip while. ", "În zilele noastre, toate științele utilizează rezultatele muncii matematicienilor și multe alte domenii sunt generate de matematica însăși. De exemplu, fizicianul Richard Feynman, a inventat formularea mecanicii cuantice sub forma integralelor de drum [8] folosind o combinație între descoperiri de natură matematică, intuiții fizice și teoria stringurilor, o teorie științifică încă în dezvoltare care încearcă să unifice cele 4 forțe fundamentale din natură, continuând să inspire noi ramuri ale matematicii.[9] Unele ramuri ale matematicii sunt singurele relevante pentru domeniile pe care le-au inspirat și se aplică în continuare pentru rezolvarea problemelor viitoare. Adeseori însă, matematica inspirată de către un domeniu s-a dovedit utilă în multe altele și a reunit problematica generală a conceptelor matematice. Faptul remarcabil că chiar și matematica pură se reflectă în aplicații practice este redat de ceea ce Eugene Wigner a numit eficiența irațională a matematicii[10]. Ca în multe alte domenii, explozia de cunoștințe din știință a dus la specializări în matematică. O diferență majoră este între matematica pură și matematica aplicată: cei mai mulți matematicieni își fac cercetările separat într-unul din aceste domenii iar alegerea finală este făcută odată cu terminarea studiilor. Câteva domenii din matematica aplicată au fuzionat cu domenii care prin tradiție erau din afara ei și au devenit astfel discipline noi, cum ar fi statistica, cercetarea operațională, și știința calculatoarelor. Cei care au înclinații spre matematică găsesc adesea aspecte estetice în multe domenii din matematică. Mulți matematicieni vorbesc despre eleganța matematicii, despre o estetică intrinsecă și o frumusețe ascunsă. Sunt apreciate simplitatea și generalizarea. Se poate vorbi de frumusețea și eleganța unei demonstrații, cum ar fi cazul demonstrației lui Euclid asupra infinității numerelor prime, a metodei numerice de calcul rapid ca în cazul transformatei rapide Fourier. G. H. Hardy, în „A Mathematician's Apology” își exprima credința că aceste considerații estetice sunt, în ele însele, suficiente pentru a justifica studiul matematicii pure.[11] După Paul Erdős, care ar fi vrut să afle „Cartea” în care Dumnezeu a notat demonstrațiile lui favorite, matematicienii năzuiesc adeseori să găsească demonstrații ale teoremelor care sunt, în special, elegante.[12][13]) Popularitatea matematicii distractive este un alt indiciu al plăcerii găsite în rezolvarea problemelor de matematică.Studiul spațiului a început cu studiul geometriei, mai exact, al geometriei euclidiene. Trigonometria combină spațiul și numerele și cuprinde cunoscuta teoremă a lui Pitagora. Studiile moderne generalizează teoriile asupra spațiului introducând noțiunea de geometrie neeuclidiană în locul celei de geometrie euclidiană. Geometria neeuclidiană ocupă un rol central în teoria relativității generalizate și topologie. Cantitatea și spațiul au roluri importante în geometria analitică, geometrie diferențială și geometrie algebrică. În cadrul geometriei diferențiale apar conceptele de „fascicul de mătase” ([1]fiber bundle) și calculul spațiilor topologice. Geometria algebrică descrie obiectele geometrice prin intermediul unor seturi de soluții ale ecuațiilor polinomiale, combinând conceptele de cantitate, spațiu și studiul grupurilor topologice, acestea combinând noțiunile de structură și spațiu. Grupurile Lie sunt folosite în studiul spațiului, structurii și schimbării. Topologia are foarte multe ramificații și a fost domeniul din matematică cu cea mai mare dezvoltare în secolul XX, cuprinzând faimoasa conjectură a lui Poicaré și controversata teoremă a celor patru culori, a cărei demonstrație, făcută doar pe calculator, nu a fost făcută încă de om."};
String[] numeAutorLectii={"Lincan","Ripeanu","Marin"};
String[] numeLectii={"Informatica","Informatica2","Matematica"};
float[] noteLectiiVot={3.6,2.1,4.8};
int nLectii=3;
lectieProf[] lectiiProf;
lectieProf lectieCurentaprof;