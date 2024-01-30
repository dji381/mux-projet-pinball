import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.collision.Manifold;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Box2DProcessing box2d;
Balle balle;
ArrayList<Flipper> flippers;
ArrayList<PlateForme> plateFormes;
ArrayList<Colline> collines;
ArrayList<Bumper> bumpers;
ArrayList<FlipperStructure> flipperStructure;
ArrayList<TriangleBumper> triangles;
Surface surface;
Lanceur lanceur;
Buisson buisson;
Pokemon pokemon;
PImage img;

//Le son
Minim minim;
AudioOutput output;
AudioPlayer ost;

//logique du jeu
int vies;
int score;

//font
PFont gamingFont;

void setup() {

  size(400, 600);
  frameRate(60);
  
  //son
  minim = new Minim(this);
  ost = minim.loadFile("Pokemon_pinball_ost.mp3");
  ost.play();
  ost.loop();
 
  //logique de jeu
  vies = 3;
  score =0;
  
  //font
  gamingFont = createFont("gaming-font.ttf", 12);
  textFont(gamingFont);
  
  //create world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  //set gravity
  box2d.setGravity(0, -10);

  // Start listening for collisions
  box2d.listenForCollisions();

  //balle
  balle = new Balle(width-25, height-150);

  //flippers
  flippers = new ArrayList<>();
  flippers.add(new Flipper(150, height-50, 45, 15, true));
  flippers.add(new Flipper(width-175, height-50, 45, 15, false));

  //structure à la base des flippers
  flipperStructure = new ArrayList<>();
  flipperStructure.add(new FlipperStructure(150-50, height-65, 50, 15, true));
  flipperStructure.add(new FlipperStructure(width-127, height-65, 50, 15, false));
  surface = new Surface();

  //image
  img = loadImage("background-2-min.png");

  //plateformes
  plateFormes = new ArrayList<>();
  //plateforme droite
  plateFormes.add(new PlateForme(width-25*2, height/2+128, BodyType.STATIC, 30, height-(height/2-80)));

  //Collines
  collines = new ArrayList<>();
  //coline à droite
  collines.add(new Colline(width/2 + 100, height/2+100, new int[]{0, 40, 35, 60, 35, -25, 0, -5}));
  //coline à gauche
  collines.add(new Colline(25, height/2+75, new int[]{0, 80, 50, 65, 50, 20, 0, -50}));

  //bumpers
  bumpers = new ArrayList<>();
  //bumper du haut
  Vec2 bumperPosition = new Vec2(width/2+50, 200);
  Bumper topBumper = new Bumper((int)bumperPosition.x, (int)bumperPosition.y, new int[]{15, 0, 10, 10, 0, 15, -10, -10, -15, 0, -10, 10, 0, -15, 10, -10});
  topBumper.setImage("Salameche-min.png");
  bumpers.add(topBumper);
  //bumper de gauche
  Bumper leftBumper = new Bumper((int)bumperPosition.x-5, (int)bumperPosition.y+55, new int[]{15, 0, 10, 10, 0, 15, -10, -10, -15, 0, -10, 10, 0, -15, 10, -10});
  leftBumper.setImage("carapuce-min.png");
  bumpers.add(leftBumper);
  //bumper de droite
  Bumper rightBumper = new Bumper((int)bumperPosition.x+35, (int)bumperPosition.y+35, new int[]{15, 0, 10, 10, 0, 15, -10, -10, -15, 0, -10, 10, 0, -15, 10, -10});
  rightBumper.setImage("bulbizarre-min.png");
  bumpers.add(rightBumper);

  //bumpers triangles
  triangles = new ArrayList<>();
  //bumper triangle en bas a gauche
  TriangleBumper leftTriangle = new TriangleBumper(135, height-100, new int[]{-20, -20, -20, 0, -5, 10}, "left_bumper-min.png", true);
  triangles.add(leftTriangle);
  //bumper triangle en bas a droite
  TriangleBumper rightTriangle = new TriangleBumper(240, height-100, new int[]{20, -20, 20, 0, 5, 10}, "right_bumper-min.png", false);
  triangles.add(rightTriangle);
  //lanceur
  lanceur = new Lanceur(width-20, height-100, 30, 25);
  //buisson en haut
  buisson = new Buisson(width/2-80, 250, BodyType.STATIC, 100, 20);
  //pokemon qui se deplace
  pokemon = new Pokemon(width/2-110, 225, BodyType.KINEMATIC, 30, 30);
}
void draw() {
  // step dans le temps
  box2d.step();
  background(img);
  //appel de la fonction a chaque frame pour eviter les effets de saccade sur un appuis prolongé pour le lanceur
  pull();
  //la surface du flipper
  surface.display();
 
  //les plateformes
  for (PlateForme pt : plateFormes) {
    pt.createBody();
    //pt.setColor(color(200,0,0));
    pt.display();
  }
  for (FlipperStructure fp : flipperStructure) {
    fp.display();
  }
  //les flippers
  for (Flipper flipper : flippers) {
    flipper.display();
  }

  //coline
  for ( Colline c : collines) {
    c.display();
  }
  //bumpers
  for (Bumper b : bumpers) {
    b.display();
  }
  //triangle
  for (TriangleBumper tb : triangles) {
    tb.display();
  }
  //lanceur
  lanceur.display();
  //buisson
  buisson.display();
  //pokemon
  pokemon.display();
  pokemon.deplacement();

  //logique du jeu

  if (vies >= 0) {
    // la balle
    balle.display();
    if (balle.horsChamp()) {
      balle = balle.reset();
    }

    //score
    fill(137, 218, 88);
    noStroke();
    rect(20, 20, 270, 40);
    fill(0);
    textSize(12);
    textAlign(LEFT, CENTER);
    text("Score: "+score, 5, 30);
    text("Vies restantes: "+vies, 5, 15);
  } else {
    fill(247, 215, 133);
    noStroke();
    rect(width/2, height/2, 140, 40);
    rect(width/2, height/2+25, 320, 40);
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("Fin de partie !", width/2, height/2);
    text("Appuyez sur y pour recommencer.", width/2, height/2+25);
  }
}

