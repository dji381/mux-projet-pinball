public class PlateForme extends Figure {

  //Forme
  PolygonShape plateforme;

  //taille de la plateForme
  float pfW;
  float pfH;
  //taille initale (en pixel) de la plateforme
  float w,h;

  public PlateForme(int posX, int posY, BodyType bt, float _w, float _h) {
    super(posX, posY, bt);
    w=_w;
    h=_h;
    pfW = box2d.scalarPixelsToWorld(w/2);
    pfH = box2d.scalarPixelsToWorld(h/2);
    createBody();
  }

  void createBody() {
    plateforme = new PolygonShape();
    plateforme.setAsBox(pfW,pfH);
    body.createFixture(plateforme,1);
  }
  void display() {
    // On utilise la position et l'angle du corps pour placer l'objet 
    float a = body.getAngle();
    Vec2 position = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(position.x, position.y);
    rotate(-a);
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  void killBody() {
    box2d.destroyBody(body);
  }
}
