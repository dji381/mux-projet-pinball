import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.collision.Manifold;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Balle>balles;
ArrayList<Flipper> flippers;
ArrayList<PlateForme> plateFormes;
ArrayList<Colline> collines;
Surface surface;
Colline collineDroite;
Colline collineGauche;
Lanceur lanceur;
PImage img;
void setup() {

  size(400, 600);
  smooth();
  //create world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  //set gravity
  box2d.setGravity(0, -10);

  // Start listening for collisions
  //box2d.listenForCollisions();
  balles = new ArrayList<>();
  balles.add(new Balle(width-25, height-150));
  //flippers
  flippers = new ArrayList<>();
  flippers.add(new Flipper(125, height-100, 80, 25, true));
  flippers.add(new Flipper(width-150, height-100, 80, 25, false));
  surface = new Surface();
  //image
  img = loadImage("background.png");
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
  //lanceur
  lanceur = new Lanceur(width-20, height-100, 30, 25);
}
void draw() {
  // We must always step through time!
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
  //les flippers
  for (Flipper flipper : flippers) {
    flipper.display();
  }
  // la balle
  for (Balle b : balles) {
    b.display();
  }
  //coline
  for ( Colline c : collines) {
    c.display();
  }
  //lanceur
  lanceur.display();
}
void mouseClicked() {
  balles.add(new Balle(mouseX, mouseY));
}

//Touche du jeu
void pull() {
  //touche pour le lanceur
  if (keyPressed && key == ' ') {
    lanceur.tirerLanceur();
  }
 
}
void keyPressed() {
  //touche pour le flipper gauche
  if (key == 'a') {
    for (Flipper flipper : flippers ) {
      if (flipper.isLeftFlipper) {
        flipper.flip();
      }
    }
  }
  //touche pour le flipper droit
  if (key== 'p') {
    for (Flipper flipper : flippers ) {
      if (!flipper.isLeftFlipper) {
        flipper.flip();
      }
    }
  }
}
void keyReleased() {
  //Pour le flipper gauche
  if (key == 'a') {
    for (Flipper flipper : flippers ) {
      if (flipper.isLeftFlipper) {
        flipper.reverseFlip();
      }
    }
  }
  //pour le flipper droit
  if (key== 'p') {
    for (Flipper flipper : flippers ) {
      if (!flipper.isLeftFlipper) {
        flipper.reverseFlip();
      }
    }
  }
}
/*void beginContact(Contact cp) {
 //On recupére les 2 fixture
 Fixture f1 = cp.getFixtureA();
 Fixture f2 = cp.getFixtureB();
 //les 2 body
 Body b1 = f1.getBody();
 Body b2 = f2.getBody();
 //et les objets referencés par les bodys
 Object o1 = b1.getUserData();
 Object o2 = b2.getUserData();
 Manifold m = cp.getManifold();
 Balle b = (Balle) o2;
 b.bumpAway(50, m.localNormal);
 }*/
