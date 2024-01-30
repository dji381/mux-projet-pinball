class Lanceur {
  PImage img;
  PlateForme plateformeLanceur;
  PlateForme baseLanceur;
  DistanceJoint dj;
  AudioPlayer pullSound;
  public Lanceur(int posX, int posY, float _w, float _h) {
    plateformeLanceur = new PlateForme(posX, posY, BodyType.DYNAMIC, _w, _h);
    baseLanceur = new PlateForme(posX, posY+100, BodyType.STATIC, _w, _h);
    img = loadImage("mew-min.png");
    pullSound = minim.loadFile("pull.mp3");
    createBody();
  }


  void display() {
    Vec2 position = box2d.getBodyPixelCoord(plateformeLanceur.body);
    float a = plateformeLanceur.body.getAngle();
    pushMatrix();
    translate(position.x, position.y);
    rotate(-a);
    image(img,0-40/2,0-40/2-5, 40, 40);
    popMatrix();
    
  }
  void killBody() {
  }
  void createBody() {
    //creation des 2 body pour la fixture
    plateformeLanceur.bd.setFixedRotation(true);
    baseLanceur.bd.setFixedRotation(true);
    plateformeLanceur.createBody();
    baseLanceur.createBody();

    //distance joint
    DistanceJointDef djd = new DistanceJointDef();
    //parametre du ressort
    djd.frequencyHz = 3;
    djd.dampingRatio = 0.1;
    //initialisation du distance joint
    djd.initialize(plateformeLanceur.body, 
    baseLanceur.body, 
    plateformeLanceur.body.getPosition(), 
    baseLanceur.body.getPosition());

    dj = (DistanceJoint) box2d.world.createJoint(djd);
    this.plateformeLanceur.body.setUserData(this);
    this.baseLanceur.body.setUserData(this);
  }
  void tirerLanceur()
  {
    //on tire le lanceur vers le bas
    plateformeLanceur.body.applyForce(new Vec2(0, -100000), plateformeLanceur.body.getPosition());
    pullSound.setGain(10.0f);
    if (pullSound.isPlaying()) {
      pullSound.rewind();
      pullSound.play();
    }
    else{
      pullSound.play();
      pullSound.rewind();
    }
  }
  
}
