public class Balle extends Figure {

  CircleShape balle;
  float balleW,w;
  public Balle (int posX, int posY, BodyType bt) {
    super(posX, posY, bt);
    createBody();
  }
  void createBody() {
    w=10;
    // Setting an arbitrary initial velocity
    body.setLinearVelocity(new Vec2(0, 0));
    // Setting an arbitrary initial angular velocity
    body.setAngularVelocity(-1.2);
    //the shape
    balle = new CircleShape();
    //size of the shape
    balleW = box2d.scalarPixelsToWorld(w/2);
    balle.setRadius(balleW);
    fd.shape = balle;
    // The coefficient of friction for the
    // shape, typically between 0 and 1
    fd.friction = 0.1;
    fd.restitution = 0.3;
    fd.density = 1.0;
    // Creates the Fixture and attaches the Shape to the Body object
    body.createFixture(fd);
  }
  void display() {
    //get the position of the body
    Vec2 position = box2d.getBodyPixelCoord(body);
    //get the angle
    float a = body.getAngle();

    pushMatrix();
    // Using the Vec2 position and float angle to translate and rotate the rectangle
    translate(position.x, position.y);
    rotate(-a);
    //[end]
    fill(255,0,0);
    stroke(0);
    circle(0, 0, w);
    popMatrix();
  }
  void killBody() {
    box2d.destroyBody(body);
  }
}
