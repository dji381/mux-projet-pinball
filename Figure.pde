abstract class Figure {

  // definition du corps.
  BodyDef bd;
  //position du corps
  Vec2 pos;
  //the body
  Body body;
  //fixture
  FixtureDef fd;
  //couleur de la forme
  color c;
  public Figure(int posX, int posY, BodyType bt) {
    //definition et positionnement initial du corps
    bd = new BodyDef();
    pos = box2d.coordPixelsToWorld(posX, posY);
    bd.position.set(pos);
    //definition du type de body
    bd.type = bt;
    //creation du body
    body = box2d.createBody(bd);
    //creation de la fixture
    fd = new FixtureDef();
  }

  abstract void display();
  abstract void killBody();
  abstract void createBody();
}
