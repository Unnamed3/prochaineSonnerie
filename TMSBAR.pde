boolean highlight = false;
int highlightID = 0;
int screenX = 0, screenY = 0;
float midX, midY; //milieu d ecran
int[] Lsonne = {0, 29100, 29400, 32700, 33100, 36000, 36600, 36900, 40200, 40500, 43500, 43800, 46800, 47100, 49800, 50100, 53400, 53700, 56700, 57300, 57600, 60900, 61200, 64200, 0, 0};
//8h05 = 29 100s | 8h10 = 29 400 | 9h05 = 32 700 | 9h10 = 33 000 | 10h = 36 000 |10h10 = 36 600|10h15 = 36 900|11h = 39 600|11h15 = 40 500|12h05 = 43 500|12h10 = 43 800|13h = 46 800|13h05 = 47 100|13h50 = 49 800|13h55 = 50 100|14h50 = 53 400|14h55 = 53 700|15h45 = 56 700|15h55 = 57 300|16h = 57 600|16h55 = 60 900|17h = 61 200|17h50 = 64 200
int SS = -170, SStemp = 0;
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

public static String OS = System.getProperty("os.name").toLowerCase();


void setup () {

   if (OS.equalsIgnoreCase("linux")) {
    size(1280,720); //tester la résolution d'écran de son choix
    
      try {
      loadfile = loadStrings("/storage/emulated/0/SS.var");
      String SSstring = loadfile[0];
      SS = parseInt(SSstring);
    } catch(Exception e) {
      String[] var = {"0"};
      saveStrings("/storage/emulated/0/SS.var", var);
    }

  }
  
  else if(OS.contains("windows")){
  surface.setSize(displayWidth/3, displayHeight/3);
  }
  screenX = width;
  screenY = height;
  midX = screenX*0.5;
  midY = screenY*0.5;
}




