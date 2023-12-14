class Surface {
  ArrayList<Vec2> surface;
  float amplitude = 100; // Hauteur des vagues
  float wavelength =width; // Longueur d'onde des vagues
  int numPoints = width/2; // Nombre de points pour définir la vague
  Surface() {

    surface = new ArrayList<Vec2>();
    //1e et 2e point de la sortie vers la limite de la rampe
    surface.add(new Vec2(width/2+70, height));
    surface.add(new Vec2(width-35, height-75));
    //3e point de la limite de la rampe vers le bas du flipper
    surface.add(new Vec2(width-35, height));
    //paroie droite
    surface.add(new Vec2(width, height));
    surface.add(new Vec2(width, 150));
    //arc de cercle
    // Générer des points le long de l'axe x avec une hauteur y sinusoïdale
    for (int i = 0; i <= numPoints; i++) {
      float x = map(i, 0, numPoints, width, 0);
      float y = 151 - amplitude * sin(TWO_PI * i / wavelength);
      surface.add(new Vec2(x, y));
    }
    //derniers points vers le bas gauche du flipper
    surface.add(new Vec2(0, height-75));
    surface.add(new Vec2(width/2-70, height));
    ChainShape chain = new ChainShape();

    // tableau de Vec2 pour la ChainShape.
    Vec2[] vertices = new Vec2[surface.size()];


    for (int i = 0; i < vertices.length; i++) {
      //[offset-up] Convert each vertex to Box2D World coordinates.
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }

    // creation de la chainShape avec le tableau de vertices.
    chain.createChain(vertices, vertices.length);

    //fixture
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);
    
  }
  void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    //dessiner le ChainShape comme des series de vertices.
    beginShape();
    for (Vec2 v : surface) {
      vertex(v.x, v.y);
    }
    endShape();
  }
}