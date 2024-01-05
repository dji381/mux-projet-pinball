class Lanceur {
  PImage img;
  PlateForme plateformeLanceur;
  PlateForme baseLanceur;
  DistanceJoint dj;
  public Lanceur(int posX, int posY, float _w, float _h) {
    plateformeLanceur = new PlateForme(posX, posY, BodyType.DYNAMIC, _w, _h);
    baseLanceur = new PlateForme(posX, posY+100, BodyType.STATIC, _w, _h);
    img = loadImage("mew.png");
    createBody();
  }


  void display() {
    /*plateformeLanceur.setColor(color(255, 0, 0));
    plateformeLanceur.display();*/
        //get the position of the body
    Vec2 position = box2d.getBodyPixelCoord(plateformeLanceur.body);
    //get the angle
    float a = plateformeLanceur.body.getAngle();

    pushMatrix();
    // Using the Vec2 position and float angle to translate and rotate the rectangle
    translate(position.x, position.y);
    rotate(-a);
    image(img,0-40/2,0-40/2-5, 40, 40);
    popMatrix();
    
  }
  void killBody() {
  }
  void createBody() {
    plateformeLanceur.bd.setFixedRotation(true);
    baseLanceur.bd.setFixedRotation(true);
    plateformeLanceur.createBody();
    baseLanceur.createBody();

    //distance joint
    DistanceJointDef djd = new DistanceJointDef();
    
    djd.frequencyHz = 3;
    djd.dampingRatio = 0.1;
    djd.initialize(plateformeLanceur.body, 
    baseLanceur.body, 
    plateformeLanceur.body.getPosition(), 
    baseLanceur.body.getPosition());
    dj = (DistanceJoint) box2d.world.createJoint(djd);
  }
  void tirerLanceur()
  {
    plateformeLanceur.body.applyForce(new Vec2(0, -100000), plateformeLanceur.body.getPosition());
  }
  
}
