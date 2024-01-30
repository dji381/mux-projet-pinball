public class Bumper extends Figure {
  //Forme
  PolygonShape bumper;
  ArrayList<Vec2>vertices;
  PImage img;
  AudioPlayer bumpSound;
  public Bumper(int posX, int posY, int[] verticesPos) {
    super(posX, posY, BodyType.STATIC);
    this.vertices = new ArrayList<>();
    //copie des verticesPos
    for (int i = 0; i< verticesPos.length; i+=2) {
      this.vertices.add(box2d.vectorPixelsToWorld(new Vec2(verticesPos[i], verticesPos[i+1])));
    }
    c = color(240, 88, 111);
    bumpSound = minim.loadFile("bump.mp3");
    createBody();
  }
  void setImage(String imgUrl) {
    this.img = loadImage(imgUrl);
  }
  void createBody() {
    Vec2[] ver = new Vec2[this.vertices.size()];
    for (int i = 0; i< vertices.size(); i++) {
      ver[i] = vertices.get(i);
    }
    
    //création d'un polygon depuis le tableau
    bumper = new PolygonShape();
    bumper.set(ver, ver.length);
    body.createFixture(bumper, 1);
    body.setUserData(this);
  }
  
  void setColor (color c) {
    this.c = c;
    fill(c);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    // recupérer la fixture
    Fixture f = body.getFixtureList();
    //puis la forme
    PolygonShape ps = (PolygonShape) f.getShape();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    if (img == null) {
      fill(c);
      stroke(58, 58, 58);
      beginShape();
      //convertir chaque sommet de l'espace Box2D en pixels.
      for (int i = 0; i < bumper.getVertexCount(); i++) {
        Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    } else {
      image(img, 0-35/2, 0-35/2, 35, 35);
    }

    popMatrix();
  }
  //son pour les collisions
  void bump() {
    bumpSound.setGain(10.0f);
    if (bumpSound.isPlaying()) {
      bumpSound.rewind();
      bumpSound.play();
    } else {
      bumpSound.play();
      bumpSound.rewind();
    }
  }
  void killBody() {
    box2d.destroyBody(body);
  }
}
