class Pokemon extends PlateForme {
  PImage imgLeft1, imgLeft2, imgRight1, imgRight2, img;
  boolean isMovingLeft = true;
  boolean toggleImage = true;
  AudioPlayer charge;
  public Pokemon(int posX, int posY, BodyType bt, float _w, float _h) {
    super(posX, posY, bt, _w, _h);
    //4 images pour l'animation
    imgLeft1 = loadImage("evoli_left1-min.png");
    imgLeft2 = loadImage("evoli_left2-min.png");
    imgRight1 = loadImage("evoli_right1-min.png");
    imgRight2 = loadImage("evoli_right2-min.png");
    //image par defaut
    img = imgRight1;
    charge = minim.loadFile("charge.mp3");
    createBody();
  }
  void display() {
    Vec2 position = box2d.getBodyPixelCoord(this.body);
    pushMatrix();
    translate(position.x, position.y);
    image(img, 0-40/2, 0-40/2, 40, 40);
    popMatrix();
  }
  //alternate pour changer l'image selon le mouvement
  void alternate() {
    //changement d'image toutes les 10 frames
    if (frameCount % 10 == 0) {
      if (isMovingLeft) {
        img = toggleImage ? imgLeft1 : imgLeft2;
      } else {
        img = toggleImage ? imgRight1 : imgRight2;
      }
      // Bascule entre les deux états d'animation
      toggleImage = !toggleImage;
    }
  }
  //deplacement de gauche a droite du pokemon
  void deplacement() {
    Vec2 position = box2d.getBodyPixelCoord(body);
    if (position.x >=  width/2-40) {
      this.isMovingLeft = false;
      this.body.setLinearVelocity(new Vec2(-10, 0));
    } else if (position.x <= width/2-100) {
      this.isMovingLeft = true;
      this.body.setLinearVelocity(new Vec2(10, 0));
    }
    alternate();
  }
  
  void charge() {
    //son lors de la collision
    charge.setGain(10.0f);
     if (charge.isPlaying()) {
      charge.rewind();
      charge.play();
    } else {
      charge.play();
      charge.rewind();
    }
    //petite charge du pokemon lors d'une collision
    if (this.isMovingLeft) {
      this.body.setLinearVelocity(new Vec2(15, 0));
    } else {
      this.body.setLinearVelocity(new Vec2(-15, 0));
    }
  }
}
