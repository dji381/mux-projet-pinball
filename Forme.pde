class Forme {
  // Make a body definition before making a Body.
  BodyDef bd;
  //position of the body
  Vec2 center;
  //the body
  Body body;
  //shape
  PolygonShape ps;

  //the size of the shape
  float box2Dw;
  float box2Dh;

  //fixture
  FixtureDef fd;
  public Forme () {
    bd = new BodyDef();
    center = box2d.coordPixelsToWorld(width/2, height/2);
    bd.position.set(center);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    // Setting an arbitrary initial velocity
    body.setLinearVelocity(new Vec2(0, 3));
    // Setting an arbitrary initial angular velocity
    body.setAngularVelocity(1.2);
    //the shape
    ps = new PolygonShape();
    //size of the shape
    box2Dw = box2d.scalarPixelsToWorld(150);
    box2Dh = box2d.scalarPixelsToWorld(100);
    ps.setAsBox(box2Dw, box2Dh);
    //fixture
    fd = new FixtureDef();
    // The fixture is assigned the PolygonShape we just made.
    fd.shape = ps;
    // The coefficient of friction for the
    // shape, typically between 0 and 1
    fd.friction = 0.3;
    fd.restitution = 0.5;
    fd.density = 1.0;
    // Creates the Fixture and attaches the Shape to the Body object
    body.createFixture(fd);
  }

  void display() {
    //get the position of the body
    Vec2 pos = box2d.getBodyPixelCoord(body);
    //get the angle
    float a = body.getAngle();

    pushMatrix();
    //[full] Using the Vec2 position and float angle to translate and rotate the rectangle
    translate(pos.x, pos.y);
    rotate(-a);
    //[end]
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, box2Dw, box2Dh);
    popMatrix();
  }

  // This function removes a body from the Box2D world.
  void killBody() {
    box2d.destroyBody(body);
  }
}
