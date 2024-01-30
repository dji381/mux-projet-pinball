public class Colline extends Figure {
  //Forme
  PolygonShape colline;
  ArrayList<Vec2>vertices;

  public Colline(int posX, int posY, int[] verticesPos) {
    super(posX, posY, BodyType.STATIC);
    this.vertices = new ArrayList<>();
    for (int i = 0; i< verticesPos.length; i+=2) {
      this.vertices.add(box2d.vectorPixelsToWorld(new Vec2(verticesPos[i],verticesPos[i+1])));
    }
    createBody();
  }

  void createBody() {
    Vec2[] ver = new Vec2[this.vertices.size()];
    for (int i = 0; i< vertices.size(); i++){
      ver[i] = vertices.get(i);
    }
    colline = new PolygonShape();
    colline.set(ver, ver.length);
    body.createFixture(colline, 1);
    body.setUserData(this);
  }
  
  void setColor (color c) {
    this.c = c;
    fill(c);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    noFill();
    noStroke();
    beginShape();
  
    for (int i = 0; i < colline.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  void killBody() {
    box2d.destroyBody(body);
  }
}
