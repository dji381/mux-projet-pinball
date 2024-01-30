public class FlipperStructure extends PlateForme {
  boolean isLeft;
  PlateForme structure;
  
  public FlipperStructure(int posX, int posY, float _w, float _h, boolean isLeft) {
    super(posX, posY, BodyType.STATIC, _w, _h);
    this.isLeft = isLeft;
    
    if (isLeft) {
      body.setTransform(body.getPosition(), radians(-35));
      structure = new PlateForme(posX-(int)_h, posY-35, BodyType.STATIC, _h, 35);
    } else {
      body.setTransform(body.getPosition(), radians(35));
      structure = new PlateForme(posX+(int)_h, posY-35, BodyType.STATIC, _h, 35);
    }

    structure.createBody();
    createBody();
  }

  void display() {
    float a = body.getAngle();
    Vec2 position = box2d.getBodyPixelCoord(body);
    Vec2 positionStructure = box2d.getBodyPixelCoord(structure.body);
    pushMatrix();
    translate(positionStructure.x, positionStructure.y);
    fill(color(240, 88, 111));
    strokeWeight(3);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, structure.w, structure.h+5);
    popMatrix();
    pushMatrix();
    translate(position.x, position.y);
    rotate(-a);
    noStroke();
    rectMode(CENTER);
    rect(0, -5, w+5, h);
    popMatrix();
  }
}
