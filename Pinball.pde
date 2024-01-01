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
Surface surface;
PlateForme pt;

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
  balles.add(new Balle(width/2, height/2));
  //flippers
  flippers = new ArrayList<>();
  flippers.add(new Flipper(125, height-100, BodyType.DYNAMIC, 80, 25, true));
  flippers.add(new Flipper(width-150, height-100, BodyType.DYNAMIC, 80, 25, false));
  surface = new Surface();
  //image
  img = loadImage("background.png");
  //plateformes
  plateFormes = new ArrayList<>();
  plateFormes.add(new PlateForme(width/2, height/2+100, BodyType.STATIC, 150, 10));
  plateFormes.add(new PlateForme(width-24*2, height/2+135, BodyType.STATIC,30,height-(height/2-80)));
}
void draw() {
  // We must always step through time!
  box2d.step();
  background(img);
  //la surface du flipper
  surface.display();
  //les plateformes
  for (PlateForme pt : plateFormes){
    pt.setColor(color(60,98,172));
    pt.createBody();
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
}
void mouseClicked() {
  balles.add(new Balle(mouseX, mouseY));
  for (Flipper flipper : flippers ){
    if(flipper.isLeftFlipper){
      flipper.flip();
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
