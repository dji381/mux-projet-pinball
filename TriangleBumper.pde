class TriangleBumper extends Bumper {
  PImage img;
  boolean isLeft;
  AudioPlayer triangleSound;
  public TriangleBumper(int posX, int posY, int[] verticesPos, String image, boolean isLeft) {
    super(posX, posY, verticesPos);
    this.isLeft = isLeft;
    img = loadImage(image);
    triangleSound = minim.loadFile("triangle_sfx.mp3");
    body.setUserData(this);
  }
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    if (isLeft) {
      image(img, 0-25, 0-50/2, 25, 40);
    } else {
      image(img, 0, 0-50/2, 25, 40);
    }
    fill(c);
    stroke(58, 58, 58);
    popMatrix();
  }
  void playSound(){
    triangleSound.setGain(10.0f);
    if (bumpSound.isPlaying()) {
      triangleSound.rewind();
      triangleSound.play();
    } else {
      triangleSound.play();
      triangleSound.rewind();
    }
  }
}
