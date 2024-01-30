public class Flipper {
  boolean isLeftFlipper;
  PlateForme pt;
  PlateForme base;
  AudioPlayer flipperSound;
  Flipper(int posX, int posY, float _w, float _h, boolean isLeft ) {
    pt = new PlateForme(posX, posY, BodyType.DYNAMIC, _w, _h);
    base = new PlateForme((int)pt.pos.x, (int) pt.pos.y, BodyType.STATIC, 1, 1);
    this.isLeftFlipper = isLeft;
    flipperSound = minim.loadFile("flipper_sfx.mp3");
    createBody();
  }

  void createBody() {
    pt.createBody();
    base.createBody();
    //utilisation d'un RevoluteJoint pour joindre la base et la plateforme du flipper
    RevoluteJointDef rotationJoint = new RevoluteJointDef();
    if (isLeftFlipper) {
      rotationJoint.initialize(pt.body, base.body, new Vec2(pt.pos.x-pt.pfW, pt.pos.y));
    }
    if (!isLeftFlipper) {
      rotationJoint.initialize(pt.body, base.body, new Vec2(pt.pos.x+pt.pfW, pt.pos.y));
    }
    rotationJoint.collideConnected = false;
    rotationJoint.enableLimit = true;
    //angle min et max
    rotationJoint.lowerAngle = radians(-35);
    rotationJoint.upperAngle = radians(35);
    //creation de la jointure
    box2d.createJoint(rotationJoint);
    pt.body.setUserData(this);
  };
  
  //methode pour faire bouger les flippers lorsque la touche est préssé 
  void flip() {
    flipperSound.setGain(10.0f);
     if (flipperSound.isPlaying()) {
      flipperSound.rewind();
      flipperSound.play();
    } else {
      flipperSound.play();
      flipperSound.rewind();
    }
    if (isLeftFlipper) {
      pt.body.applyTorque(500000);
    } else {
      pt.body.applyTorque(500000*-1);
    }
  }
  //baisser les flipper lorsque la touche est relaché
  void reverseFlip() {
    if (!isLeftFlipper) {
      pt.body.applyTorque(500000);
    } else {
      pt.body.applyTorque(500000*-1);
    }
  }
  
  void display() {
    fill(255);
    pt.display();
    // les cercle a la base des flippers
    float a = pt.body.getAngle();
    Vec2 position = box2d.getBodyPixelCoord(pt.body);
    pushMatrix();
    translate(position.x, position.y);
    rotate(-a);
    if (isLeftFlipper) {
      //gros cercle
      fill(200);
      stroke(0);
      circle(0-pt.w/2, 0, 20);
      //petit cercle
      fill(255);
      noStroke();
      circle(0+pt.w/2, 0, 15);
    } else {
      //petit cercle
      fill(200);
      stroke(0);
      circle(0+pt.w/2, 0, 20);
      //gros cercle
      fill(255);
      noStroke();
      circle(0-pt.w/2, 0, 15);
    }

    popMatrix();
  }

  void killBody() {
  };
}
