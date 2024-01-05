public class Flipper {
  boolean isLeftFlipper;
  PlateForme pt;
  PlateForme base;
  Flipper(int posX, int posY, float _w, float _h, boolean isLeft ) {
    pt = new PlateForme(posX, posY, BodyType.DYNAMIC, _w, _h);
    base = new PlateForme((int)pt.pos.x,(int) pt.pos.y,BodyType.STATIC,1,1);
    this.isLeftFlipper = isLeft;
    createBody();
  }

  void createBody() {
    pt.createBody();
    base.createBody();
    RevoluteJointDef rotationJoint = new RevoluteJointDef();
    if (isLeftFlipper) {
      rotationJoint.initialize(pt.body, base.body, new Vec2(pt.pos.x-pt.pfW, pt.pos.y));
    }
    if (!isLeftFlipper) {
      rotationJoint.initialize(pt.body, base.body, new Vec2(pt.pos.x+pt.pfW, pt.pos.y));
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
      pt.body.applyTorque(500000);
    } else {
      pt.body.applyTorque(500000*-1);
    }
  }
    void reverseFlip() {
    if (!isLeftFlipper) {
      pt.body.applyTorque(500000);
    } else {
      pt.body.applyTorque(500000*-1);
    }
  }
  void display() {
    pt.setColor(color(0,0,0));
    pt.display();
    base.display();
    
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
