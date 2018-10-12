import android.content.Intent;
import android.net.Uri;
import java.io.File;
import java.util.Calendar;
Calendar cal = Calendar.getInstance();
int dayOfWeek = 0;
int matrixDay = 0;

String thisVersion = "v1.2.5";
String[] verCheckLoad;
String verChecked = "";
boolean CFUerror = false;
String CFUurl = "https://raw.githubusercontent.com/Unnamed3/prochaineSonnerie/master/prochaineSonnerie.version";


boolean highlight = false;
int highlightID = 0;
int X = 0, Y = 0;
float midX, midY; //milieu d ecran
int[] Lsonne = {0, 29100, 29400, 32700, 33000, 36000, 36600, 36900, 40200, 40500, 43500, 43800, 46800, 47100, 49800, 50100, 53400, 53700, 56700, 57300, 57600, 60900, 61200, 64200, 0, 0};
//8h05 = 29 100s | 8h10 = 29 400 | 9h05 = 32 700 | 9h10 = 33 000 | 10h = 36 000 |10h10 = 36 600|10h15 = 36 900|11h10 = 40 200|11h15 = 40 500|12h05 = 43 500|12h10 = 43 800|13h = 46 800|13h05 = 47 100|13h50 = 49 800|13h55 = 50 100|14h50 = 53 400|14h55 = 53 700|15h45 = 56 700|15h55 = 57 300|16h = 57 600|16h55 = 60 900|17h = 61 200|17h50 = 64 200

int[][] edtMatrix ={
  //8h05, 8h10, 9h05, 9h10, 10h00, 10h10, 10h15
/*LUNDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*MARDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*MERCR*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*JEUDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*VENDR*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*SAMED*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*DIMAN*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
  };
  
int[][] edtMatrixA ={
  //8h05, 8h10, 9h05, 9h10, 10h00, 10h10, 10h15
/*LUNDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*MARDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*MERCR*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*JEUDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*VENDR*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*SAMED*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*DIMAN*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
  };

int[][] edtMatrixB ={
  //8h05, 8h10, 9h05, 9h10, 10h00, 10h10, 10h15
/*LUNDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*MARDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*MERCR*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*JEUDI*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1}, 
/*VENDR*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*SAMED*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
/*DIMAN*/  {/*8h05->*/1,/*8h10->*/1,/*9h05->*/1,/*9h10->*/1,/*10h00->*/1,/*10h10->*/1,/*10h15->*/1,/*11h10->*/1,/*11h15->*/1,/*12h05->*/1,/*12h10->*/1,/*13h00->*/1,/*13h05->*/1,/*13h50->*/1,/*13h55->*/1,/*14h50->*/1,/*14h55->*/1,/*15h45->*/1,/*15h55->*/1,/*16h00->*/1,/*16h55->*/1,/*17h00->*/1,/*17h50->*/1,1,1},
  };


int calibrage = 0, calibrageUnsaved = 0;
String[] loadfile;
String screen = "0";
String[]intercours = {"(Début / fin cours)", "(Retard)", "(Recré)", "(Fin de la récré)", "(Fin des cours)"};
int heurSecondes = 0;
int prochaineSonnerie = 0, sProchaineSonnerie = 0, mProchaineSonnerie = 0, hProchaineSonnerie = 0;
int a = 0, b = 0, c = 0;
int timeLeft=0, sTimeLeft, mTimeLeft = 0, hTimeLeft = 0;
int derniereSonnerie = 0;
float pourcentCours = 0;
int pourcentCoursInt = 0;
float pourcentCours_ = 0;
int typeSn=0;
String path = "/storage/emulated/0/prochaineSonnerie.conf";
String rPath = "prochaineSonnerie.conf";
public static String OS = System.getProperty("os.name").toLowerCase();
float rectProgress = 0;

boolean TimeleftFullscreen = false;

int action = 0;
boolean appuis = false, relachement = false, depart = false;
boolean autoSkip = true;
String[] weekDay = {"Lundi", "Mardi", "Mercredi","Jeudi", "Vendredi", "Samedi", "Dimanche" };
int weekNumber; // numéro de la semaine dans l'année
char weekLetter; // Semaine A ou semaine B

