class Buisson extends PlateForme {
  PImage img;
  public Buisson(int posX, int posY, BodyType bt, float _w, float _h) {
    super(posX, posY, bt, _w, _h);
    img = loadImage("ground-min.png");
    createBody();
  }

  void display() {
    Vec2 position = box2d.getBodyPixelCoord(this.body);
    float a = this.body.getAngle();

    pushMatrix();
    translate(position.x, position.y);
    rotate(-a);
    image(img, 0-w/2, 0-80/2-5, w, 80);
    popMatrix();
  }
}
