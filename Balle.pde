public class Balle extends Figure {

  CircleShape balle;
  float balleW,w;
  PImage img;
  public Balle (int posX, int posY) {
    super(posX, posY, BodyType.DYNAMIC);
    c = color(255,0,0);
    img = loadImage("pokeball-min.png");
    createBody();
    
  }
  void createBody() {
    w=20;
    // Définir une vitesse initiale arbitraire
    body.setLinearVelocity(new Vec2(0, 0));
    // Définition d'une vitesse angulaire initiale arbitraire
    body.setAngularVelocity(-1.2);
    //La forme
    balle = new CircleShape();
    //Taille
    balleW = box2d.scalarPixelsToWorld(w/2);
    balle.setRadius(balleW);
    fd.shape = balle;
    // Coefficient de  friction
    fd.friction = 0.1;
    fd.restitution = 0.3;
    fd.density = 1.0;
    // Crée la Fixture et attache la Shape au Body object
    body.createFixture(fd);
    //reference pour y avoir accés pour le colision
    body.setUserData(this);
  }
  void display() {
    //Position du body
    Vec2 position = box2d.getBodyPixelCoord(body);
    //l'angle
    float a = body.getAngle();

    pushMatrix();
    //Utilisation de la position Vec2 et de l'angle flottant pour translate et faire pivoter le rectangle
    translate(position.x, position.y);
    rotate(-a);
    image(img,0-w/2,0-w/2,w+1,w+1);
    popMatrix();
  }
  void killBody() {
    box2d.destroyBody(this.body);
  }
  //rebond de la balle lors de collision
   void bumpAway(Vec2 normal)
  {
    normal.normalize();
    //vecteur dans la direction opposé
    Vec2 pushForce = normal.mul(-400);
    this.body.applyLinearImpulse(pushForce, this.body.getPosition(), true);
  }
  //fonction pour detecter si la balle est hors champ
  boolean horsChamp(){
    Vec2 position = box2d.getBodyPixelCoord(body);
    return position.y>height;
  }
  //réinit de la balle
  Balle reset(){
    vies--;
    killBody();
    return new Balle(width-25, height-150);  
  }
}