void setup () {
  //  size(1280, 720); //tester la résolution d'écran de son choix (pour le dev sur PC)

  if (OS.equalsIgnoreCase("linux")) {
    size(displayWidth, displayHeight);

    try {
      loadfile = loadStrings(path);
      String calibragestring = loadfile[0];
      calibrage = parseInt(calibragestring);
    } 
    catch(Exception e) {
      String[] var = {"0"};
      saveStrings(path, var);
    }
  } else if (OS.contains("windows")) {  
    ///surface.setSize(displayWidth/2, displayHeight/2);
    ///surface.setResizable(true);
    

    try {
      loadfile = loadStrings(rPath);
      String calibragestring = loadfile[0];
      calibrage = parseInt(calibragestring);
    } 
    catch(Exception e) {
      String[] var = {"0"};
      saveStrings(rPath, var);
    }
  }

  X = width;
  Y = height;
  midX = X*0.5;
  midY = Y*0.5;

  try {
    verCheckLoad = loadStrings(CFUurl);

    verChecked = verCheckLoad[0];
  } 
  catch(Exception e) {
    CFUerror = true;
  } //Disable this to test on PC
  if (!CFUerror && !verChecked.equals(thisVersion)) {
    thread("update");
  }
}




void draw () {

  X = width;
  Y = height;
  midX = X*0.5;
  midY = Y*0.5;
  /*
  SCREEN LIST
  New system : a.b.c  a=screen, b= subscreen, c= subscreen of subscreen
   Screen 1 = Écran de démarrage avec les deux boutons
   Screen "1.f" = Fin des cours
   Screen 1.1 = Timeleft fullscreen
   Screen 2 = Écran affichage heure avec la barre de progression
   Screen 3 = Calibrage setup screen
   
  
   
   */

  fill(0);
  // L'écran de fin des cours qui s'affiche lorsque le scan de la sonnerie suivante arrive au bout

  // Ecran d'accueil au lancement de l'application
  if (screen == "0") {
    background(204);
    noStroke();

    textSize (0.0765*Y);
    textAlign(CENTER, CENTER);
    text("Bienvenue sur prochaineSonnerie", midX, 0.07*Y);

    bouton(X*0.25, midY, X*0.3, X*0.3, 1);
    if (action == 1) {
      configTMS();
      callScreen("1");
      action = 0;
    }

    bouton(X*0.75, midY, X*0.3, X*0.3, 2);
    if (action == 2) {
      callScreen("2");
      calibrageUnsaved = calibrage;
      action = 0;
    }


    textAlign(CENTER, CENTER);
    fill(0);
    text("Launch", X*0.25, midY);
    text("Config", X*0.75, midY);


    textSize(X*0.04);
    if (CFUerror) {
      fill(255, 0, 0);
      text("No internet, cannot check for updates", midX, Y*0.87);
      textSize(X*0.03);
      text(thisVersion, midX, Y*0.95);
    }
    if (!CFUerror) {
      fill(0, 255, 0);
      if (verChecked.equals(thisVersion)) {
        text("You are up to date ("+thisVersion+")", midX, Y*0.87);
      } else
      {
        text("New version available ! (n°"+verCheckLoad[0]+")\nYou have : "+thisVersion, midX, Y*0.87);
      }
    }
  } // END SCREEN 0

    if (screen == "1") {  //ecran prochaineSonnerie, heure, timeleft...
    if (TimeleftFullscreen) {
      background(0);
      if (mousePressed) {
        mouseX = 0; 
        mouseY = 0;
        TimeleftFullscreen = false;
      }

      calcul("All");

      fill(255);
      if (hTimeLeft == 0) {
        textSize (0.4*Y);
        text("Time left", midX, Y*0.2);
        text(mTimeLeft+"m"+sTimeLeft+"s", midX, Y*0.7);
      } else {
        textSize (0.4*Y);
        text("Time left", midX, Y*0.2);
        textSize (0.3*Y);
        text(hTimeLeft+"h "+mTimeLeft+"m"+sTimeLeft+"s", midX, Y*0.7);
      }
    } else {

      background (255);
      textAlign(CENTER, CENTER);
      textSize(0.045*Y);
      text(weekDay[matrixDay]+" - Semaine "+weekLetter, midX, 0.05*Y);
      if (!CFUerror) {
        if (!verChecked.equals(thisVersion))
        {
          text("WARNING ! You run an old version ("+thisVersion+")", midX, Y*0.95);
        }
      }

      fill(255);
      stroke (0);

      bouton(X*0.965, Y*0.05972, X*0.05, X*0.05, 1);
      if (action == 1) {
        callScreen("0");
        action = 0;
      }

      fill(0);
      textSize (0.03*Y);

      text("Back", X*0.966, Y*0.055);
      textSize (0.0765*Y);
      textAlign (LEFT, TOP);
      text("Heure "+hour()+":"+minute()+":"+second(), 0.05*X, Y*0.1);
      text("Prochaine sonnerie à : "+hProchaineSonnerie+"h"+mProchaineSonnerie+"m"+sProchaineSonnerie+"s", X*0.05, Y*0.2);
      text(intercours[typeSn], X*0.05, Y*0.3);

      calcul("All");

      fill(255, 0, 0);
      if (hTimeLeft == 0) {
        text("Il reste : "+mTimeLeft+"m"+sTimeLeft+"s", 0.05*X, Y*0.4);
      } else {
        text("Il reste : "+hTimeLeft+"h "+mTimeLeft+"m"+sTimeLeft+"s", 0.05*X, Y*0.4);
      }

      fill(255);
      //prochaineSonnerie = 2000; ///////////////LIGNE POUR DEBUG après 18h sans déregler l'heure de son pc (ajoute une sonnerie (en secondes écoulées depuis minuit))////////////////////////////////////

      rectMode(CORNER);
      fill(255);
      rect(0.05*X-1, 0.80*Y-1, 0.89*X+2, 0.11*Y+2);

      fill(#00E8FF);
      noStroke();
      rect(X*0.05, Y*0.8, X*rectProgress, Y*0.11);
      //((K-J))/(B-J)*100>P
      // ((P/100)* - )
      //(heure now - début cours) ÷ sonnerie fin cours - début cours) x 100



      textAlign(CENTER, CENTER);
      text("Progression du cours : " + pourcentCours_+"%", midX, 0.7*Y);
    }

    //line(X*0.5,Y*0.7, X*0.5, Y*0.8); // ligne pour vérifier si le 50% de la progressbar fonctionne correctement

    if (heurSecondes > prochaineSonnerie) {
      configTMS();
    }
  }// END SCREEN 1
  
  if (screen == "1.f") {
    textSize (0.0765*Y);
    background(255);

    textAlign(CENTER, CENTER);
    fill(#00E8FF);
    stroke(0);
    text("Fin des cours !", midX, Y*0.2);

    bouton(X*0.3, Y*0.8, Y*0.7, Y*0.2, 1);
    fill(0);
    text("Back", X*0.3, Y*0.79);

    bouton(X*0.7, Y*0.8, Y*0.7, Y*0.2, 2);
    fill(0);
    text("EXIT", X*0.7, Y*0.79);


    if (action == 1) { // Back button
      callScreen("0");
      action = 0;
    }
    if (action == 2) {// Exit button
      exit();
    }
  }
  
  if (screen == "2") {  //setup screen
    stroke(0);
    background(255);


    bouton(X*0.10, midY, Y*0.3, Y*0.3, -10);
    bouton(X*0.3, midY, Y*0.3, Y*0.3, -1);

    bouton(X*0.7, midY, Y*0.3, Y*0.3, 1);
    bouton(X*0.9, midY, Y*0.3, Y*0.3, 10);

    bouton(X*0.35, Y*0.82, midY, Y*0.2, 84); //bouton back config screen
    bouton(X*0.65, Y*0.82, midY, Y*0.2, 54); // bouton save
    switch (action) {
    case -10:
      calibrageUnsaved-=10;
      action = 0;
      break;
    case -1:
      calibrageUnsaved-=1;  
      action = 0;
      break;
    case 1:
      calibrageUnsaved+=1;  
      action = 0;
      break;
    case 10:
      calibrageUnsaved+=10;  
      action = 0;
      break;
    case 84:
      callScreen("0");
      action = 0;
      break;
    case 54:
      save();
      break;
    }
    fill(0);
    textAlign(CENTER, CENTER);

    text("Configurer le calibrage", midX, Y*0.10);
    text("des sonneries", midX, Y*0.20); 
    text("Back", X*0.35, Y*0.82);
    text("Save", X*0.65, Y*0.82);
    text("-10", X*0.10, midY);

    text("-1", X*0.3, midY);
    text(calibrageUnsaved, X/2, Y/2);

    text("+1", X*0.7, midY);
    text("+10", X*0.9, midY);
  }


  //Always on display SΛMSUNG
  if (X < Y) {

    screen = "1";

    background(0);
    fill(255);
    textAlign(CENTER, CENTER);


    textSize(X*0.3);

    if (hour()<10) {
      text("0"+hour(), midX, midY*0.6);
    } else {
      text(hour(), midX, midY*0.6);
    }

    if (minute()<10) {
      text("0"+minute(), midX, midY*0.9);
    } else {
      text(minute(), midX, midY*0.9);
    }



    textSize(X*0.05);
    if (timeLeft >=0) {
      text("Prochaine sonnerie :", midX, midY*1.15);


      textSize(X*0.06);

      if (hTimeLeft == 0) {
        text(mTimeLeft+"m"+sTimeLeft+"s", midX, midY*1.25);
      } else {
        text(hTimeLeft+"h "+mTimeLeft+"m"+sTimeLeft+"s", midX, midY*1.25);
      }

      if (heurSecondes > prochaineSonnerie) {
        configTMS();
      }
    } else {
      text("Fin des cours", midX, midY*1.15);
      textSize(X*0.06);
    }
  }
}





void configTMS() {

  /*
println(cal.get(Calendar.DAY_OF_WEEK));
   Dimanche 1
   Lundi 2
   Mardi 3
   Mercredi 4
   Jeudi 5
   Vendredi 6
   Samedi 7
   FR : day--; (if day == 0) day = 7. 
   */

  matrixDay = cal.get(Calendar.DAY_OF_WEEK)-2;
  if (matrixDay == -1) matrixDay = 6;
  dayOfWeek = cal.get(Calendar.DAY_OF_WEEK)-1;
  weekNumber = cal.get(Calendar.WEEK_OF_YEAR);
  if (weekNumber%2 == 0)
   weekLetter = 'A';
else
   weekLetter = 'B';
  if (dayOfWeek == 0) dayOfWeek =7;
  a = hour();
  b = minute();
  c = second();
  b = a*60+b;
  c = b*60+c;
  heurSecondes = c;

  a=0;
  b=0;
  c=0;
  prochaineSonnerie = 0;

  while (true) {

    if (prochaineSonnerie > heurSecondes && edtMatrix[matrixDay][b-1]==1 || autoSkip == true && prochaineSonnerie > heurSecondes) 
    {
      println(edtMatrix[0][0]);
      break;
    }
    a = Lsonne [b] + calibrage;
    prochaineSonnerie = a;
    b++;
    if (b >= 26) {
      screen = "1.f";
      break;
    }
  }

  b--;
  if (b==1 || b==3 || b==8 || b==10 || b==12|| b==14 || b==16 || b==21) {
    typeSn = 0;
  }
  if (b==2 || b==4|| b==7|| b==9 || b==11 || b==13 || b==15 || b==17 || b==20 || b==22) {
    typeSn = 1;
  }

  if (b==5 || b==18) {
    typeSn = 2;
  }

  if (b==6 || b==19) {
    typeSn = 3;
  }

  if (b==23) {
    typeSn = 4;
  }

  if (b>1) {
    while (edtMatrix[matrixDay][b-1]!=1) {
      b--;
    }
    derniereSonnerie = Lsonne [b-1] + calibrage;
  } else {
    derniereSonnerie = Lsonne [b-1] + calibrage;
  }

  println("Dernière sonnerie "+(b-1));


  hProchaineSonnerie = prochaineSonnerie/3600;
  mProchaineSonnerie = ((prochaineSonnerie)%3600)/60;
  sProchaineSonnerie = prochaineSonnerie%60;
  
}

void mousePressed() {
  appuis = true;
  if (mouseX>0.047*X && mouseY>Y*0.403 && mouseX<X*0.383 && mouseY<0.486*Y && screen == "1") {
    TimeleftFullscreen = true;
    mouseX = 0;
    mouseY = 0;
    mousePressed = false;
    // Bouton fullscreen
  }
}

void mouseReleased() {
  appuis = false;
  relachement = true;
}

void fHighlight(int X) { //fonction highlight
  if (highlight == true && highlightID == X) {
    fill(127);
  } else {
    fill (255);
  }
}

void callScreen (String s) {

  screen = s;
}


void calcul(String what) {
  if (what == "All") {
    a = hour(); 
    b = minute(); 
    c = second();
    b = a*60+b; 
    c = b*60+c; // convertir heure actuelle en secondes écoulées depuis minuit
    heurSecondes = c;

    timeLeft = prochaineSonnerie - heurSecondes; // le temps restant (en secondes) est la différence entre la prochaine sonnerie et l'heure actuelle

    float d = (float)timeLeft/60; // convertir en minutes...
    mTimeLeft = int(d%60);

    float partDecd = (float)(d-(floor(d))); //extraire la partie décimale de la variable d
    sTimeLeft = (int)(partDecd*60);

    float e = partDecd*60;
    sTimeLeft = round(e);

    hTimeLeft = timeLeft/3600;

    float f = 0.89;
    //pourcentCours = 99;
    f *= (pourcentCours_/100);
    rectProgress = f;
    stroke(0);
    d = heurSecondes - derniereSonnerie;
    e = prochaineSonnerie - derniereSonnerie;
    pourcentCours = (d/e)*100;

    //arrondir au dixieme pres
    pourcentCoursInt = (int(pourcentCours*10));
    pourcentCours_ = (float(pourcentCoursInt));
    pourcentCours_ /= 10;
  }
}


//fonction bouton
void bouton(float posX, float posY, float tailleX, float tailleY, int ID) {
  fill(255);

  rectMode(CENTER);
  rect(posX, posY, tailleX, tailleY);  //rectangle du bouton

  //zone d'appui
  if (appuis == true && mouseX >= posX-tailleX/2 && mouseY >= posY-tailleY/2 && mouseX <= posX+tailleX/2 && mouseY <= posY+tailleY/2) {
    fill(127);
    rect(posX, posY, tailleX, tailleY);
    depart = true;
  }

  //zone de relachement
  if (relachement == true && appuis == false && depart == true && mouseX >= posX-tailleX/2 && mouseY >= posY-tailleY/2 && mouseX <= posX+tailleX/2 && mouseY <= posY+tailleY/2) {
    action = ID;  //definition de l'action a realiser en fonction de l'ID du bouton
    appuis = false;
    relachement = false;
    depart = false;
    fill(255);
  }
}


void save() {
  if (OS.equalsIgnoreCase("linux")) {
    calibrage = calibrageUnsaved;
    loadfile[0] = str(calibrage);
    saveStrings(path, loadfile);
    // BOUTON Save
  } else if (OS.contains("windows")) {
    calibrage = calibrageUnsaved;
    loadfile[0] = str(calibrage);
    saveStrings(rPath, loadfile);
  } else {
    calibrage = calibrageUnsaved;
  }
}

void exit() {
  System.exit(0);
}


// Fonction de mise à jour sous un thread

void update() {
 try {
 saveBytes("/storage/emulated/0/Download/base.apk", loadBytes("https://github.com/Unnamed3/prochaineSonnerie/releases/download/"+verChecked+"/base.apk"));
 File apkFile = new File("/storage/emulated/0/Download/base.apk");
 Intent intent = new Intent(Intent.ACTION_VIEW);
 intent.setDataAndType(Uri.fromFile(apkFile), "application/vnd.android.package-archive");
 intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
 getActivity().startActivity(intent);
 } catch (Exception e) {
 e.printStackTrace();
 println("Une erreur s'est produite :/");
 }
 }

// Fonction du back btn

@Override 
 void onBackPressed() {
 if(screen=="0") {
 exit();
 } else {
 callScreen("0");
 }
 }