//Touche du jeu
void pull() {
  //touche pour le lanceur
  if (keyPressed && key == ' ') {
    lanceur.tirerLanceur();
  }
}

//relancer le jeu
void resetGame() {
  // Réinitialiser les variables d'état du jeu
  vies = 3;
  score = 0;
  ost.rewind();
}

void keyPressed() {
  //touche pour le flipper gauche
  if (key == 'a' || key == 'A') {
    for (Flipper flipper : flippers ) {
      if (flipper.isLeftFlipper) {
        flipper.flip();
      }
    }
  }
  //touche pour le flipper droit
  if (key== 'p' || key == 'P') {
    for (Flipper flipper : flippers ) {
      if (!flipper.isLeftFlipper) {
        flipper.flip();
      }
    }
  }
   if (key == 'y' || key == 'Y') {
    if (vies < 0) {
      resetGame();
    }
  }
}
void keyReleased() {
  //Pour le flipper gauche
  if (key == 'a' || key == 'A') {
    for (Flipper flipper : flippers ) {
      if (flipper.isLeftFlipper) {
        flipper.reverseFlip();
      }
    }
  }
  //pour le flipper droit
  if (key== 'p' || key == 'P') {
    for (Flipper flipper : flippers ) {
      if (!flipper.isLeftFlipper) {
        flipper.reverseFlip();
      }
    }
  }
 
}
void beginContact(Contact cp) {
  //On recupére les 2 fixture
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  //les 2 body
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  //et les objets referencés par les bodys
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  //collision entre balle et bumper
  if (o1.getClass() == Balle.class && o2.getClass() == Bumper.class ) {
    score +=50;
    Manifold m = cp.getManifold();
    Balle b = (Balle) o1;
    Bumper bumper = (Bumper) o2;
    b.bumpAway(m.localNormal);
    bumper.bump();
  } else if (o2.getClass() == Balle.class && o1.getClass() == Bumper.class) {
    score +=50;
    Manifold m = cp.getManifold();
    Balle b = (Balle) o2;
    Bumper bumper = (Bumper) o1;
    b.bumpAway(m.localNormal);
    bumper.bump();
  }

  //collison entre balle et pokemon qui se deplace
  if (o1.getClass()== Pokemon.class && o2.getClass() == Balle.class) {
    score +=100;
    Pokemon p = (Pokemon) o1;
    p.charge();
  } else if (o2.getClass()== Pokemon.class && o1.getClass() == Balle.class) {
    score +=100;
    Pokemon p = (Pokemon) o2;
    p.charge();
  }

  //collison entre triangle bumper et balle
  if (o1.getClass() == TriangleBumper.class && o2.getClass() == Balle.class) {
    score +=10;
    TriangleBumper tb = (TriangleBumper)o1;
    tb.playSound();
  } else if (o2.getClass() == TriangleBumper.class && o1.getClass() == Balle.class) {
    score +=10;
    TriangleBumper tb = (TriangleBumper)o2;
    tb.playSound();
  }
}
void endContact(Contact c)
{
  // End contact method stub
}
