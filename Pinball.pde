import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Balle>balles;
Surface surface;
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
  balles.add(new Balle(width/2, height/2, BodyType.DYNAMIC));
  surface = new Surface();
  
  
}
void draw() {
  // We must always step through time!
  box2d.step();
  background(255);
  surface.display();
  for (Balle b : balles) {
    b.display();
  }
}
void mouseClicked() {
  balles.add(new Balle(mouseX, mouseY, BodyType.DYNAMIC));
}
