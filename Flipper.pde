public class Flipper {
  boolean isLeftFlipper;
  PlateForme pt;
  Flipper(int posX, int posY, BodyType bt, float _w, float _h, boolean isLeft ) {
    pt = new PlateForme(posX, posY, bt, _w, _h);
    this.isLeftFlipper = isLeft;
    createBody();
  }

  void createBody() {
    pt.createBody();
    // Create base
    PolygonShape baseShape = new PolygonShape();
    baseShape.setAsBox(1, 1);

    // Define physics body
    BodyDef baseBodyDef = new BodyDef();
    baseBodyDef.type = BodyType.STATIC;
    baseBodyDef.position.set(box2d.coordPixelsToWorld(new Vec2(pt.pos.x, pt.pos.y)));
    baseBodyDef.setFixedRotation(true);

    // Add body to world
    Body baseBody = box2d.createBody(baseBodyDef);
    baseBody.createFixture(baseShape, 1);

    RevoluteJointDef rotationJoint = new RevoluteJointDef();
    if (isLeftFlipper) {
      rotationJoint.initialize(pt.body, baseBody, new Vec2(pt.pos.x-pt.pfW, pt.pos.y));
    }
    if (!isLeftFlipper) {
      rotationJoint.initialize(pt.body, baseBody, new Vec2(pt.pos.x+pt.pfW, pt.pos.y));
    }
    rotationJoint.collideConnected = false;


    rotationJoint.enableLimit = true;
    rotationJoint.lowerAngle = radians(-35);
    rotationJoint.upperAngle = radians(35);
    box2d.createJoint(rotationJoint);
    // set the callback data to this instance
    pt.body.setUserData(this);
  };
  void flip() {
    if (isLeftFlipper) {
      pt.body.applyTorque(1000000);
    } else {
      pt.body.applyTorque(1000000*-1);
    }
  }
  void display() {
    pt.display();
    // les cercle a la base des flippers

    float a = pt.body.getAngle();
    Vec2 position = box2d.getBodyPixelCoord(pt.body);
    pushMatrix();
    translate(position.x, position.y);
    rotate(-a);
    fill(200);
    stroke(0);
    if (isLeftFlipper) {
      circle(0-pt.w/2, 0, 30);
      circle(0+pt.w/2, 0, 25);
    } else {
      circle(0+pt.w/2, 0, 30);
      circle(0-pt.w/2, 0, 25);
    }

    popMatrix();
  }

  void killBody() {
  };
}
