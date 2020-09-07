void initimage(PGraphics pg) {
}

PGraphics last;
PGraphics original;
PImage img;
void setup() {

  size(700,700);
  background(0);

  /*
   * Load image and draw it on a PGraphics with effects.
   * Blurring the original image removes some of the
   * unnecessary details from the image and seems to
   * provide better results.
   */
  original = createGraphics(width, height);
  img = loadImage("me.jpg");
  img.resize(width,height);
  original.beginDraw();
  original.image(img, 0, 0);
  //original.filter(GRAY);
  original.filter(BLUR, 2);
  original.endDraw();
  //image(original,0,0);
  KMeansSegmentation kms = new KMeansSegmentation(original,5);
  /* Run iterations until return value is 0 */
  while (kms.iteration() > 0);

  /* Get the final image and draw it on screen */
  image(kms.overlay(), 0, 0);
  saveFrame(); 
}

void draw() {}
