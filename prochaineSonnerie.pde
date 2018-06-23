import android.content.Intent;
import android.net.Uri;
import java.io.File;
import java.time.LocalDate;
import java.time.Month;
import java.time.temporal.ChronoUnit;


String thisVersion = "v1.0";
String[] verCheckLoad;
String verChecked = "";
boolean CFUerror = false;
String CFUurl = "https://raw.githubusercontent.com/Unnamed3/prochaineSonnerie/master/prochaineSonnerie.version";


boolean highlight = false;
int highlightID = 0;
int X = 0, Y = 0;
float midX, midY; //milieu d ecran
int[] Lsonne = {0, 29100, 29400, 32700, 33100, 36000, 36600, 36900, 40200, 40500, 43500, 43800, 46800, 47100, 49800, 50100, 53400, 53700, 56700, 57300, 57600, 60900, 61200, 64200, 0, 0};
//8h05 = 29 100s | 8h10 = 29 400 | 9h05 = 32 700 | 9h10 = 33 000 | 10h = 36 000 |10h10 = 36 600|10h15 = 36 900|11h = 39 600|11h15 = 40 500|12h05 = 43 500|12h10 = 43 800|13h = 46 800|13h05 = 47 100|13h50 = 49 800|13h55 = 50 100|14h50 = 53 400|14h55 = 53 700|15h45 = 56 700|15h55 = 57 300|16h = 57 600|16h55 = 60 900|17h = 61 200|17h50 = 64 200
int calibrage = 0, calibrageUnsaved = 0;
String[] loadfile;
int screen = 1;
String[]intercours = {"(Début / fin cours)", "(Intercours)", "(Recré)", "(Fin de la récré)", "(Fin des cours)"};
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


void setup () {
  //  size(1280, 720); //tester la résolution d'écran de son choix (pour le dev sur PC)
  size(displayWidth, displayHeight);
  calculCalibrage();
  X = width;
  Y = height;
  midX = X*0.5;
  midY = Y*0.5;
}




void draw () {
  /*
  SCREEN LIST
   Screen 1 = Écran de démarrage avec les deux boutons
   Screen 2 = Écran affichage heure avec la barre de progression
   Screen 3 = Calibrage setup screen

   Screen 404 = Fin des cours

   */

  fill(0);
  // L'écran de fin des cours qui s'affiche lorsque le scan de la sonnerie suivante arrive au bout
  if (screen == 404) {
    screen = 404;

    background(255);

    textAlign(CENTER, CENTER);
    fill(#00E8FF);
    text("Fin des cours !", midX, Y*0.2);

    bouton(X*0.3, Y*0.8, Y*0.7, Y*0.2, 1);
    fill(0);
    text("Back", X*0.3, Y*0.79);

    bouton(X*0.7, Y*0.8, Y*0.7, Y*0.2, 2);
    fill(0);
    text("EXIT", X*0.7, Y*0.79);


    if (action == 1) {
      callScreen(1);
      action = 0;
    }
    if (action == 2) {
      exit();
    }
  }

  //Always on display for WearOS
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    calcul("All");

    textSize(X*0.07);

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


void calculCalibrage() {
  // calcul du décalage de jour
  long jdecal = ChronoUnit.DAYS.between(LocalDate.of(2018, Month.SEPTEMBER, 5),LocalDate.now());
  // calcul du calibrage
  this.calibrage = (-14*jdecal)/13;
}


void configTMS() {

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

  while (prochaineSonnerie <= heurSecondes) {
    a = Lsonne [b] + calibrage;
    prochaineSonnerie = a;
    b++;
    if (b >= 26) {
      screen = 404;
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


  b--;
  derniereSonnerie = Lsonne [b] + calibrage;



  float d = (float)prochaineSonnerie/60;
  float partDecd = (float)(d-(floor(d)));
  sProchaineSonnerie = (int)(partDecd*60);
  float e = partDecd*60;

  sProchaineSonnerie = round(e);
  e = d/60;
  d = d-(floor(d));
  d = d+e;
  //hProchaineSonnerie = floor(d);
  hProchaineSonnerie = prochaineSonnerie/3600;
  e = e-(floor(e));
  mProchaineSonnerie = round(e*60);
}

void mousePressed() {
  appuis = true;
  if (mouseX>0.047*X && mouseY>Y*0.403 && mouseX<X*0.383 && mouseY<0.486*Y && screen == 2) {
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

void callScreen (int s) {

  screen = s;
}

void keyPressed() {
  if (keyCode==4) {
    if (screen==2||screen==3) {
      callScreen(1);
    }
  }
  keyCode = 0;
  key = 0;
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