void draw () {

  if (screen == 404) {
    screen = 404;

    background(255);

    textAlign(CENTER, CENTER);
    fill(#00E8FF);
    text("Fin des cours !", midX, midY);
    text("Appuyer en dehors du bouton pour sortir", screenX/2, screenY*0.65);

    rectMode(CENTER);
    fill(255);

    fHighlight(1);
    rect(midX, screenY*0.2, screenY*0.8, screenY*0.2);

    fill(0);
    text("Back to main screen", midX, screenY*0.2);

    if (mousePressed) {
      if (mouseX>0.275*screenX && mouseY>screenY*0.1 && mouseX<screenX*0.725 && mouseY<0.3*screenY && screen == 404) {
        highlightID = 1;
        // Bouton back de tu n'est pas au lycée
      } else {exit();}
    }
  }


  if (screen == 1) {
    background(204);

    textSize (0.0765*screenY);
    textAlign(CENTER, CENTER);
    text("Bienvenue sur TMSBAR", midX, 0.07*screenY);

    rectMode(CENTER);
    fill(255);

    fHighlight(1);
    rect(screenX*0.25, midY, screenX*0.3, screenX*0.3);

    fHighlight(2);
    rect(screenX*0.75, midY, screenX*0.3, screenX*0.3);

    textAlign(CENTER, CENTER);
    fill(0);
    text("Launch", screenX*0.25, midY);
    text("Config", screenX*0.75, midY);

    // triangle(screenX/4+40, screenY/2+15, screenX/4+40, screenY/2+110, screenX/4+90, ((screenY/2+15)+(screenY/2+110))/2);
    //saveStrings("SS.txt", SS);
  }


  if (screen == 3) {  //setup screen
    /*
   background (0);
     fill(255);
     textAlign(CENTER, CENTER);
     text("Future function", screenX/2, screenY/2);
     delay(500);
     if (mousePressed){
     screen = 1;
     */

    background(255);

    fill(255);
    rectMode(CENTER);

    fHighlight(1);
    rect(screenX*0.10, midY, screenY*0.3, screenY*0.3);//rect -10

    fHighlight(2);
    rect(screenX*0.3, midY, screenY*0.3, screenY*0.3);//rect -1

    fHighlight(3);
    rect(screenX*0.7, midY, screenY*0.3, screenY*0.3);//rect +1
    
    fHighlight(4);
    rect(screenX*0.9, midY, screenY*0.3, screenY*0.3);//rect +1

    fill(255);
    
    fHighlight(5);
    rect(screenX*0.35, screenY*0.82, midY, screenY*0.2);

    fHighlight(6);
    rect(screenX*0.65, screenY*0.82, midY, screenY*0.2);

    fill(0);
    textAlign(CENTER, CENTER);

    text("Back", screenX*0.35, screenY*0.82);
    text("Save", screenX*0.65, screenY*0.82);
    text("-10", screenX*0.10, midY);

    text("-1", screenX*0.3, midY);
    text(SStemp, screenX/2, screenY/2);

    text("+1", screenX*0.7, midY);
    text("+10", screenX*0.9, midY);
  }



  if (screen == 2) {  //ecran affichage heure

    background (255);

    textAlign(CENTER,CENTER);
    
    fill(255);
    stroke (0);
    rect(screenX*0.94, screenX*0.01, screenX*0.05, screenX*0.05); // bouton retour affiché en haut à droite
    fill(0);
    textSize (0.04*screenY);
    text("Back", screenX*0.94+((screenX-screenX*0.94)/2), screenX*0.01+(screenX*0.01)/2);

    textSize (0.0765*screenY);
    textAlign (LEFT, TOP);
    text("Heure "+hour()+":"+minute()+":"+second(), 0.05*screenX, screenY*0.1);
    text("Prochaine sonnerie à : "+hProchaineSonnerie+"h"+mProchaineSonnerie+"m"+sProchaineSonnerie+"s", screenX*0.05, screenY*0.2);
    text(intercours[typeSn], screenX*0.05, screenY*0.3);

    a = hour(); 
    b = minute(); 
    c = second();
    b = a*60+b; 
    c = b*60+c; // convertir heure actuelle en secondes écoulées depuis minuit
    heurSecondes = c;

    timeLeft = prochaineSonnerie - heurSecondes; // le temps restant (en secondes) est la différence entre la prochaine sonnerie et l'heure actuelle
    
    float d = (float)timeLeft/60; // convertir en minutes...
    mTimeLeft = floor (d); //... puis mettre dans la variable d
    
    float partDecd = (float)(d-(floor(d))); //extraire la partie décimale de la variable d
    sTimeLeft = (int)(partDecd*60);
    
    float e = partDecd*60;
    sTimeLeft = round(e);

    hTimeLeft = timeLeft/3600; 

    fill(255, 0, 0);
    if (hTimeLeft == 0) {
      text("Il reste : "+mTimeLeft+"m"+sTimeLeft+"s", 0.05*screenX, screenY*0.4);
    } else {
      text("Il reste : "+hTimeLeft+"H "+mTimeLeft+"m"+sTimeLeft+"s", 0.05*screenX, screenY*0.4);
    }

    fill(255);
    //prochaineSonnerie = 2000; ///////////////LIGNE POUR DEBUG après 18h sans déregler l'heure de son pc (ajoute une sonnerie (en secondes écoulées depuis minuit))////////////////////////////////////
    
    rectMode(CORNER);
    fill(255);
    rect(0.05*screenX-1, 0.80*screenY-1, 0.89*screenX+2, 0.11*screenY+2);

    fill(#00E8FF);
    noStroke();
    float f = 0.89;
    //pourcentCours = 99;
    f *= (pourcentCours_/100);
    rect(screenX*0.05, screenY*0.8, screenX*f, screenY*0.11);
    stroke(0);

    //((K-J))/(B-J)*100>P
    // ((P/100)* - )
    //(heure now - début cours) ÷ sonnerie fin cours - début cours) x 100

    d = heurSecondes - derniereSonnerie;
    e = prochaineSonnerie - derniereSonnerie;
    pourcentCours = (d/e)*100;

    //arrondir au dixieme pres
    pourcentCoursInt = (int(pourcentCours*10));
    pourcentCours_ = (float(pourcentCoursInt));
    pourcentCours_ /= 10;

    textAlign(CENTER, CENTER);
    text("Progression du cours : " + pourcentCours_+"%", midX, 0.7*screenY);



    //line(screenX*0.5,screenY*0.7, screenX*0.5, screenY*0.8); // ligne pour vérifier si le 50% de la progressbar fonctionne correctement

    if (heurSecondes > prochaineSonnerie) {
      configTMS();
    }
  }
}






void configTMS() {

  a = hour();   b = minute(); c = second();
  b = a*60+b; c = b*60+c;
  heurSecondes = c;

  a=0; b=0; c=0;
  prochaineSonnerie = 0;

  while (prochaineSonnerie <= heurSecondes) {
    a = Lsonne [b] + SS;
    prochaineSonnerie = a;
    b++;
    if (b >= 26) {screen = 404; break;}
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
  derniereSonnerie = Lsonne [b] + SS;



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
  highlight = true; 
  
  if (mouseX>0.1*screenX && mouseY>screenY*0.2333 && mouseX<screenX*0.4 && mouseY<0.725*screenY && screen == 1) {
    highlightID = 1;
  }

  if (mouseX>0.015625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.184375 && mouseY<0.65*screenY && screen == 3) {
    highlightID = 1;

    // BOUTON -10
  }

  if (mouseX>0.215625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.384375 && mouseY<0.65*screenY && screen == 3) {
    highlightID = 2;

    // BOUTON -1
  }

  if (mouseX>0.615625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.784375 && mouseY<0.65*screenY && screen == 3) {
    highlightID = 3;

    // BOUTON +1
  }

  if (mouseX>0.815625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.984375 && mouseY<0.65*screenY && screen == 3) {
    highlightID = 4;

    // BOUTON +10
  }

  if (mouseX>0.209375*screenX && mouseY>screenY*0.7194 && mouseX<screenX*0.490625 && mouseY<0.9194*screenY && screen == 3) {
    highlightID = 5;

    // BOUTON Back
  }

  if (mouseX>0.509375*screenX && mouseY>screenY*0.7194 && mouseX<screenX*0.790625 && mouseY<0.9194*screenY && screen == 3) {
    highlightID = 6;

    // BOUTON Save
  }

  /*
  Highlight IDs (main screen)
   1 = Bouton qui lance l'écran principal
   2 = Bouton SS
   
   Highlight IDs (setup screen)
   1 = bouton -10
   2 = bouton -1
   3 = bouton +1
   4 = bouton +10
   5 = bouton Back
   6 = bouton Save
   */

  if (mouseX>0.6*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.9 && mouseY<0.77*screenY && screen == 1) {
    highlightID = 2;
  }
}







void mouseReleased() {
  highlightID = 0;
  highlight = false;

  if (mouseX>0.1*screenX && mouseY>screenY*0.2333 && mouseX<screenX*0.4 && mouseY<0.725*screenY && screen == 1) {
    configTMS();
    screen = 2;
    // Bouton launch
  }

  if (mouseX>0.6*screenX && mouseY>screenY*0.13125 && mouseX<screenX*0.9 && mouseY<0.77*screenY && screen == 1) {
    screen = 3;
    SStemp = SS;
    mouseX=0;
    mouseY=0;
    // Bouton config
  }

  if (mouseX>0.275*screenX && mouseY>screenY*0.1 && mouseX<screenX*0.725 && mouseY<0.3*screenY && screen == 404) {
    screen = 1;
    // Bouton back de tu n'est pas au lycée
  }

  if (mouseX>0.015625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.184375 && mouseY<0.65*screenY && screen == 3) {
    SStemp = SStemp-10;
  }

  if (mouseX>0.215625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.384375 && mouseY<0.65*screenY && screen == 3) {   
    SStemp = SStemp-1;
    // BOUTON -1
  }

  if (mouseX>0.615625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.784375 && mouseY<0.65*screenY && screen == 3) {
    SStemp = SStemp+1;
    // BOUTON +1
  }

  if (mouseX>0.815625*screenX && mouseY>screenY*0.35 && mouseX<screenX*0.984375 && mouseY<0.65*screenY && screen == 3) {
    SStemp = SStemp+10;
    // BOUTON +10
  }

  if (mouseX>0.209375*screenX && mouseY>screenY*0.7194 && mouseX<screenX*0.490625 && mouseY<0.9194*screenY && screen == 3) {
    screen = 1;
    // BOUTON Back
  }

  if (mouseX>0.509375*screenX && mouseY>screenY*0.7194 && mouseX<screenX*0.790625 && mouseY<0.9194*screenY && screen == 3) {

    SS = SStemp;
    loadfile[0] = str(SS);
    saveStrings("/storage/emulated/0/SS.var", loadfile);
    // BOUTON Save
  }

  if (mouseX>0.95*screenX && mouseY>0 && mouseX<screenX && mouseY<0.09*screenY && screen == 2) {
    screen = 1;
    // Bouton launch
  }
}



void fHighlight(int X){ //fonction highlight
      if (highlight == true && highlightID == X) {
      fill(127);
    } else {
      fill (255);
    }
  }
